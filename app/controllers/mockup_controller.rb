class MockupController < ApplicationController
  def index
    @industries = Industry.where('id < 6')
  end

  def select_buyer_attrs
    @industry_id = params[:industry_id]
  end

  def buyer
    @industry = Industry.find(params[:industry_id])
    @attrs = params[:selected_attrs]
    @buyers = Buyer.where(industry_id: params[:industry_id])
                   .includes(:industry, :deals)
                   .select do |buyer|
                     buyer.deals.count > 0
                   end
  end

  def similar_buyer
    @buyer_ids = params[:ids]
    @attrs = params[:selected_attrs]
    @industry_id = params[:industry_id]
    @buyers = Buyer.find(@buyer_ids)
    @candidate_buyers = Buyer.where('industry_id = ?', @industry_id)
                             .includes(:deals, :industry).select do |buyer|
                                buyer.deals.count == 0
                             end
    @result = @buyers.map do |buyer|
      buyer.similar_buyers(@candidate_buyers, @attrs)
    end.reduce(&:+).map { |v| v[0] }.uniq
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
    avg_total_assets = @targets.map(&:total_assets).reduce(&:+) / @target_ids.size
    @candidate_targets = Target.where('total_assets > ? and total_assets < ? and is_sold = ? and industry_id = ?',
                                       avg_total_assets * 0.7,
                                       avg_total_assets * 1.3,
                                       false,
                                       @targets[0].industry_id)
  end
end
