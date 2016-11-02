require "csv"
require_relative "invoice"

class InvoiceRepository

  attr_reader   :invoices_list,
                :parent

  def initialize(file_path, parent)
    @parent = parent
    @invoices_list = [] 
    load_items(file_path)
  end


  def load_items(file_path)
    invoice_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    invoice_csv.each do |one_invoice|
      @invoices_list << Invoice.new({:id => one_invoice[:id].to_i,
                                :customer_id => one_invoice[:customer_id].to_i,
                                :merchant_id => one_invoice[:merchant_id].to_i,
                                :status => one_invoice[:status],
                                :created_at => one_invoice[:created_at],
                                :updated_at => one_invoice[:updated_at]}, self)
    end
  end

  def all
    invoices_list
  end

  def find_by_id(invoice_id)
    invoices_list.find do |invoice|
      invoice.id == invoice_id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices_list.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices_list.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoices_list.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
  end



#   all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
end
  # def all
  #   items_list
  # end

  # def find_by_id(item_id)
  #   items_list.find do |item|
  #     item.id == item_id
  #   end
  # end

  # def find_by_name(item_name)
  #   items_list.find do |item|
  #     item.name.downcase == item_name.downcase
  #   end
  # end

  # def find_all_with_description(segment)
  #   items_list.find_all do |item|
  #     item.description.downcase.include?(segment.downcase)
  #   end
  # end

  # def find_all_by_price(price)
  #   items_list.find_all do |item|
  #     item.unit_price == BigDecimal.new(price, 4)
  #   end
  # end

  # def find_all_by_price_in_range(price_range)
  #   items_list.find_all do |item|
  #     price_range.include?(item.unit_price)
  #   end
  # end

  # def find_all_by_merchant_id(merchant_id)
  #   items_list.find_all do |item|
  #     item.merchant_id == merchant_id
  #   end
  # end

  # def find_merchant_by_merchant_id(merchant_id)
  #   result = parent.find_merchant_by_merchant_id(merchant_id)
  # end

