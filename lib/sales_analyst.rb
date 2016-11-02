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
    (total_items/total_merchants).round(2)
  end

  def total_items
    items_list.length.to_f
  end

  def total_merchants
    merchants_list.length
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant_list)
  end

  def items_per_merchant_list
    item_count_list = merchants_list.map do |merchant|
      items_per_merchant(merchant.id)
    end
    return item_count_list
  end

  def items_per_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    merchant.items.length
  end

  def merchants_with_high_item_count
    items_per_merchant_list.find_all do |items_for_one_merchant|
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
    list_average(item_prices)
  end

  def average_average_price_per_merchant
    all_merchants = []
    sales_engine.merchants.all.each do |merchant|
      merchant_average = average_item_price_for_merchant(merchant.id)
      all_merchants << merchant_average
    end
    avg = list_average(all_merchants)
    return avg
  end

  def golden_items
    all_items_price = []
    sales_engine.items.all.each do |item|
      all_items_price << item.unit_price
    end
    all_items_price_std_dev = standard_deviation(all_items_price)
    golden_item_list = sales_engine.items.all.select do |item|
      item.unit_price > all_items_average_price + (2 * all_items_price_std_dev)
    end
    return golden_item_list
  end
end