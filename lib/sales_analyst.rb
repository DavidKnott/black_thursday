require 'pry'
class SalesAnalyst

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
    sum = items_per_merchant_list.values.inject do |sum, items_for_one_merchant|
      sum + (items_for_one_merchant - average_items_per_merchant)**2
    end
    sum = sum / merchants_list.length-1
    Math.sqrt(sum)
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

end