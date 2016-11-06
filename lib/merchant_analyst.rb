require_relative 'calculator'
require 'pry'

#Colection of methods used for Merchant related
#sales analysis within sales_analyst
module MerchantAnalyst
  include Calculator

  def merchants_list
    sales_engine.merchants_list
  end

  def transactions_list
    sales_engine.transactions_list
  end

  def average_items_per_merchant
    bigdecimal_to_float(average(total_items, total_merchants))
  end

  def total_merchants
    merchants_list.count
    #We can eliminate the below method from sales_engine!!!
    # sales_engine.merchants_count
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

  def revenue_by_merchant(merchant_id)
    merchant = find_merchant(merchant_id)
    revenue = merchant.invoices.inject(0) do |total, invoice|
      total += invoice.total
      total
    end
    bigdecimal_round(revenue)
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = find_invoices(merchant_id)
    quantity_list = list_of_invoice_items_with_quantity(invoices)
    highest_items = quantity_list.find_all {|elem| elem.last == quantity_list.values.max}
    highest_items.map do |elem|
      find_item(elem.first)
    end
  end

  def list_of_invoice_items_with_quantity(invoices)
    quantity_list = {}
    invoices.each do |invoice|
      invoice.invoice_items.each do |invoice_item|
          next quantity_list[invoice_item.item_id] += invoice_item.quantity if quantity_list[invoice_item.item_id]
            quantity_list[invoice_item.item_id] = invoice_item.quantity
      end if invoice.is_paid_in_full?
    end
    quantity_list
  end

  def list_of_invoice_items_with_total_unit_price(invoices)
    quantity_list = {}
    invoices.each do |invoice|
      invoice.invoice_items.each do |invoice_item|
          next quantity_list[invoice_item.item_id] += invoice_item.quantity * invoice_item.unit_price if quantity_list[invoice_item.item_id]
            quantity_list[invoice_item.item_id] = invoice_item.quantity * invoice_item.unit_price
      end if invoice.is_paid_in_full?
    end
    quantity_list
  end

  def best_item_for_merchant(merchant_id)
    invoices = find_invoices(merchant_id)
    total_unit_price_list = list_of_invoice_items_with_total_unit_price(invoices)
    highest_items = total_unit_price_list.find_all {|elem| elem.last == total_unit_price_list.values.max}
    highest_items.map do |elem|
      find_item(elem.first)
    end.first
  end

  #correct_way_to_find_total_revenue_by_date
  # transactions_list_on_date = transactions_list.find_all do |transaction|
    #   transaction.result == "success" &&  (transaction.updated_at.strftime("%Y-%m-%d") == date.strftime("%Y-%m-%d"))
    # end
    # return BigDecimal.new("0") unless transactions_list_on_date
    # transactions_list_on_date.inject(0) do |total, transaction|
    #   invoice = find_invoice(transaction.invoice_id)
    #   total += invoice.total
    #   total
    # end
    
  def total_revenue_by_date(date)
    invoices_list.inject(0) do |total, invoice|
      if invoice.created_at.strftime("%Y-%m-%d") == date.strftime("%Y-%m-%d")
        total += invoice.total
      end
      total
    end
  end

  def top_revenue_earners(top_list = 20)
  list = []
    merchants_list.each do |merchant|
      list << [[revenue_by_merchant(merchant.id)] , merchant]
    end
    list = list.sort.reverse
    list = list.map do |elem|
      elem.last
    end
    list[0...top_list]
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
      merchant.items.one? {|item| merchant.created_at.mon == Time.parse(month).mon }
    end
  end
end