require 'test_helper'

class TargetTest < ActiveSupport::TestCase
  setup do
    @target = build :target
  end

  test 'should have one deal' do
    assert @target.respond_to?(:deal)
  end
end
