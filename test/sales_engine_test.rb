require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  attr_reader   :se

  def setup
    @se = SalesEngine.from_csv({:merchants => "./data/merchants.csv",
                    :items => "./data/items.csv",
                    :invoices => "./data/invoices.csv",
                    :invoice_items => "./data/invoice_items.csv",
                    :transactions => "./data/transactions.csv",
                    :customers => "./data/customers.csv"})
  end

  def test_with_non_existing_csv
    assert_raises "Please enter a valid file name" do
      SalesEngine.from_csv({:items => "./data/magic.csv"})
    end
  end

  def test_merchant_repository_exists
    assert se.merchants    
  end

  def test_item_repository_exists
    assert se.items
  end

  def test_invoice_repository_exists
    assert se.invoices
  end

  def test_invoice_items_repository_exists
    assert se.invoice_items
  end

  def test_transactions_repository_exists
    assert se.transactions
  end

  def test_customers_repository_exists
    assert se.customers
  end

  def test_it_calls_merchant_repo_and_finds_merchants_by_merchant_id
    assert_equal 12334159, se.find_merchant(12334159).id
  end

  def test_it_calls_item_repo_and_finds_items_by_merchant_id
    assert_equal 263453479,se.find_items(12334159).first.id
  end

  def test_it_calls_invoice_repo_and_finds_invoices_by_merchant_id
    assert_equal 234, se.find_invoices(12334159).first.id
  end

  def test_it_calls_items_repo_and_finds_items_by_invoice_id
    assert_equal 27, se.find_invoice_items(6).first.id
  end

  def test_it_calls_transaction_repo_and_finds_transactions_by_invoice_id
    assert_equal 2871,se.find_transactions_by_invoice_id(6).first.id
  end

  def test_it_calls_customer_repo_and_finds_customer_by_merchant_id
    assert_equal 26,se.find_customer(26).id
  end

  def test_it_calls_invoice_repo_and_finds_invoice_by_invoice_id
    assert_equal 26,se.find_invoice(26).id
  end
end