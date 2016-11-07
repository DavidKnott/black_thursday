require_relative 'test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'


class ItemAnalystTest < MiniTest::Test

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


  def test_it_returns_items_list
    assert_equal 11, sales_analyst.items_list.length
  end

  def test_golden_items
    #Based on Fixture files:
    #Item priced: [3,4.15,5,10,20,3.25,2,4.15,7.5,9.45]
    #Average: 6.85
    #Std_dev: 5.36796
    result = sales_analyst.golden_items
    assert_equal Item, result.first.class
    assert_equal 563399361, result.first.id
    assert_equal "Item name for 563399361", result.first.name
    assert_equal BigDecimal("20.00"), result.first.unit_price
  end

  
end