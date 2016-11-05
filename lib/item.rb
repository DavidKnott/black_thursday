require 'bigdecimal'
require 'time'
require_relative 'calculator'

#Store details of a single item
class Item
  include Calculator

  CENT_TO_DOLLAR = 100

  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :parent

  def initialize(item_info, parent)
    @parent = parent
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = BigDecimal(item_info[:unit_price])/CENT_TO_DOLLAR
    @created_at = Time.parse(item_info[:created_at])
    @updated_at = Time.parse(item_info[:updated_at])
    @merchant_id = item_info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    bigdecimal_to_float(unit_price)
  end

  #Tested through Mock
  def merchant
    parent.find_merchant(merchant_id)
  end

end