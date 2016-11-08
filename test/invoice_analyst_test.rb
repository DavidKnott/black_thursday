require_relative 'test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'


class InvoiceAnalystTest < MiniTest::Test

  attr_reader     :sales_analyst,
                  :sales_analyst_full

  def setup
    test_file_list = {:merchants => "./data/merchants_fixture.csv",
                      :items => "./data/items_fixture.csv",
                      :invoices => "./data/invoices_fixture.csv",
                      :invoice_items => "./data/invoice_items_fixture.csv",
                      :transactions => "./data/transactions_fixture.csv",
                      :customers => "./data/customers_fixture.csv"}
    sales_engine = SalesEngine.from_csv(test_file_list)
    @sales_analyst = SalesAnalyst.new(sales_engine)

    test_full_file_list = {:merchants => "./data/merchants.csv",
                            :items => "./data/items.csv",
                            :invoices => "./data/invoices.csv"}
    sales_engine_full = SalesEngine.from_csv(test_full_file_list)
    @sales_analyst_full = SalesAnalyst.new(sales_engine_full)    
  end

  def test_average_invoices_per_merchant
    result = sales_analyst.average_invoices_per_merchant
    assert_equal 2.4, result
  end

  def test_average_invoices_per_merchant_standard_deviation
    result = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 2.51, result
  end

  def test_top_merchants_by_invoice_count
    result = sales_analyst_full.top_merchants_by_invoice_count
    result_expected_id = 12334141
    result_expected_name = "jejum"
    assert_equal Array, result.class
    assert_equal result_expected_id, result.first.id
    assert_equal result_expected_name, result.first.name
  end

  def test_bottom_merchants_by_invoice_count
    result = sales_analyst_full.bottom_merchants_by_invoice_count
    result_expected_id = 12334235
    result_expected_name = "WellnessNeelsen"
    assert_equal Array, result.class
    assert_equal result_expected_id, result.first.id
    assert_equal result_expected_name, result.first.name
  end

  def test_top_days_by_invoice_count
    result = sales_analyst.top_days_by_invoice_count
    result_expected = ["Saturday"]
    result_expected_day = "Saturday"
    assert_equal Array, result.class
    assert_equal result_expected, result
    assert_equal result_expected_day, result.first
  end

  def test_invoice_status
    result_pending = sales_analyst.invoice_status(:pending)
    result_shipped = sales_analyst.invoice_status(:shipped)
    result_returned = sales_analyst.invoice_status(:returned)
    assert_equal Float, result_pending.class
    assert_equal 33.33, result_pending
    assert_equal 33.33, result_shipped
    assert_equal 33.33, result_returned
    assert_equal 99.99, result_pending + result_returned + result_shipped
  end
  
end