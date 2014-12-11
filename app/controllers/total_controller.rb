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
    selected_buyer_id = params[:selected_buyer_id]
    session[:selected_buyer_id] = selected_buyer_id

    @buyer_attrs = session[:buyer_attrs] || params[:buyer_attrs]
    @target_attrs = session[:target_attrs]
    @industry = Industry.find(session[:industry_id] || params[:industry_id])

    reference_buyer_ids = session[:reference_buyer_ids]
    @reference_buyers = Buyer.find(reference_buyer_ids)

    @selected_buyer = Buyer.find(selected_buyer_id)

    @targets = Deal.where('buyer_id in (?)', reference_buyer_ids).includes(target: [:industry]).map(&:target)
    @candidate_targets = Target.where('is_sold = ? and industry_id = ?',
                                      false,
                                      @targets[0].industry_id)

    @result = Target.similar_targets(@targets, @candidate_targets, @target_attrs).map { |v| v[0] }
  end

  def show_result
    selected_target_id = params[:selected_target_id]
    session[:selected_target_id] = selected_target_id
    @selected_target = Target.find(selected_target_id)

    @buyer_attrs = session[:buyer_attrs]
    @target_attrs = session[:target_attrs]

    @industry = Industry.find(session[:industry_id])
    @reference_buyers = Buyer.find(session[:reference_buyer_ids])
    @selected_buyer = Buyer.find(session[:selected_buyer_id])
  end

  def search_buyers
    @target_search_attrs = APP_CONFIG['target_attrs']
    @industries = Bargain.select('target_industry').uniq.map(&:target_industry)
  end

  def search_buyers_result
    @target_attrs = params[:target_attrs]
    @buyer_attrs = APP_CONFIG['buyer_attrs']
    candidate_bargains = Bargain.where(target_industry: @target_attrs[:target_industry])
    target_attrs = @target_attrs.dup
    target_attrs.delete(:target_industry)
    similar_bargains = Bargain.similar_with_index(candidate_bargains, target_attrs).map { |v| v[0] }
    similar_buyers = BuyerV2.where('stock_code in (?)', similar_bargains.map(&:buyer_stock_code).uniq)
    @result = BuyerV2.similar(BuyerV2.where('industry in (?)', similar_buyers.map(&:industry).uniq), similar_buyers, @buyer_attrs).map { |v| v[0] }
  end

  def search_targets
    @buyer_search_attrs = APP_CONFIG['buyer_attrs']
    @industries = Bargain.select('buyer_industry').uniq.map(&:buyer_industry)
  end

  def search_targets_result
    @buyer_attrs = params[:buyer_attrs]
    @target_attrs = APP_CONFIG['target_attrs']
    # get ref with same industry
    reference_bargains = Bargain.where(buyer_industry: @buyer_attrs[:buyer_industry])
    # get buyer mapping bargain
    reference_buyers = BuyerV2.where('stock_code in (?)', reference_bargains.map(&:buyer_stock_code).uniq)
    # get knn from buyer
    buyer_attrs = @buyer_attrs.dup
    buyer_attrs.delete(:buyer_industry)
    similar_buyers = BuyerV2.similar_with_index(reference_buyers, buyer_attrs).map { |v| v[0] }
    # get target with knn buyer in bargain
    reference_targets = Bargain.where('buyer_stock_code in (?)', similar_buyers.map(&:stock_code))
    # get similar target with is_sold false
    candidate_targets = TargetV2.where('is_sold = ? and target_industry in (?)', false, reference_targets.map(&:target_industry))
    @result = TargetV2.similar(candidate_targets, reference_targets, @target_attrs)
  end
end
