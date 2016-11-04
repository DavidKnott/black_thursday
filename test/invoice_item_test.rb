require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemTest < MiniTest::Test

  attr_reader   :test_invoice_item

  def setup
  @test_invoice_item = InvoiceItem.new({
                      :id => 6,
                      :item_id => 7,
                      :invoice_id => 8,
                      :quantity => 1,
                      :unit_price => "10.99",
                      :created_at => "2012-03-27 14:54:09 UTC",
                      :updated_at => "2012-03-27 14:54:09 UTC"}, "parent")

  end 
  
  def test_initializes_invoice_item
    assert test_invoice_item
  end

  def test_it_stores_id
    assert_equal 6, test_invoice_item.id
  end

  def test_it_stores_item_id
    assert_equal 7, test_invoice_item.item_id
  end

  def test_it_stores_invoice_id
    assert_equal 8, test_invoice_item.invoice_id
  end

  def test_it_stores_quantity
    assert_equal 1, test_invoice_item.quantity
  end

  def test_it_stores_unit_price
    assert_equal BigDecimal("10.99")/100, test_invoice_item.unit_price
  end

  def test_it_stores_created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), test_invoice_item.created_at

  end

  def test_it_stores_updated_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), test_invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 0.11, test_invoice_item.unit_price_to_dollars
  end
  
end