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
    :from => 'Petition Watch <schacon+petitionwatch@gmail.com>'
  }
end

namespace :search do

  task :reset_checks => :environment do
    Watch.all.each { |w| w.last_check = nil; w.save }
    WatchMatch.all.each { |wm| wm.destroy }
  end

  desc "Look for unknown matches and email people"
  task :find_matches => :environment do
    watches = Watch.all
    watches.each do |watch|
      puts "Checking '#{watch.term}'"

      matches = watch.find_matches

      if matches.size > 0
        # alert user
        watch.last_alert = Time.now
        matches.each do |match|
          pemail += '## Petition: ' + match.title + " ##\n\n"
          pemail += match.body + "\n\n"
          pemail += match.issues + "\n\n"
          pemail += "View it here: " + match.url + "\n\n"
          pemail += "Sign it here: https://petitions.whitehouse.gov/petition/sign/" + match.pid 
          Pony.mail(:to => watch.user.email,
                :subject => "New Petition on '#{watch.term}'",
                :body => pemail)
          puts '  ' + match.id.to_s + ' ' + match.pid.to_s + ' ' + match.title[0, 50]
        end
      end
    end
  end
end
