require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < MiniTest::Test

  attr_reader   :test_merchant

  def setup
    test_data = {:id => 26, :name => "Laszlo and David Boulder School"}
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

  def test_merchant_calls_parent_to_find_items
    parent = MiniTest::Mock.new
    merchant = Merchant.new({:id => 5, :name => "Turing School"}, parent)
    parent.expect(:find_items, nil, [5])
    merchant.items
    parent.verify
  end

  def test_merchant_calls_parent_to_find_invoices
    parent = MiniTest::Mock.new
    merchant = Merchant.new({:id => 5, :name => "Turing School"}, parent)
    parent.expect(:find_invoices, nil, [5])
    merchant.invoices
    parent.verify
  end


end