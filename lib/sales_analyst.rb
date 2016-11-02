require_relative 'calculator'

class SalesAnalyst
  include Calculator

  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
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