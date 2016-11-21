class Deployment < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :person
  belongs_to :department
  belongs_to :organisation


  def self.import(file)
    require 'csv' #probably should put this at the top, but I don't *always* want to include it... Some smarter way to bundle this up?

    required_cols = %w(portfolio	person	department	organisation	cts_initiative	location	tech_layer existing_solution	alternative_solution	cts_solution	benefit_type	state	comments)


    #subtract supplied columns from required columns to see if any are missing
    missing_cols = required_cols - CSV.read(file.path,headers: true).headers

    if(!missing_cols.empty?)
      return "Missing columns: #{missing_cols.join(", ")}"
    else

      #WATCH OUT! :) Import replaces everything!
      Deployment.destroy_all

      CSV.foreach(file.path, headers: true) do |row|
        next if row['portfolio'] == 'n/a'

        #new role to hold our values
        d = Deployment.new()

        #load up our object with data from each required column
        required_cols.each do |col_name|
          value = row[col_name]

          #cast monthly utilisation as floats (and convert nils to 0.0)
          #if(Role.MONTH_NAMES.include? col_name)
          #  value = value.to_f
          #end

          #skip columns which are actually associations...
          #just assign string cols
          unless(/#{col_name}/ =~ 'portfolio organisation person department')
            #puts col_name
            d.send("#{col_name}=",value)
          end

        end

        #strip pound signs and commas from monthly costs
        #r.monthly_cost = Monetize.parse(row['monthly_cost'])

        #find or create by short name...
        #TODO: DRY this up...
        d.organisation = Organisation.where(name: row['organisation']).first_or_create
        d.department = Department.where(name: row['department']).first_or_create
        d.person = Person.where(name: row['person']).first_or_create
        d.portfolio = Portfolio.where(name: row['portfolio']).first_or_create

        #eventually, we shouldn't associate roles directly to groups, just to teams
        #r.group = Group.where(name: row['group']).first_or_create

        #assign the team to the group (team's group will always be the last one... this is why we need to remove the direct role -> group association)

        #TODO: FIX THIS... untangle the associations
        d.organisation.department = d.department
        d.portfolio.person = d.person
        d.person.portfolio = d.portfolio

        #r.group.teams << r.team
        #r.staff_number = r.staff_number.sub(/.+?-\s+/,'')
         #anonymise by removing name portion

        #start/end dates
        #r.calculate_dates

        #ineficient as this saves the record again...
        #r.total_cost = 3000 #r.update_total_cost
        #r.total_cost_pennies = Role.MONTH_NAMES.map{|month| send(month).to_f}.reduce(:+) * monthly_cost
        #r.update_total_cost
        d.save!
        #end
      end
    end

    #destroy any groups (and their teams) without roles
    #Group.all.map{|g| g.destroy if(g.roles.count <= 0)}
  end

end
