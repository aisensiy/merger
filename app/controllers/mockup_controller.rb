class MockupController < ApplicationController
  def index
    @industries = Industry.where('id < 6')
  end

  def select_attrs
    @industry_id = params[:industry_id]
  end

  def buyer
    @attrs = params[:buyer_attrs]

    session[:buyer_attrs] = @attrs
    session[:target_attrs] = params[:target_attrs]
    session[:industry_id] = params[:industry_id]

    @industry = Industry.find(params[:industry_id])
    @buyers = Buyer.where(industry_id: params[:industry_id])
                   .includes(:industry, :deals)
                   .select do |buyer|
                     buyer.deals.count > 0
                   end
  end

  def similar_buyer
    @buyer_ids = params[:ids]
    @attrs = session[:buyer_attrs] || params[:buyer_attrs]

    session[:selected_buyers] = @buyer_ids

    @industry_id = session[:industry_id] || params[:industry_id]
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

  def similar_target
    @industry = Industry.find(session[:industry_id] || params[:industry_id])
    @attrs = session[:target_attrs]
    @buyer_ids = session[:selected_buyers]
    @targets = Deal.where('buyer_id in (?)', @buyer_ids)
                   .includes(target: [:industry]).map(&:target)

    @candidate_targets = Target.where('is_sold = ? and industry_id = ?',
                                       false,
                                       @targets[0].industry_id)

    @result = Target.similar_targets(@targets, @candidate_targets, @attrs).map { |v| v[0] }
  end
end
