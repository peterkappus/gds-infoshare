class Benefit < ActiveRecord::Base
  belongs_to :department
  belongs_to :organisation
  belongs_to :product
  belongs_to :state
  has_many :benefit_years, dependent: :destroy #destroy years when benefit gets deleted
  #enum state: {targeted:0, planned:1, estimated:2, evidenced:3}
  #default_scope { order(created_at: :desc) }


  def total_value_cents
    benefit_years.map{|year| year.target_value_cents}.reduce(:+).to_i
  end

  def total_value
    total_value_cents/100
  end

  #TODO: generalise this into a concern...
  def self.import(file)
    require 'csv' #probably should put this at the top, but I don't *always* want to include it... Some smarter way to bundle this up?

    required_cols = %w(product name department	organisation	location	original_offering	non_cts_alternative	cts_proposal	state	notes	evidence)

    #subtract supplied columns from required columns to see if any are missing
    missing_cols = required_cols - CSV.read(file.path,headers: true).headers

    if(!missing_cols.empty?)
      return "Missing columns: #{missing_cols.join(", ")}"
    else

      #WATCH OUT! :) Import replaces everything!
      Benefit.destroy_all
      Department.destroy_all
      Product.destroy_all

      CSV.foreach(file.path, headers: true) do |row|
        next if(row[required_cols[0]] == 'n/a' || row[required_cols[0]].nil?)

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

        record.department = Department.where(name: row['department']).first_or_create unless row['department'].to_s.empty?

        product_name = row['product'].to_s.gsub(/ - CTS\d+/,'')

        project_code = (row['product'].to_s.match(/CTS\d+/)).to_a[0]

        #create new product
        product = Product.where(name: product_name).first_or_create

        #assign proj code to product
        product.project_code = project_code
        product.save!

        #now assign to our record
        record.product = product

        state = State.where(name: row['state']).first_or_create
        record.state = state
        
        #hacky way to get our enum value
        # TODO: Make this freetext until our states settle down...
        #record.state = Benefit.states[row['state'].downcase]

        #save the record and add the child benefit years
        if(record.save!)
          #check the next 10 years...
          [*(Time.now.year..Time.now.year+10)].each do |year|
            if(row["fy_ending_#{year}"])
              #clean out any cents which might have been included... and any non numeric chars
              value = row["fy_ending_#{year}"].gsub(/\..+$/,'').gsub(/\D/,'').to_i
              benefit_year = BenefitYear.create!(fy_end_date:Date.new(year,3,31), target_value_cents: value)
              #puts row["fy_ending_#{year}"]
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
