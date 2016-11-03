require 'time'
require 'pry'

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

  def merchant
    parent.find_merchant_by_merchant_id(merchant_id)
  end

  def items
    parent.find_items_by_merchant_id(merchant_id)
  end

  def transactions
    parent.find_transactions_by_invoice_id(id)
  end

  def customer
    parent.find_customer_by_customer_id(customer_id)
  end

  def is_paid_in_full?
    #binding.pry
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total

  end

end

