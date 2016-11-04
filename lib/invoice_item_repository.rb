require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader     :invoice_items_list,
                  :parent

  def inspect
  end

  def initialize(file_path, parent)
    @parent = parent
    @invoice_items_list = []
    load_invoice_items(file_path)
  end


  def load_invoice_items(file_path)
    items_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    items_csv.each do |one_item|
      @invoice_items_list << InvoiceItem.new(one_item, self)
    end
  end

  def all
    invoice_items_list
  end

  def find_by_id(invoice_item_id)
    invoice_items_list.find do |invoice_item|
      invoice_item.id == invoice_item_id
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items_list.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items_list.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

end