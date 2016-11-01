require 'bigdecimal'

class Item

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
    @unit_price = BigDecimal.new(item_info[:unit_price], 4)
    @created_at = item_info[:created_at]
    @updated_at = item_info[:updated_at]
    @merchant_id = item_info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    result = parent.find_merchant_by_item_id(merchant_id)
  end

end