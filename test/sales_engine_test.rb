require_relative 'test_helper'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test

  attr_reader   :se,
                :test_magic_file_list

  def setup
    # test_file_list = {:merchants => "./data/merchants.csv",
    #                 :items => "./data/items.csv",
    #                 :invoices => "./data/invoices.csv",
    #                 :invoice_items => "./data/invoice_items.csv",
    #                 :transactions => "./data/transactions.csv",
    #                 :customers => "./data/customers.csv"}
    test_file_list = {:merchants => "./data/merchants_fixture.csv",
                    :items => "./data/items_fixture.csv",
                    :invoices => "./data/invoices_fixture.csv",
                    :invoice_items => "./data/invoice_items_fixture.csv",
                    :transactions => "./data/transactions_fixture.csv",
                    :customers => "./data/customers_fixture.csv"}
    @test_magic_file_list = {:merchants => "./data/merchants_magic.csv",
                    :items => "./data/items_magic.csv",
                    :invoices => "./data/invoices_magic.csv",
                    :invoice_items => "./data/invoice_items_magic.csv",
                    :transactions => "./data/transactions_magic.csv",
                    :customers => "./data/customers_magic.csv"}                    
    @se = SalesEngine.from_csv(test_file_list)
  end

  def test_with_non_existing_csv
    assert_raises "Please enter a valid file name" do
      SalesEngine.from_csv(test_magic_file_list)
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

  # def test_it_calls_merchant_repo_and_finds_merchants_by_merchant_id
  #   assert_equal 12334159, se.find_merchant(12334159).id
  # end

  # def test_it_calls_item_repo_and_finds_items_by_merchant_id
  #   assert_equal 263453479,se.find_items(12334159).first.id
  # end

  # def test_it_calls_invoice_repo_and_finds_invoices_by_merchant_id
  #   assert_equal 234, se.find_invoices(12334159).first.id
  # end

  # def test_it_calls_items_repo_and_finds_items_by_invoice_id
  #   assert_equal 27, se.find_invoice_items(6).first.id
  # end

  # def test_it_calls_transaction_repo_and_finds_transactions_by_invoice_id
  #   assert_equal 2871,se.find_transactions(6).first.id
  # end

  # def test_it_calls_customer_repo_and_finds_customer_by_merchant_id
  #   assert_equal 26,se.find_customer(26).id
  # end

  # def test_it_calls_invoice_repo_and_finds_invoice_by_invoice_id
  #   assert_equal 26,se.find_invoice(26).id
  # end


#Tests using TEST FIXTURES
  def test_it_calls_merchant_repo_and_finds_merchants_by_merchant_id
    assert_equal "MerchantName12334303", se.find_merchant(12334303).name
  end

#NEW-DONE
  def test_it_calls_items_repo_and_finds_merchant_of_item
    result = se.find_item(663399361)
    assert_equal 22222222, result.merchant_id
  end

  def test_it_calls_item_repo_and_finds_items_by_merchant_id
    assert_equal 363399361,se.find_items(22222222).first.id
  end

  def test_it_calls_invoice_repo_and_finds_invoices_by_merchant_id
    assert_equal 5, se.find_invoices(44434165).first.id
  end

  def test_it_calls_invoice_items_repo_and_finds_items_by_invoice_id
    assert_equal 6, se.find_invoice_items(5).first.id
  end

  def test_it_calls_transaction_repo_and_finds_transactions_by_invoice_id
    assert_equal 5,se.find_transactions(6).first.id
  end

  def test_it_calls_customer_repo_and_finds_customer_by_customer_id
    assert_equal "FirstName3",se.find_customer(3).first_name
  end

  def test_it_calls_invoice_repo_and_finds_invoice_by_invoice_id
    assert_equal 44434165,se.find_invoice(5).merchant_id
  end

end