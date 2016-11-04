require_relative 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader    :test_item_repo

  def setup
    @test_item_repo = ItemRepository.new("./data/items.csv", "parent")
  end

  def test_initialize_item_repository
    assert test_item_repo
  end

  def test_creates_item_list
    refute_empty test_item_repo.items_list
  end

  def test_item_list_stores_items
    assert_equal Item, test_item_repo.items_list.first.class
  end

  def test_all_method_returns_all_items
    assert_equal 1367, test_item_repo.all.length
  end

  def test_finds_item_by_id
    assert_equal 263565894, test_item_repo.find_by_id(263565894).id
  end

  def test_does_not_find_item_by_id_and_returns_nil
    assert_equal nil, test_item_repo.find_by_id(263561111)
  end


  def test_finds_item_by_name
    actual = test_item_repo.find_by_name("Root Chakra Feather Earrings").name
    assert_equal "Root Chakra Feather Earrings", actual
  end

  def test_does_not_find_item_by_name_and_returns_nil
    actual = test_item_repo.find_by_name("Hulk Toy")
    assert_equal nil, actual
  end

  def test_finds_all_items_whos_description_includes_given_string
    actual = test_item_repo.find_all_with_description("special")
    assert_equal 80, actual.length
  end

  def test_returns_empty_array_if_no_items_include_given_string
    actual = test_item_repo.find_all_with_description("non-existent")
    assert_equal [], actual
  end

  def test_finds_all_items_with_given_price
    actual = test_item_repo.find_all_by_price(60).first
    assert_equal 60.0, actual.unit_price.to_f
  end

  def test_returns_empty_array_if_no_items_match_given_price
    actual = test_item_repo.find_all_by_price(5997)
    assert_equal [], actual
  end

  def test_finds_all_prices_in_given_range
    actual = test_item_repo.find_all_by_price_in_range(50..55)
    assert_equal 50.0, actual[3].unit_price.to_f
  end

  def test_returns_empty_array_if_no_items_match_given_price_range
    actual = test_item_repo.find_all_by_price_in_range(5253..5255)
    assert_equal [], actual
  end

  def test_finds_all_items_matching_given_merchant_id
    actual = test_item_repo.find_all_by_merchant_id(12334397)
    assert_equal 12334397, actual.first.merchant_id
  end

  def test_returns_empty_array_if_no_items_match_given_merchant_id
    actual = test_item_repo.find_all_by_merchant_id(12331111)
    assert_equal [], actual
  end

  def test_item_repo_calls_parent
    parent = MiniTest::Mock.new
    item_repo = ItemRepository.new("./data/items_one.csv", parent)
    parent.expect(:find_merchant, nil, [26])
    item_repo.find_merchant(26)
    parent.verify
  end
end