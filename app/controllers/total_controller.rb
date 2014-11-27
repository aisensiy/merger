class TotalController < ApplicationController
  def select_industry
    @industries = Industry.where('id < 6')
  end

  def select_attrs
    @industry_id = params[:industry_id]
  end

  def select_reference_buyers
    @buyer_attrs = params[:buyer_attrs]

    session[:buyer_attrs] = @buyer_attrs
    session[:target_attrs] = params[:target_attrs]
    session[:industry_id] = params[:industry_id]

    @industry = Industry.find(params[:industry_id])
    @buyers = Buyer.where(industry_id: params[:industry_id])
    .includes(:industry, :deals)
    .select do |buyer|
      buyer.deals.count > 0
    end
  end

  def get_similar_buyers
    buyer_ids = params[:ids]
    @buyer_attrs = session[:buyer_attrs] || params[:buyer_attrs]

    session[:reference_buyer_ids] = buyer_ids

    industry_id = session[:industry_id] || params[:industry_id]
    @industry = Industry.find(industry_id)
    @reference_buyers = Buyer.find(buyer_ids)
    candidate_buyers = Buyer.where('industry_id = ?', industry_id)
    .includes(:deals, :industry).select do |buyer|
      buyer.deals.count == 0
    end
    @result = @reference_buyers.map do |buyer|
      buyer.similar_buyers(candidate_buyers, @buyer_attrs)
    end.reduce(&:+).map { |v| v[0] }.uniq
  end

    def get_similar_targets
    @buyer_attrs = session[:buyer_attrs] || params[:buyer_attrs]
    @target_attrs = session[:target_attrs]
    @industry = Industry.find(session[:industry_id] || params[:industry_id])

    reference_buyer_ids = session[:reference_buyer_ids]
    @reference_buyers = Buyer.find(reference_buyer_ids)

    @selected_buyer = Buyer.find(session[:selected_buyer])

    @targets = Deal.where('buyer_id in (?)', reference_buyer_ids)
    .includes(target: [:industry]).map(&:target)
    @candidate_targets = Target.where('is_sold = ? and industry_id = ?',
                                      false,
                                      @targets[0].industry_id)

    @result = Target.similar_targets(@targets, @candidate_targets, @target_attrs).map { |v| v[0] }
  end

  def show_result

  end
end
