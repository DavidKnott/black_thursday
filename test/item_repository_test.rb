require_relative 'test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader    :test_item_repo

  def setup
    @test_item_repo = ItemRepository.new("./data/items_fixture.csv", "parent")
  end

  def test_item_repo_calls_parent
    parent = MiniTest::Mock.new
    item_repo = ItemRepository.new("./data/items_one.csv", parent)
    parent.expect(:find_merchant, nil, [26])
    item_repo.find_merchant(26)
    parent.verify
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
    assert_equal 11, test_item_repo.count_all
  end

  def test_finds_item_by_id
    assert_equal "Item name findall for 763399361", test_item_repo.find_by_id(763399361).name
  end

  def test_does_not_find_item_by_id_and_returns_nil
    assert_equal nil, test_item_repo.find_by_id(999)
  end

  def test_finds_item_by_name
    result = test_item_repo.find_by_name("iTEM NamE fOr 863399361").id
    assert_equal 863399361, result
  end

  def test_does_not_find_item_by_name_and_returns_nil
    result = test_item_repo.find_by_name("Hulk Toy")
    assert_equal nil, result
  end

  def test_finds_all_items_whos_description_includes_given_string
    result = test_item_repo.find_all_with_description("aLL fO")
    assert_equal Item, result.first.class
    assert_equal 2, result.length
    assert_equal 263399361, result.first.id
  end

  def test_returns_empty_array_if_no_items_include_given_string
    result = test_item_repo.find_all_with_description("non-existent")
    assert_empty result
  end

  def test_finds_all_items_with_given_price
    result = test_item_repo.find_all_by_price(4.15)
    assert_equal Item, result.first.class
    assert_equal 2, result.count
    assert_equal "Item description for 863399361", result.last.description
  end

  def test_returns_empty_array_if_no_items_match_given_price
    result = test_item_repo.find_all_by_price(59.97)
    assert_empty result
  end

  def test_finds_all_prices_in_given_range
    result = test_item_repo.find_all_by_price_in_range(2.50..9.99)
    assert_equal Item, result.first.class
    assert_equal 8, result.count
    assert_equal 112687325, result.last.id
  end

  def test_returns_empty_array_if_no_items_match_given_price_range
    result = test_item_repo.find_all_by_price_in_range(5253..5255)
    assert_empty result
  end

  def test_finds_all_items_matching_given_merchant_id
    result = test_item_repo.find_all_by_merchant_id(22222222)
    assert_equal Item, result.first.class
    assert_equal 2, result.count
    assert_equal "Item name for 363399361", result.first.name
  end

  def test_returns_empty_array_if_no_items_match_given_merchant_id
    result = test_item_repo.find_all_by_merchant_id(999)
    assert_empty result
  end

end