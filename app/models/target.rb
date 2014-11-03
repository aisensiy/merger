class Target < ActiveRecord::Base
  has_one :deal
  belongs_to :industry
end
