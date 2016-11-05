require 'bigdecimal'
require 'time'
require_relative 'calculator'

#Store details of a single Invoice Item
class InvoiceItem
  include Calculator
  PRICE_ADJUSTER = 100

  attr_reader       :id,
                    :item_id,
                    :invoice_id,
                    :quantity,
                    :unit_price,
                    :created_at,
                    :updated_at,
                    :parent

  def initialize(invoice_item_info, parent)
    @parent = parent
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity = invoice_item_info[:quantity].to_i
    @unit_price = BigDecimal(invoice_item_info[:unit_price])/PRICE_ADJUSTER
    @created_at = Time.parse(invoice_item_info[:created_at])
    @updated_at = Time.parse(invoice_item_info[:updated_at])
  end

  def unit_price_to_dollars
    bigdecimal_to_float(unit_price)
  end

end