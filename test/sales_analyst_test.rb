require_relative 'test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'


class SalesAnalystTest < MiniTest::Test

  attr_reader     :sales_analyst,
                  :sales_analyst_full

  def setup
    # test_file_list = {:merchants => "./data/merchants.csv",
    #                   :items => "./data/items.csv",
    #                   :invoices => "./data/invoices.csv"}
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

  # def test_it_exists
  #   assert sales_analyst
  # end

  # def test_it_returns_merchants_list
  #   assert_equal 475, sales_analyst.merchants_list.length
  # end

  # def test_it_returns_items_list
  #   assert_equal 1367, sales_analyst.items_list.length
  # end

  # def test_it_finds_average_items_per_merchant
  #   assert_equal 2.88, sales_analyst.average_items_per_merchant
  # end

  # def test_it_finds_how_many_items_one_merchant_has
  #   assert_equal 1, sales_analyst.items_count(12334174)
  # end

  # def test_it_makes_array_for_how_many_items_each_merchant_has
  #   assert_equal 475, sales_analyst.items_per_merchant_list.count
  # end

  # def test_it_finds_average_items_per_merchant_standard_deviation
  #   skip
  #   assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  # end

  # def test_it_lists_merchants_with_item_count_over_one_standard_devation
  #   # skip
  #   assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  # end

  # def test_average_item_price_for_merchant
  #   #Unit prices for this merchant as from CSV file: 2390, 2390, 2390, 2390, 1890.
  #   test_average = sales_analyst.average_item_price_for_merchant(12334315)
  #   assert_equal 22.9, test_average.to_f 
  # end

  # def test_average_average_price_per_merchant_small_data_set
  #   #Unit prices from all merchants from merchants_small test file:
  #   # 0.16656666666666666666666666667E2
  #   # 0.15E2
  #   # 0.15E3
  #   # 0.2E2
  #   # 0.1E3
  #   # 0.35E2
  #   # 0.14E2
  #   # 0.12E2
  #   # 0.1499E2
  #   # 0.25E2
  #   # => [#<BigDecimal:7fbc298182f0,'0.1665666666 6666666666 666666667E2',36(45)>,
  #   #  #<BigDecimal:7fbc29813f20,'0.15E2',9(36)>,
  #   #  #<BigDecimal:7fbc298139f8,'0.15E3',9(36)>,
  #   #  #<BigDecimal:7fbc29813570,'0.2E2',9(36)>,
  #   #  #<BigDecimal:7fbc298125d0,'0.1E3',9(36)>,
  #   #  #<BigDecimal:7fbc29812198,'0.35E2',9(36)>,
  #   #  #<BigDecimal:7fbc29811c20,'0.14E2',9(36)>,
  #   #  #<BigDecimal:7fbc29811770,'0.12E2',9(36)>,
  #   #  #<BigDecimal:7fbc298113b0,'0.1499E2',18(45)>,
  #   #  #<BigDecimal:7fbc29810be0,'0.25E2',9(36)>]
  #   test_average = sales_analyst_small.average_average_price_per_merchant
  #   assert_equal 40.27, test_average.round(2).to_f
  # end

  # def test_average_average_price_per_merchant_complete_data_set
  #   skip #Candidate to move to integration test!!!
  #   test_average = sales_analyst.average_average_price_per_merchant
  #   assert_equal 350.29, test_average.round(2).to_f
  # end

  # def test_golden_items_on_small_data_set
  #   test_golden_item_list = sales_analyst_small.golden_items
  #   assert_equal Item, test_golden_item_list.first.class
  #   assert_equal 263410685, test_golden_item_list.first.id
  #   assert_equal "Test listing", test_golden_item_list.first.name
  # end

  # def test_average_invoices_per_merchant
  #   test_average_invoice = sales_analyst.average_invoices_per_merchant
  #   test_average_invoice_expected = 10.49
  #   assert_equal test_average_invoice_expected, test_average_invoice
  # end

  # def test_average_invoices_per_merchant_standard_deviation
  #   test_average_invoice = sales_analyst.average_invoices_per_merchant_standard_deviation
  #   test_average_invoice_expected = 3.29
  #   assert_equal test_average_invoice_expected, test_average_invoice
  # end

  # def test_top_merchants_by_invoice_count
  #   test_top_merchants = sales_analyst.top_merchants_by_invoice_count
  #   test_top_merchants_expected_id = 12334141
  #   test_top_merchants_expected_name = "jejum"
  #   assert_equal Array, test_top_merchants.class
  #   assert_equal test_top_merchants_expected_id, test_top_merchants.first.id
  #   assert_equal test_top_merchants_expected_name, test_top_merchants.first.name
  # end

  # def test_bottom_merchants_by_invoice_count
  #   test_bottom_merchants = sales_analyst.bottom_merchants_by_invoice_count
  #   test_bottom_merchants_expected_id = 12334235
  #   test_bottom_merchants_expected_name = "WellnessNeelsen"
  #   assert_equal Array, test_bottom_merchants.class
  #   assert_equal test_bottom_merchants_expected_id, test_bottom_merchants.first.id
  #   assert_equal test_bottom_merchants_expected_name, test_bottom_merchants.first.name
  # end

  # def test_top_days_by_invoice_count
  #   test_top_days = sales_analyst.top_days_by_invoice_count
  #   test_top_days_expected = ["Wednesday"]
  #   test_top_days_expected_day = "Wednesday"
  #   assert_equal Array, test_top_days.class
  #   assert_equal test_top_days_expected, test_top_days
  #   assert_equal test_top_days_expected_day, test_top_days.first    
  # end

  # def test_invoice_status
  #   test_invoice_status_pending = sales_analyst.invoice_status(:pending)
  #   test_invoice_status_shipped = sales_analyst.invoice_status(:shipped)
  #   test_invoice_status_returned = sales_analyst.invoice_status(:returned)
  #   assert_equal Float, test_invoice_status_pending.class
  #   assert_equal 29.55, test_invoice_status_pending
  #   assert_equal 56.95, test_invoice_status_shipped
  #   assert_equal 13.5, test_invoice_status_returned
  #   assert_equal 100, test_invoice_status_pending + test_invoice_status_returned + test_invoice_status_shipped
  # end




