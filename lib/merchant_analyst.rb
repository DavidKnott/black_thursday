require 'pry'
require_relative 'calculator'

#Colection of methods used for Merchant related
#sales analysis within sales_analyst
module MerchantAnalyst
  include Calculator

  def merchants_list
    sales_engine.merchants_list
  end

  def average_items_per_merchant
    simple_rounding(average(total_items, total_merchants))
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

  def find_invoices(merchant_id)
    sales_engine.find_invoices(merchant_id)
  end

  def find_item(item_id)
    sales_engine.find_item(item_id)
  end

  def items_count(merchant_id)
    merchant = find_merchant(merchant_id)
    merchant.items.length
  end

  def item_count_filter(merchants_list, threshold)
    merchants_list.find_all do |merchant|
      merchant if items_count(merchant.id) > threshold
    end
  end

  def merchants_with_high_item_count
    items_average = average_items_per_merchant
    items_std_dev = average_items_per_merchant_standard_deviation
    threshold = items_average + items_std_dev
    item_count_filter(merchants_list, threshold)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    merchant_items = merchant.items
    return rounding(0) if merchant_items.empty? 
    rounding(list_average(items_unit_price_list(merchant_items)))
  end

  def average_average_price_per_merchant
    all_merchants = merchants_list.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    rounding(list_average(all_merchants))
  end

  def revenue_by_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    revenue = merchant.invoices.inject(0) do |total, invoice|
      total += invoice.total
      total
    end
    rounding(revenue)
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = find_invoices(merchant_id)
    quantity_list = invoice_items_with_quantity(invoices)
    ids_to_items(collect_highest(quantity_list))
  end

  def collect_highest(quantity_list)
    quantity_list.find_all do |elem|
      elem.last == quantity_list.values.max
    end
  end

  def ids_to_items(list)
    list.map do |elem|
      find_item(elem.first)
    end
  end

  def invoice_items_with_quantity(invoices)
    quantity_list = Hash.new(0)
    invoices.each do |invoice|
      invoice.invoice_items.each do |invoice_item|
        quantity_list[invoice_item.item_id] += invoice_item.quantity
      end if invoice.is_paid_in_full?
    end
    quantity_list
  end

  def invoice_items_with_total_unit_price(invoices)
    quantity_list = Hash.new(0)
    invoices.map do |invoice|
      invoice.invoice_items.map do |item|
        quantity_list[item.item_id] += item.quantity * item.unit_price
      end if invoice.is_paid_in_full?
    end
    quantity_list
  end

  def highest_invoice_total(unit_price_list, max)
    unit_price_list.find_all do |invoice_total|
      invoice_total.last == max
    end
  end

  def highest_total_invoice_items(unit_price_list, max)
    highest_invoice_total(unit_price_list, max).map do |invoice_total|
      find_item(invoice_total.first)
    end.first
  end

  def best_item_for_merchant(merchant_id)
    invoices = find_invoices(merchant_id)
    unit_price_list = invoice_items_with_total_unit_price(invoices)
    highest_total_invoice_items(unit_price_list, unit_price_list.values.max)
  end

  def total_revenue_by_date(date)
    invoices_list.inject(0) do |total, invoice|
      if invoice.created_at.strftime("%Y-%m-%d") == date.strftime("%Y-%m-%d")
        total += invoice.total
      end
      total
    end
  end

  def merchants_revenue
    merchants_list.map do |merchant|
      [revenue_by_merchant(merchant.id), merchant]
    end.sort_by {|item| item.first}.reverse
  end

  def top_revenue_earners(top_list = 20)
    merchants_revenue.map do |elem|
      elem.last
    end[0...top_list]
  end

  def merchants_with_pending_invoices
    merchants_list.find_all do |merchant|
      merchant.invoices.any? {|invoice| !invoice.is_paid_in_full?}
    end
  end

  def merchants_with_only_one_item
    merchants_list.find_all do |merchants|
      merchants.items.length == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_list.find_all do |merchant|
      merchant.items.one? do |item|
        merchant.created_at.mon == Time.parse(month).mon
      end
    end
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(total_merchants)
  end
end