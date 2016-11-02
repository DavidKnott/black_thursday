require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  attr_reader   :test_config

  def setup
    @test_config = {:merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv"}
  end

  def test_with_non_existing_csv
    assert_raises "Please enter a valid file name" do
    se = SalesEngine.from_csv({:items => "./data/magic.csv"})
    end
  end

  def test_merchantrepository_exists
    se = SalesEngine.from_csv(test_config)
    assert se.merchants    
  end

  def test_item_repository_exists
    se = SalesEngine.from_csv(test_config)
    assert se.items
  end

  def test_merchant_repository_exists
    se = SalesEngine.from_csv(test_config)
    assert se.items
  end

  def test_invoice_repository_exists
    se = SalesEngine.from_csv(test_config)
    assert se.invoices
  end

  def test_it_calls_merchant_repo_and_finds_merchants_by_merchant_id
    se = SalesEngine.from_csv(test_config)
    assert_equal 12334159, se.find_merchant_by_merchant_id(12334159).id
  end

  def test_it_calls_item_repo_and_finds_items_by_merchant_id
    se = SalesEngine.from_csv(test_config)
    assert_equal 263453479,se.find_items_by_merchant_id(12334159).first.id
  end

  def test_it_calls_invoice_repo_and_finds_invoices_by_merchant_id
    se = SalesEngine.from_csv(test_config)
    assert_equal 234,se.find_invoices_by_merchant_id(12334159).first.id
  end




end