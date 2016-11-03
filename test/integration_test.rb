require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'

class IntegrationTest < Minitest::Test
  attr_reader :se,
              :test_merchant,
              :test_customer

  def setup
    @se = SalesEngine.from_csv({:merchants => "./data/merchants.csv",
                    :items => "./data/items.csv",
                    :invoices => "./data/invoices.csv",
                    :invoice_items => "./data/invoice_items.csv",
                    :transactions => "./data/transactions.csv",
                    :customers => "./data/customers.csv"})
    @test_merchant = se.merchants.find_by_id(12334671)
    @test_customer = se.customers.find_by_id(40)
  end

  #START of SalesEngine related tests

  # def test_it_can_find_merchant_from_item
  #   item = se.items.find_by_id(263405705)
  #   assert_equal 12334671, item.merchant.id
  # end

  # def test_it_can_find_items_from_merchant
  #   test_result = test_merchant.items
  #   assert_equal Item, test_result.first.class
  # end

  # def test_it_can_find_invoices_from_merchant
  #   merchant = se.merchants.find_by_id(12334671)
  #   assert_equal 207, merchant.invoices.first.id
  # end

  # def test_it_can_find_invoices_for_merchant
  #   test_result = test_merchant.invoices
  #   assert_equal Invoice, test_result.first.class
  # end

  # def test_find_customer_for_merchant
  #   test_result = test_merchant.customers
  #   assert_equal Customer, test_result.first.class
  # end

  # def test_find_customer_for_merchant
  #   test_result = test_customer.merchants
  #   assert_equal Merchant, test_result.first.class
  # end

  # def test_it_can_find_merchant_from_invoice
  #   invoice = se.invoices.find_by_id(207)
  #   assert_equal 12334671, invoice.merchant.id
  # end

  # def test_it_can_find_invoice_items_from_invoice
  #   invoice = se.invoices.find_by_id(207)
  #   assert_equal 4427, invoice.transactions.first.id
  # end

  # def test_it_can_find_transactions_from_invoice
  #   invoice = se.invoices.find_by_id(207)
  #   assert_equal 4427, invoice.transactions.first.id
  # end

  # def test_it_can_find_customer_from_invoice
  #   invoice = se.invoices.find_by_id(207)
  #   assert_equal 40, invoice.customer.id
  # end

  # def test_it_can_find_invoice_from_transaction
  #   transaction = se.transactions.find_by_id(207)
  #   assert_equal 4531, transaction.invoice.id
  # end

  def test_if_invoice_is_paid_in_full
    invoice = se.transactions.find_by_id(207).invoice
    assert invoice.is_paid_in_full?
  end


  #END of SalesEngine related tests

  #START of SalesAnalyst related tests

  def test_average_average_price_per_merchant
    # se = SalesEngine.from_csv({:items => "./data/items.csv", 
    #                             :merchants => "./data/merchants.csv"})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 350.29, sales_analyst.average_average_price_per_merchant.round(2).to_f
  end
  
  #END of SalesAnalyst related tests


end