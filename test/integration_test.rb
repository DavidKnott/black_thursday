require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class IntegrationTest < Minitest::Test
  attr_reader :se,
              :test_merchant,
              :test_customer,
              :test_invoice,
              :test_invoice_failed,
              :test_transaction

  def setup
    test_file_list = {:merchants => "./data/merchants_fixture.csv",
                    :items => "./data/items_fixture.csv",
                    :invoices => "./data/invoices_fixture.csv",
                    :invoice_items => "./data/invoice_items_fixture.csv",
                    :transactions => "./data/transactions_fixture.csv",
                    :customers => "./data/customers_fixture.csv"}
    @se = SalesEngine.from_csv(test_file_list)
    @test_merchant = se.find_merchant(12334303)
    @test_customer = se.find_customer(7)
    @test_invoice = se.find_invoice(3)
    @test_invoice_failed = se.find_invoice(8)
    @test_transaction = se.find_transaction(6)
  end

  def test_it_can_find_items_from_merchant
    result = test_merchant.items
    assert_equal Item, result.first.class
    assert_equal 6, result.count
    assert_equal 163399361, result.first.id
    assert_equal 106339936, result.last.id
  end

  def test_it_can_find_invoices_from_merchant
    result = test_merchant.invoices
    assert_equal Invoice, result.first.class
    assert_equal 6, result.count
    assert_equal 1, result.first.id
    assert_equal 12, result.last.id
  end

  def test_find_customer_for_merchant
    result = test_merchant.customers
    assert_equal Customer, result.first.class
    assert_equal 3, result.count
    assert_equal 6, result.first.id
    assert_equal 1, result.last.id
  end

  def test_find_merchant_for_customer
    result = test_customer.merchants
    assert_equal Merchant, result.first.class
    assert_equal 2, result.count
    assert_equal 22222222, result.first.id
    assert_equal 44434165, result.last.id
  end

  def test_it_can_find_merchant_from_invoice
    result = test_invoice.merchant
    assert_equal Merchant, result.class
    assert_equal 22222222, result.id
  end

  def test_it_can_find_transactions_from_invoice
    result = test_invoice.transactions
    assert_equal Transaction, result.first.class
    assert_equal 1, result.count
    assert_equal 7, result.first.id
    assert_equal 7, result.last.id
  end

  def test_it_can_find_customer_from_invoice
    result = test_invoice.customer
    assert_equal Customer, result.class
    assert_equal 7, result.id
  end

  def test_it_can_find_invoice_from_transaction
    result = test_transaction.invoice
    assert_equal Invoice, result.class
    assert_equal 2, result.id
  end

  def test_if_invoice_is_paid_in_full_success
    assert test_invoice.is_paid_in_full?
  end

  def test_if_invoice_is_paid_in_full_failed
    refute test_invoice_failed.is_paid_in_full?
  end

  def test_it_can_find_items_related_to_invoice
    result = test_invoice.items
    assert_equal Item, result.first.class
    assert_equal 3, result.count
    assert_equal 463399361, result.first.id
    assert_equal 563399361, result.last.id
  end

end