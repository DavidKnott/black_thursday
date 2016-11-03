require_relative 'calculator'

module SaMerchant
  include Calculator

  def merchants_list
    sales_engine.merchants_list
  end

  def average_items_per_merchant
    bigdecimal_to_float(average(total_items, total_merchants))
  end

  def total_merchants
    sales_engine.merchants_count
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant_list)
  end

  def items_per_merchant_list
    merchants_list.map do |merchant|
      items_per_merchant(merchant.id)
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def items_per_merchant(merchant_id)
    merchant = find_merchant_by_merchant_id(merchant_id)
    merchant.items.length
  end

  def merchants_with_high_item_count
    item_count_mean = average_items_per_merchant
    item_count_std_dev = average_items_per_merchant_standard_deviation
    merchants_list.find_all do |merchant|
      merchant if items_per_merchant(merchant.id) > item_count_mean + item_count_std_dev
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = find_merchant_by_merchant_id(merchant_id)
    bigdecimal_round(list_average(items_unit_price_list(merchant.items)))
  end

  def average_average_price_per_merchant
    all_merchants = merchants_list.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    bigdecimal_round(list_average(all_merchants))
  end

end