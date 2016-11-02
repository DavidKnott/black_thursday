require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/invoice'
require 'pry'

class InvoiceTest < Minitest::Test

  attr_reader   :invoice,
                :test_invoice_info

  def setup
    @test_invoice_info = {:id => 1,
                                :customer_id => 1,
                                :merchant_id => 12335938,
                                :status => "pending",
                                :created_at => 2009-02-07,
                                :updated_at => 2014-03-15}
    @invoice = Invoice.new(test_invoice_info, "parent")
  end

  def test_it_stores_parent
    assert_equal "parent", invoice.parent
  end

  def test_it_stores_id
    assert_equal 1, invoice.id
  end

  def test_it_stores_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_it_stores_merchant_id
    assert_equal 12335938, invoice.merchant_id
  end

  def test_it_stores_status
    assert_equal "pending", invoice.status
  end

  def test_it_stores_created_at
    assert_equal 2009-02-07, invoice.created_at
  end

  def test_it_stores_updated_at
    assert_equal 2014-03-15, invoice.updated_at
  end

  def test_invoice_calls_parent
    parent = MiniTest::Mock.new
    invoice = Invoice.new(test_invoice_info, parent)
    parent.expect(:find_merchant_by_merchant_id, nil, [test_invoice_info[:merchant_id]])
    invoice.merchant
    parent.verify
  end


end
