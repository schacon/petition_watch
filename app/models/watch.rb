class Watch < ActiveRecord::Base
  belongs_to :user
  validates :term, :length => { :minimum => 3 }
end
