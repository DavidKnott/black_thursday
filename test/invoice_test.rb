require_relative 'test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader   :invoice,
                :test_invoice_info

  def setup
    @test_invoice_info = {:id => 1,
                                :customer_id => 2,
                                :merchant_id => 12335938,
                                :status => "pending",
                                :created_at => "2009-02-07",
                                :updated_at => "2014-03-15"}
    @invoice = Invoice.new(test_invoice_info, "parent")
  end

  def test_it_stores_parent
    assert_equal "parent", invoice.parent
  end

  def test_it_stores_id
    assert_equal 1, invoice.id
  end

  def test_it_stores_customer_id
    assert_equal 2, invoice.customer_id
  end

  def test_it_stores_merchant_id
    assert_equal 12335938, invoice.merchant_id
  end

  def test_it_stores_status
    assert_equal :pending, invoice.status
  end

  def test_it_stores_created_at
    assert_equal Time.parse("2009-02-07"), invoice.created_at
  end

  def test_it_stores_updated_at
    assert_equal Time.parse("2014-03-15"), invoice.updated_at
  end

  def test_invoice_calls_parent_for_merchant
    parent = MiniTest::Mock.new
    invoice = Invoice.new(test_invoice_info, parent)
    parent.expect(:find_merchant, nil, [test_invoice_info[:merchant_id]])
    invoice.merchant
    parent.verify
  end

  def test_invoice_calls_parent_for_invoice_items
    parent = MiniTest::Mock.new
    invoice = Invoice.new(test_invoice_info, parent)
    parent.expect(:find_invoice_items, nil, [test_invoice_info[:id]])
    invoice.invoice_items
    parent.verify
  end

  def test_invoice_calls_parent_for_transactions
    parent = MiniTest::Mock.new
    invoice = Invoice.new(test_invoice_info, parent)
    parent.expect(:find_transactions, nil, [test_invoice_info[:id]])
    invoice.transactions
    parent.verify
  end

  def test_invoice_calls_parent_for_customer
    parent = MiniTest::Mock.new
    invoice = Invoice.new(test_invoice_info, parent)
    parent.expect(:find_customer, nil, [test_invoice_info[:customer_id]])
    invoice.customer
    parent.verify
  end

end
