require "csv"
require_relative "invoice"

class InvoiceRepository

  attr_reader   :invoices_list,
                :parent

  def inspect
  end
  
  def initialize(file_path, parent)
    @parent = parent
    @invoices_list = [] 
    load_items(file_path)
  end

  def load_items(file_path)
    invoice_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    invoice_csv.each do |one_invoice|
      @invoices_list << Invoice.new(one_invoice, self)
    end
  end

  def all
    invoices_list
  end

  def count_all
    invoices_list.count
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

  def find_invoice_items_by_invoice_id(invoice_id)
    parent.find_invoice_items_by_invoice_id(invoice_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    parent.find_transactions_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    parent.find_customer_by_customer_id(customer_id)
  end


end  