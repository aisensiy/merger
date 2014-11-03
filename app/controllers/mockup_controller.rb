class MockupController < ApplicationController
  def index
    @industries = Industry.all
  end

  def buyer
    @buyers = Buyer.includes(:industry).limit(50)
  end

  def buy
    @targets = Target.includes(:industry).limit(50)
  end

  def target
    @targets = Target.includes(:industry).limit(50)
  end
end
