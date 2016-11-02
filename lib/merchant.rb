class Merchant

  attr_reader   :id,
                :name,
                :parent


  def initialize(merchant_info, parent)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @parent = parent
  end

  def items
    parent.find_items_by_merchant_id(id)
  end

  def invoices
    parent.find_invoices_by_merchant_id(id)
  end

end