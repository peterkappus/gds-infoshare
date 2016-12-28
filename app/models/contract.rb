class Contract < ActiveRecord::Base
  include Filterable
  belongs_to :department
  belongs_to :organisation

  monetize :value_cents, :allow_nil => true
  monetize :annual_value_cents, :allow_nil => true

  scope :expired, -> { where("end_date < ?", Time.now)}
  scope :supplier_name, ->(name) { where supplier_name: name}
  scope :organisation_name, ->(name) { where organisation_name: name}
  scope :end_date_before, -> (end_date_before) {where "end_date < ?", Date.new(Date.parse(end_date_before).year+1,04,01)}
  scope :product, ->(name) { where product: name}



  def self.search(words)
    where("lower(notes) LIKE ?","%#{words.downcase}%")
  end

  def self.import(file)
    require 'csv' #probably should put this at the top, but I don't *always* want to include it... Some smarter way to bundle this up?

    required_cols = %w(reference source department_id supplier_name value end_date parent project product value start_date years sector annual_value category sub_contractors notes status year_awarded client)

    #subtract supplied columns from required columns to see if any are missing
    missing_cols = required_cols - CSV.read(file.path,headers: true).headers

    if(!missing_cols.empty?)
      return "Missing columns: #{missing_cols.join(", ")}"
    else

      #WATCH OUT! :) Import replaces everything!
      Contract.destroy_all

      CSV.foreach(file.path, headers: true) do |row|
        next if row[required_cols[0]] == 'n/a'

        #new role to hold our values
        record = Contract.new()

        #load up our object with data from each required column
        required_cols.each do |col_name|
          value = row[col_name]

          #skip columns which should be associations...
          #just assign string cols
          unless(/#{col_name}/ =~ 'client organisation person department parent')
            record.send("#{col_name}=",value)
          end

        end

        #strip pound signs and commas from money columns
        record.value = Monetize.parse(row['value'])
        #record.annual_value = Monetize.parse(row['annual_value'])

        #find or create by short name...
        #TODO: DRY this up...
        record.organisation = Organisation.where(name: row['client']).first_or_create
        record.department = Department.where(name: row['parent']).first_or_create
        record.organisation.department = record.department


        record.save!
      end
    end

    #destroy any groups (and their teams) without roles
    #Group.all.map{|g| g.destroy if(g.roles.count <= 0)}
  end

end
