class Petition < ActiveRecord::Base
  has_many :watch_matches
  has_many :watches, :through => :watch_matches
  validates :pid, :uniqueness => true
end
