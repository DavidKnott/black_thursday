require 'pry'
require_relative 'calculator'


class SalesAnalyst
  include Calculator

  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants_list
    sales_engine.merchants.merchants_list
  end

  def items_list
    sales_engine.items.items_list
  end

  def average_items_per_merchant
    total_items/total_merchants
  end

  def total_items
    items_list.length.to_f
  end

  def total_merchants
    merchants_list.length
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant_list.values, average_items_per_merchant)
  end


  def items_per_merchant_list
    linked_list = {}
    merchants_list.map do |merchant|
      linked_list[merchant] = items_per_merchant(merchant.id)
    end
    linked_list
  end

  def items_per_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    merchant.items.length
  end

  def merchants_with_high_item_count
    items_per_merchant_list.values.find_all do |items_for_one_merchant|
      items_for_one_merchant > average_items_per_merchant + average_items_per_merchant_standard_deviation
    end
  end

  def collect_item_prices(item_list)
    item_list.map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.find_merchant_by_merchant_id(merchant_id)
    item_list = merchant.items
    item_prices = collect_item_prices(item_list)
    average(item_prices)
  end

  def average_average_price_per_merchant
    all_merchants = BigDecimal(0)
    sales_engine.merchants.all.each do |merchant|
      merchant_average = average_item_price_for_merchant(merchant.id)
      all_merchants += merchant_average
    end
    all_merchants / sales_engine.merchants.all.count
  end

end