class Watch < ActiveRecord::Base
  belongs_to :user
  has_many :watch_matches
  has_many :petitions, :through => :watch_matches, :order => "signatures desc"
  validates :term, :length => { :minimum => 3 }

  def find_matches
    if last_check
      checkp = Petition.where("created_time > ?", last_check)
    else
      checkp = Petition.all
    end

    # get a list of pids we've already matched
    pids = {}
    petitions.each { |p| pids[p.pid] = true }

    matches = []
    checkp.each do |pet|
      next if pids[pet.pid]
      pattern = Regexp.new(term)
      match = false
      if pattern =~ pet.title
        match = :title
      elsif pattern =~ pet.body
        match = :body
      elsif pattern =~ pet.issues
        match = :issues
      end

      if match
        petitions << pet
        matches << pet
      end
    end

    latest_date = Petition.maximum('created_time')
    last_check = latest_date
    save

    matches
  end
end
