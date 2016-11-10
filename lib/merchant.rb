require 'time'
#Storing details of a single merchant
class Merchant

  attr_reader   :id,
                :name,
                :created_at,
                :parent

  def initialize(merchant_info, parent)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @created_at = Time.parse(merchant_info[:created_at])
    @parent = parent
  end

  def items
    parent.find_items(id)
  end

  def invoices
    parent.find_invoices(id)
  end

  def customer_ids
    invoices.map do |invoice|
      invoice.customer_id
    end.uniq
  end

  def customers
    customer_ids.map do |customer_id|
      parent.find_customer(customer_id)
    end
  end

end