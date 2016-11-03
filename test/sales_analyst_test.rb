require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'


class SalesAnalystTest < MiniTest::Test

  attr_reader     :sales_analyst,
                  :sales_analyst_small

  def setup
    test_file_list = {:merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv"}
    sales_engine = SalesEngine.from_csv(test_file_list)
    @sales_analyst = SalesAnalyst.new(sales_engine)

    test_small_file_list = {:merchants => "./data/merchants_small.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv"}
    sales_engine_small = SalesEngine.from_csv(test_small_file_list)
    @sales_analyst_small = SalesAnalyst.new(sales_engine_small)    
  end

  def test_it_exists
    assert sales_analyst
  end


  def test_it_returns_merchants_list
    assert_equal 475, sales_analyst.merchants_list.length
  end


  def test_it_returns_items_list
    assert_equal 1367, sales_analyst.items_list.length
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_it_finds_how_man_items_one_merchant_has
    assert_equal 1, sales_analyst.items_per_merchant(12334174)
  end

  def test_it_makes_array_for_how_many_items_each_merchant_has
    assert_equal 475, sales_analyst.items_per_merchant_list.count
  end

  def test_it_finds_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_lists_merchants_with_item_count_over_one_standard_devation
    skip
    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    #Unit prices for this merchant as from CSV file: 2390, 2390, 2390, 2390, 1890.
    test_average = sales_analyst.average_item_price_for_merchant(12334315)
    assert_equal 22.9, test_average.to_f 
  end

  def test_average_average_price_per_merchant_small_data_set
    #Unit prices from all merchants from merchants_small test file:
    # 0.16656666666666666666666666667E2
    # 0.15E2
    # 0.15E3
    # 0.2E2
    # 0.1E3
    # 0.35E2
    # 0.14E2
    # 0.12E2
    # 0.1499E2
    # 0.25E2
    # => [#<BigDecimal:7fbc298182f0,'0.1665666666 6666666666 666666667E2',36(45)>,
    #  #<BigDecimal:7fbc29813f20,'0.15E2',9(36)>,
    #  #<BigDecimal:7fbc298139f8,'0.15E3',9(36)>,
    #  #<BigDecimal:7fbc29813570,'0.2E2',9(36)>,
    #  #<BigDecimal:7fbc298125d0,'0.1E3',9(36)>,
    #  #<BigDecimal:7fbc29812198,'0.35E2',9(36)>,
    #  #<BigDecimal:7fbc29811c20,'0.14E2',9(36)>,
    #  #<BigDecimal:7fbc29811770,'0.12E2',9(36)>,
    #  #<BigDecimal:7fbc298113b0,'0.1499E2',18(45)>,
    #  #<BigDecimal:7fbc29810be0,'0.25E2',9(36)>]
    test_average = sales_analyst_small.average_average_price_per_merchant
    assert_equal 40.27, test_average.round(2).to_f
  end

  def test_average_average_price_per_merchant_complete_data_set
    skip #Candidate to move to integration test!!!
    test_average = sales_analyst.average_average_price_per_merchant
    assert_equal 350.29, test_average.round(2).to_f
  end

  def test_golden_items_on_small_data_set
    skip
    test_golden_item_list = sales_analyst_small.golden_items
    assert_equal '', test_golden_item_list
  end

  def test_average_invoices_per_merchant
    test_average_invoice = sales_analyst.average_invoices_per_merchant
    test_average_invoice_expected = 10.49
    assert_equal test_average_invoice_expected, test_average_invoice
  end

  def test_average_invoices_per_merchant_standard_deviation
    test_average_invoice = sales_analyst.average_invoices_per_merchant_standard_deviation
    test_average_invoice_expected = 3.29
    assert_equal test_average_invoice_expected, test_average_invoice
  end

  def test_top_merchants_by_invoice_count
    test_top_merchants = sales_analyst.top_merchants_by_invoice_count
    test_top_merchants_expected_id = 12334141
    test_top_merchants_expected_name = "jejum"
    assert_equal Array, test_top_merchants.class
    assert_equal test_top_merchants_expected_id, test_top_merchants.first.id
    assert_equal test_top_merchants_expected_name, test_top_merchants.first.name
  end

  def test_bottom_merchants_by_invoice_count
    test_bottom_merchants = sales_analyst.bottom_merchants_by_invoice_count
    test_bottom_merchants_expected_id = 12334235
    test_bottom_merchants_expected_name = "WellnessNeelsen"
    assert_equal Array, test_bottom_merchants.class
    assert_equal test_bottom_merchants_expected_id, test_bottom_merchants.first.id
    assert_equal test_bottom_merchants_expected_name, test_bottom_merchants.first.name
  end

  def test_top_days_by_invoice_count
    test_top_days = sales_analyst.top_days_by_invoice_count
    test_top_days_expected = ["Wednesday"]
    test_top_days_expected_day = "Wednesday"
    assert_equal Array, test_top_days.class
    assert_equal test_top_days_expected, test_top_days
    assert_equal test_top_days_expected_day, test_top_days.first    
  end

  def test_invoice_status
    test_invoice_status_pending = sales_analyst.invoice_status(:pending)
    test_invoice_status_shipped = sales_analyst.invoice_status(:shipped)
    test_invoice_status_returned = sales_analyst.invoice_status(:returned)
    assert_equal Float, test_invoice_status_pending.class
    assert_equal 29.55, test_invoice_status_pending
    assert_equal 56.95, test_invoice_status_shipped
    assert_equal 13.5, test_invoice_status_returned
    assert_equal 100, test_invoice_status_pending + test_invoice_status_returned + test_invoice_status_shipped
  end

end
