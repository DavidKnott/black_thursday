require_relative 'test_helper'
require './lib/item'

class ItemTest < MiniTest::Test

  attr_reader   :test_item,
                :test_time1,
                :test_time2,
                :test_item_info

  def setup
    @test_time1 = "2016-01-11 11:44:13 UTC"
    @test_time2 = "1990-10-06 04:14:15 UTC"
    @test_item_info = {:name => "Pencil",
                            :description => "You can use it to write things",
                            :unit_price  => 1099,
                            :created_at  => test_time1,
                            :updated_at  => test_time2,
                            :id => 5,
                            :merchant_id => 55}
    @test_item = Item.new(test_item_info, "parent")
  end

  def test_initializes_item
    assert test_item
  end

  def test_it_stores_id
    assert_equal 5, test_item.id
  end

  def test_it_stores_name
    assert_equal "Pencil", test_item.name
  end

  def test_it_stores_description
    assert_equal "You can use it to write things", test_item.description
  end

  def test_it_stores_unit_price
    assert_equal BigDecimal, test_item.unit_price.class
    assert_equal BigDecimal("10.99"), test_item.unit_price
  end

  def test_it_stores_created_at
    assert_equal Time.parse(test_time1), test_item.created_at
  end

  def test_it_stores_updated_at
    assert_equal Time.parse(test_time2), test_item.updated_at
  end

  def test_it_stores_merchant_id
    assert_equal 55, test_item.merchant_id
  end

  def test_unit_price_to_dollars
    assert_equal Float, test_item.unit_price_to_dollars.class
    assert_equal 10.99, test_item.unit_price_to_dollars
  end

  def test_item_calls_parent
    parent = MiniTest::Mock.new
    item = Item.new(test_item_info, parent)
    parent.expect(:find_merchant, nil, [test_item_info[:merchant_id]])
    item.merchant
    parent.verify
  end

end