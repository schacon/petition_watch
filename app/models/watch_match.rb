class WatchMatch < ActiveRecord::Base
  belongs_to :watch
  belongs_to :petition
end