#Testing with TEST FIXTURES

#done
  def test_it_exists
    assert sales_analyst
  end

#done
  def test_it_returns_merchants_list
    assert_equal 4, sales_analyst.merchants_list.length
  end

#done
  def test_it_returns_items_list
    assert_equal 11, sales_analyst.items_list.length
  end

#done
  def test_it_finds_average_items_per_merchant
    assert_equal 2.75, sales_analyst.average_items_per_merchant
  end

#done
  def test_it_finds_how_many_items_one_merchant_has
    assert_equal 2, sales_analyst.items_count(44434165)
  end

#done
  def test_it_makes_array_for_how_many_items_each_merchant_has
    result = sales_analyst.items_per_merchant_list
    assert_equal [2, 6, 2, 1], result
  end

#done
  def test_it_finds_average_items_per_merchant_standard_deviation
    assert_equal 2.22, sales_analyst.average_items_per_merchant_standard_deviation
  end

#done
  def test_it_lists_merchants_with_item_count_over_one_standard_devation
    result = sales_analyst.merchants_with_high_item_count
    assert_equal 1, result.count
    assert_equal 12334303, result.first.id
  end

#done
  def test_average_item_price_for_merchant
    result = sales_analyst.average_item_price_for_merchant(12334303)
    assert_equal 7.13, result.to_f 
  end

#done
  def test_average_average_price_per_merchant
    #Based on fixture files: [4.13, 7.13, 8.75]
    result = sales_analyst.average_average_price_per_merchant
    assert_equal 7.37, result.to_f
  end

#done
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

#done
  def test_average_invoices_per_merchant
    #Based on fixture files [3, 6, 3]
    result = sales_analyst.average_invoices_per_merchant
    assert_equal 3, result
  end

#done
  def test_average_invoices_per_merchant_standard_deviation
    result = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 2.45, result
  end

#done
  def test_top_merchants_by_invoice_count
    result = sales_analyst_full.top_merchants_by_invoice_count
    result_expected_id = 12334141
    result_expected_name = "jejum"
    assert_equal Array, result.class
    assert_equal result_expected_id, result.first.id
    assert_equal result_expected_name, result.first.name
  end

#done
  def test_bottom_merchants_by_invoice_count
    result = sales_analyst_full.bottom_merchants_by_invoice_count
    result_expected_id = 12334235
    result_expected_name = "WellnessNeelsen"
    assert_equal Array, result.class
    assert_equal result_expected_id, result.first.id
    assert_equal result_expected_name, result.first.name
  end

#done
  def test_top_days_by_invoice_count
    result = sales_analyst.top_days_by_invoice_count
    result_expected = ["Saturday"]
    result_expected_day = "Saturday"
    assert_equal Array, result.class
    assert_equal result_expected, result
    assert_equal result_expected_day, result.first
  end

#done
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

  def test_finds_total_revenue_of_merchant
    actual = sales_analyst.revenue_by_merchant(22222222)
    assert_equal BigDecimal, actual.class
    assert_equal 452.85, actual
  end

  def test_finds_most_sold_item_for_merchant
    actual = sales_analyst.most_sold_item_for_merchant(22222222)
    assert_equal Item, actual.first.class
    assert_equal 2, actual.count
  end

  def test_finds_best_item_for_merchant
    actual = sales_analyst.best_item_for_merchant(22222222)
    assert_equal Item, actual.class
    assert_equal 563399361, actual.id
  end

  #what we think is right
  # def test_finds_total_revenue_by_date
  #   actual = @sales_analyst.total_revenue_by_date(Time.parse("2012-02-26"))
  #   assert_equal BigDecimal, actual.class
  #   assert_equal 619.7, actual
  # end

  def test_finds_total_revenue_by_date
    actual = sales_analyst.total_revenue_by_date(Time.parse("2009-01-07"))
    assert_equal BigDecimal, actual.class
    assert_equal 32, actual
  end

  def test_finds_total_revenue_by_date_as_zero
    actual = sales_analyst.total_revenue_by_date(Time.parse("2012-02-24"))
    assert_equal 0, actual
  end

  def test_finds_top_revenue_earners
    actual = sales_analyst.top_revenue_earners(10)
    assert_equal Merchant, actual.first.class
    assert_equal 4, actual.count
  end

  def test_finds_merchants_with_pending_invoices
    actual = sales_analyst.merchants_with_pending_invoices
    assert_equal Merchant, actual.first.class
    assert_equal 3, actual.count
  end

  def test_finds_merchants_with_only_one_item
    actual = sales_analyst.merchants_with_only_one_item
    assert_equal Merchant, actual.first.class
    assert_equal 1, actual.count
  end

  def test_merchants_with_only_one_item_registered_in_month
    actual = sales_analyst.merchants_with_only_one_item_registered_in_month("May")
    assert_equal Merchant, actual.first.class
    assert_equal 1, actual.count
  end
end