require_relative 'calculator'

#Colection of methods used for Merchant related
#sales analysis within sales_analyst
module MerchantAnalyst
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
      items_count(merchant.id)
    end
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant(merchant_id)
  end

  def items_count(merchant_id)
    merchant = find_merchant(merchant_id)
    merchant.items.length
  end

  def merchants_with_high_item_count
    items_average = average_items_per_merchant
    items_std_dev = average_items_per_merchant_standard_deviation
    merchants_list.find_all do |merchant|
      merchant if items_count(merchant.id) > items_average + items_std_dev
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    bigdecimal_round(list_average(items_unit_price_list(merchant.items)))
  end

  def average_average_price_per_merchant
    all_merchants = merchants_list.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    bigdecimal_round(list_average(all_merchants))
  end

end