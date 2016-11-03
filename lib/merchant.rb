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

  def customers
    customer_id_list = invoices.map do |invoice|
      invoice.customer_id
    end.uniq
    customer_list = customer_id_list.map do |customer_id|
      parent.find_customer(customer_id)
    end
    return customer_list
  end

end