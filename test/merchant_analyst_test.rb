require_relative 'test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'


class MerchantAnalystTest < MiniTest::Test

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

  def test_it_returns_merchants_list
    assert_equal 5, sales_analyst.merchants_list.length
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.2, sales_analyst.average_items_per_merchant
  end

  def test_it_finds_how_many_items_one_merchant_has_when_merchant_has_items
    assert_equal 2, sales_analyst.items_count(44434165)
  end

  def test_it_finds_how_many_items_one_merchant_has_when_merchant_has_zero_items
    assert_equal 0, sales_analyst.items_count(99999999)
  end

  def test_it_makes_array_for_how_many_items_each_merchant_has
    result = sales_analyst.items_per_merchant_list
    assert_equal [2, 6, 2, 1, 0], result
  end

  def test_it_finds_average_items_per_merchant_standard_deviation
    assert_equal 2.28, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_lists_merchants_with_item_count_over_one_standard_devation
    result = sales_analyst.merchants_with_high_item_count
    assert_equal 1, result.count
    assert_equal 12334303, result.first.id
  end

  def test_average_item_price_for_merchant_when_merchant_has_items
    result = sales_analyst.average_item_price_for_merchant(12334303)
    assert_equal 7.13, result.to_f
  end

  def test_average_item_price_for_merchant_when_merchant_has_zero_items
    result = sales_analyst.average_item_price_for_merchant(99999999)
    assert_equal 0, result.to_f
  end

  def test_average_average_price_per_merchant
    #Based on fixture files: [4.13, 7.13, 8.75, 0]
    result = sales_analyst.average_average_price_per_merchant
    assert_equal 5.89, result.to_f
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
    assert_equal 5, actual.count
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

  def test_merchants_ranked_by_revenue
    actual = sales_analyst.merchants_ranked_by_revenue
    assert_equal Merchant, actual.first.class
    assert_equal 5, actual.count
  end

end