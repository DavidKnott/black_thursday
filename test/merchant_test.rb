require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < MiniTest::Test

  attr_reader   :test_merchant,
                :test_data

  def setup
    @test_data = {:id => 26,
                :name => "Laszlo and David Boulder School",
                :created_at => "1990-10-06" }
    @test_merchant = Merchant.new(test_data, "parent")
  end

  def test_initializes_merchant
    assert test_merchant
  end

  def test_it_stores_id
    assert_equal 26, test_merchant.id
  end

  def test_it_stores_name
    assert_equal "Laszlo and David Boulder School", test_merchant.name
  end

  def test_it_stores_created_at
    assert_equal Time.parse("1990-10-06"), test_merchant.created_at
  end

  def test_merchant_calls_parent_to_find_items
    parent = MiniTest::Mock.new
    merchant = Merchant.new(test_data, parent)
    parent.expect(:find_items, nil, [test_data[:id]])
    merchant.items
    parent.verify
  end

  def test_merchant_calls_parent_to_find_invoices
    parent = MiniTest::Mock.new
    merchant = Merchant.new(test_data, parent)
    parent.expect(:find_invoices, nil, [test_data[:id]])
    merchant.invoices
    parent.verify
  end

end