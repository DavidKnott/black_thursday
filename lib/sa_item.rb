require_relative 'calculator'

module SaItem
  include Calculator

  def items_list
    sales_engine.items_list
  end

  def total_items
    sales_engine.items_count
  end

  def items_unit_price_list(merchant_items = nil)
    list = merchant_items unless merchant_items.nil?
    list = items_list if merchant_items.nil?
    list.map do |item|
      item.unit_price
    end
  end

  def golden_items_filter(all_items_price_mean, all_items_price_std_dev)
    items_list.select do |item|
      item.unit_price > all_items_price_mean + (2 * all_items_price_std_dev)
    end
  end

  def golden_items
    all_items_price = items_unit_price_list
    all_items_price_mean = list_average(all_items_price)
    all_items_price_std_dev = standard_deviation(all_items_price)
    golden_items_filter(all_items_price_mean, all_items_price_std_dev)
  end

end