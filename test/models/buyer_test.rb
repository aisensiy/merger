require 'test_helper'

class BuyerTest < ActiveSupport::TestCase
  setup do
    @buyer = build :buyer
  end

  test 'should have many deals' do
    assert @buyer.respond_to?(:deals)
  end

  test 'should belong industry' do
    assert @buyer.respond_to?(:industry)
  end
end
