require 'pony'

if ENV['SENDGRID_USERNAME']
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    },
    :from => 'schacon@gmail.com'
  }
end

namespace :search do
  desc "Look for unknown matches and email people"
  task :find_matches => :environment do
    latest_date = Petition.maximum('created_time')
    watches = Watch.all
    watches.each do |watch|
      if watch.last_check
        checkp = Petition.where("created_time > ?", watch.last_check)
      else
        checkp = Petition.all
      end
      puts "Checking '#{watch.term}' againt #{checkp.size} petitions"

      matches = []
      checkp.each do |pet|
        pattern = Regexp.new(watch.term)
        match = false
        if pattern =~ pet.title
          match = :title
        elsif pattern =~ pet.body
          match = :body
        elsif pattern =~ pet.issues
          match = :issues
        end

        if match
          matches << pet
        end
      end

      if matches.size > 0
        # alert user
        #watch.last_alert = Time.now
        matches.each do |match|
          pemail = "The following petition matches your watch:\n\n"
          pemail += match.title + "\n\n"
          pemail += "-------------\n"
          pemail += match.body + "\n\n"
          pemail += match.issues + "\n\n"
          pemail += "View it here: " + match.url + "\n"
          pemail += "Sign it here: https://petitions.whitehouse.gov/petition/sign/" + match.pid 
          Pony.mail(:to => watch.user.email,
                :subject => "New Petition on '#{watch.term}'",
                :body => pemail)
          puts '  ' + match.id.to_s + ' ' + match.pid.to_s + ' ' + match.title[0, 50]
        end
      end

      #watch.last_check = latest_date
      #watch.save
      puts
    end
  end
end
