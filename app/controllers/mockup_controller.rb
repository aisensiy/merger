class MockupController < ApplicationController
  def index
    @industries = Industry.all
  end

  def buyer
    @industry = Industry.find(params[:industry_id])
    @buyers = Buyer.where(industry_id: params[:industry_id]).includes(:industry)
  end

  def similar_buyer
    @buyer_ids = params[:buyer_ids]
    @buyers = Buyer.find(@buyer_ids)
    @candidate_buyers = Buyer.where(industry_id: @buyers[0].industry_id)
                             .where('id not in (?)', @buyer_ids)
                             .includes(:deals, :industry).select do |buyer|
                                buyer.deals.count > 0
                             end
  end

  def buy
  end

  def target
    @buyer_ids = params[:buyer_ids]
    @targets = Deal.where('buyer_id in (?)', @buyer_ids)
                   .includes(target: [:industry]).map(&:target)
  end

  def similar_target
    @target_ids = params[:target_ids]
    @targets = Target.where(id: @target_ids).includes(:industry)
    avg_total_assets = @targets.map(&:total_assets).reduce(&:+)
    @candidate_targets = Target.where('total_assets > ? and total_assets < ? and is_sold = ? and industry_id = ?',
                                       avg_total_assets * 0.7,
                                       avg_total_assets * 1.3,
                                       false,
                                       @targets[0].industry_id)
  end
end
