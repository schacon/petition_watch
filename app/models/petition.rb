class Petition < ActiveRecord::Base
  validates :pid, :uniqueness => true
end
