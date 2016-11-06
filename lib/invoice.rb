require 'time'

#Store details of a single invoice
class Invoice

attr_reader     :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :parent


  def initialize(invoice_info, parent)
    @parent = parent
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status = invoice_info[:status].to_sym
    @created_at = Time.parse(invoice_info[:created_at])
    @updated_at = Time.parse(invoice_info[:updated_at])
  end

  #Can be tested through Mock
  def merchant
    parent.find_merchant(merchant_id)
  end

  #Testing through INTEGRATION TEST
  def items
    invoice_items.map do |invoice_item|
      parent.find_item(invoice_item.item_id)
    end
  end

  #Can be tested through Mock
  def invoice_items
    parent.find_invoice_items(id)
  end

  #Can be tested through Mock
  def transactions
    parent.find_transactions(id)
  end

  #Can be tested through Mock
  def customer
    parent.find_customer(customer_id)
  end

  #Testing through INTEGRATION TEST
  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  #Testing through INTEGRATION TEST
  def total
    return 0 unless is_paid_in_full?
    invoice_items.reduce(0) do |invoice_total, invoice_item|
      invoice_total += invoice_item.quantity * invoice_item.unit_price
      invoice_total
    end
  end

end

