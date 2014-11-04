class MockupController < ApplicationController
  def index
    @industries = Industry.all
  end

  def buyer
    @buyers = Buyer.includes(:industry).limit(50)
  end

  def buy
    @deals = Deal.includes(target: :industry, buyer: :industry)
  end

  def target
    @targets = Target.includes(:industry).limit(50)
  end
end
