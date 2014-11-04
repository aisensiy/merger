class MockupController < ApplicationController
  def index
    @industries = Industry.all
  end

  def buyer
    @industry = Industry.find(params[:industry_id])
    @buyers = Buyer.where(industry_id: params[:industry_id]).includes(:industry, :deals).limit(50)
  end

  def buy
    @buyer_ids = params[:buyer_ids]
    @deals = Deal.where(buyer_id: @buyer_ids).includes(target: :industry, buyer: :industry)
  end

  def target
    @target_ids = params[:target_ids]
    @targets = Target.where(id: @target_ids).includes(:industry)
    avg_total_assets = @targets.map(&:total_assets).reduce(&:+)
    @candidate_targets = Target.where('total_assets > ? and total_assets < ? and is_sold = ? and industry_id = ?',
                                       avg_total_assets * 0.8,
                                       avg_total_assets * 1.2,
                                       false,
                                       @targets[0].industry_id)
  end
end
