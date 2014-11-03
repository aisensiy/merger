require 'test_helper'

class DealTest < ActiveSupport::TestCase
  setup do
    @deal = build :deal
  end

  test 'should belong to buyer' do
    assert @deal.respond_to?(:buyer)
  end

  test 'should belong to target' do
    assert @deal.respond_to?(:target)
  end
end
