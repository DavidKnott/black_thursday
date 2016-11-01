require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader    :test_item_repo

  def setup
    @test_item_repo = ItemRepository.new("./data/items.csv")
  end

  def test_initialize_item_repository
    assert test_item_repo
  end

  def test_creates_item_list
    refute_empty test_item_repo.items_list
  end

  def test_item_list_stores_name
    assert_equal "Glitter scrabble frames", test_item_repo.items_list[1].name
  end

  def test_item_list_stores_id
    assert_equal "263399263", test_item_repo.items_list[26].id
  end

  def test_item_list_stores_description
    assert test_item_repo.items_list[26].description.start_with?("Acrylique sur toile exécu")
  end

  def test_item_list_stores_unit_price
    assert_equal 700, test_item_repo.items_list[3].unit_price.to_f
  end

  def test_item_list_stores_created_at
    assert_equal "2016-01-11 13:32:00 UTC", test_item_repo.items_list[56].created_at
  end

  def test_item_list_stores_updated_at
    assert_equal "1972-09-10 20:13:31 UTC", test_item_repo.items_list[49].updated_at
  end

  def test_item_list_stores_merchant_id
    assert_equal "12334183", test_item_repo.items_list[19].merchant_id
  end

end