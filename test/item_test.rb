require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/item'

class ItemTest < MiniTest::Test

  attr_reader   :test_item1,
                :test_item2,
                :test_time1,
                :test_time2

  def setup
    @test_time1 = Time.now - 10001100
    @test_time2 = Time.now - 20202020
    @test_item1 = Item.new({:name => "Pencil",
                            :description => "You can use it to write things",
                            :unit_price  => 10.99,
                            :created_at  => test_time1,
                            :updated_at  => test_time2,
                            :id => 5,
                            :merchant_id => 55})
    @test_item2 = Item.new({:name => "Potato",
                            :description => "Very yummy potato!",
                            :unit_price  => 3.85,
                            :created_at  => test_time2,
                            :updated_at  => test_time1,
                            :id => 26,
                            :merchant_id => 2626})
  end

  def test_initializes_item
    assert test_item1
    assert test_item2
  end

  def test_it_stores_id
    assert_equal 5, test_item1.id
    assert_equal 26, test_item2.id
  end

  def test_it_stores_name
    assert_equal "Pencil", test_item1.name
    assert_equal "Potato", test_item2.name
  end

  def test_it_stores_description
    assert_equal "You can use it to write things", test_item1.description
    assert_equal "Very yummy potato!", test_item2.description
  end

  def test_it_stores_created_at
    assert_equal test_time1, test_item1.created_at
    assert_equal test_time2, test_item2.created_at
  end

  def test_it_stores_updated_at
    assert_equal test_time2, test_item1.updated_at
    assert_equal test_time1, test_item2.updated_at
  end

  def test_it_stores_merchant_id
    assert_equal 55, test_item1.merchant_id
    assert_equal 2626, test_item2.merchant_id
  end

  def test_it_stores_unit_price
    assert_equal 10.99, test_item1.unit_price.to_f
    assert_equal 3.85, test_item2.unit_price.to_f
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, test_item1.unit_price_to_dollars
    assert_equal 3.85, test_item2.unit_price_to_dollars
  end



end