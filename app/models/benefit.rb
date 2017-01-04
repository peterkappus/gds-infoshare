class Benefit < ActiveRecord::Base
  belongs_to :department
  belongs_to :organisation
  belongs_to :product
  has_many :benefit_years, dependent: :destroy #destroy years when bene gets deleted
  enum state: {planned:0, targeted:1, estimated:2, evidenced:3}


  def total_value_cents
    benefit_years.map{|year| year.target_value_cents}.reduce(:+)
  end

  #TODO: generalise this into a concern...
  def self.import(file)
    require 'csv' #probably should put this at the top, but I don't *always* want to include it... Some smarter way to bundle this up?

    required_cols = %w(department	organisation	product	location	original_offering	non_cts_alternative	cts_proposal	state	notes	evidence)

    #subtract supplied columns from required columns to see if any are missing
    missing_cols = required_cols - CSV.read(file.path,headers: true).headers

    if(!missing_cols.empty?)
      return "Missing columns: #{missing_cols.join(", ")}"
    else

      #WATCH OUT! :) Import replaces everything!
      Benefit.destroy_all

      CSV.foreach(file.path, headers: true) do |row|
        next if row[required_cols[0]] == 'n/a'

        #new role to hold our values
        record = Benefit.new()

        #load up our object with data from each required column
        required_cols.each do |col_name|
          value = row[col_name]

          #skip columns which should be associations...
          #just assign string cols
          unless(/#{col_name}/ =~ 'department product organisation state')
            record.send("#{col_name}=",value)
          end

        end

        #strip pound signs and commas from money columns
        #record.value = Monetize.parse(row['value'])
        #record.annual_value = Monetize.parse(row['annual_value'])

        #find or create by short name...
        #TODO: DRY this up...
        record.organisation = Organisation.where(name: row['organisation']).first_or_create
        record.department = Department.where(name: row['department']).first_or_create
        record.product = Product.where(name: row['product']).first_or_create
        #hacky way to get our enum value
        record.state = Benefit.states[row['state']]

        #save the record and add the child benefit years
        if(record.save!)
          #check the next 10 years...
          [*(Time.now.year..Time.now.year+10)].each do |year|
            if(row["fy_ending_#{year}"])
              benefit_year = BenefitYear.create!(fy_end_date:Date.new(year,3,31), target_value_cents: row["fy_ending_#{year}"].to_i * 100)
              record.benefit_years<<benefit_year
              record.save!
            end
          end
        end
      end
    end

    #destroy any groups (and their teams) without roles
    #Group.all.map{|g| g.destroy if(g.roles.count <= 0)}
  end
end
