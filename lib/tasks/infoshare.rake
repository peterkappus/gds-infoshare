namespace :infoshare do
  desc "Load my custom fixtures to popluate the database. Not quite Factory Girl..."
  namespace :test do

    task users: [:environment, :warn] do
      #remove only the test accounts we've created.
      #this leaves any accounts we've created by logging in manually
      User.where("email like ?","%test.com%").destroy_all

      #admin user
      User.create!(name: 'Suzy Admin', admin: true, email: "email0@test.com")

      #some other users
      [*(1..20)].each do |i|
        User.create!(name: %w{Cindy Ada Jane Barbara Ann Benjamin Walter Alexis Simone Marina Oscar Julia Mark Lazlo Ray Lucretia Tom Peter Sarah Ringo John}.sample + " " + %w{Smith Jones Taylor Gibran Peterson Williams Mott Eames Johnson Davies Robinson Wright Knight Thompson Evans Walker White Roberts Green Hall Wood Jackson Clarke}.sample + " " + i.to_s, email: "email#{i}@test.com")
      end
    end

    task departments: [:environment] do
      Department.destroy_all
      #departments
      [*(10..20)].sample.times do
        #won't create duplicates... but means you might not get the full number
        Department.find_or_create_by!(name: ["Ministry of", "Department for","Office of"].sample + " " + ["Getting Down", "Aquarian Studies", "Apples", "Rock & Roll", "Abstract Art", "Fine Dining", "Hedgehogs", "Wizardry", "Parkour", "Sound", "Ice Cream", "Funny Walks", "Beanie Hats"].sample)
      end
    end

    task clean: [:environment] do
      Organisation.destroy_all
      Contract.destroy_all
      Department.destroy_all
      Portfolio.destroy_all
      Person.destroy_all
      #Don't destroy users...
    end

    task warn: [] do
      puts "WARNING: This may erase/overwrite existing data. Press enter to continue."
      STDIN.gets
    end

  end
end
