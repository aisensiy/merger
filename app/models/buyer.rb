class Buyer < ActiveRecord::Base
  has_many :deals
  belongs_to :industry
end
