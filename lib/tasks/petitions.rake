require 'wepeeps'
require 'awesome_print'

@peeps = WePeeps.new(ENV['WTP_KEY'])

namespace :petitions do
  desc "Load all the petitions into the db"
  task :load_all => :environment do
    petitions = @peeps.each do |pet|
      pid = pet["id"]
      p = Petition.find_by_pid(pid)
      if !p || ENV["RERUN_IMPORT"]
        puts "Processing #{pid}"
        p = Petition.new
        p.pid = pid
        p.title  = pet["title"]
        p.body   = pet["body"]
        p.url    = pet["url"]
        p.issues = pet["issues"].map { |a| a["name"] }.join(',')
        p.signatures = pet["signature count"]
        p.created_time = Time.at(pet["created"].to_i)
        p.answered = (pet["response"] != nil)
        p.save
      end
    end
    #ap petitions
  end
end
