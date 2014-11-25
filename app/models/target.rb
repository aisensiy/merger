class Target < ActiveRecord::Base
  include SimilarCalculatable

  has_one :deal
  belongs_to :industry
end
