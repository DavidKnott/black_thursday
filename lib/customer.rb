require 'bigdecimal'
require 'time'
require_relative 'calculator'

#Storing details of a single customer
class Customer
  include Calculator

  attr_reader       :id,
                    :first_name,
                    :last_name,
                    :created_at,
                    :updated_at,
                    :parent


  def initialize(customer_info, parent)
    @parent = parent
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name]
    @last_name = customer_info[:last_name]
    @created_at = Time.parse(customer_info[:created_at])
    @updated_at = Time.parse(customer_info[:updated_at])
  end

  #Tested through Mock
  def invoices
    parent.find_invoices_for_customer(id)
  end

  #Tested through INTEGRATION TEST
  def merchant_ids
    invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  #Tested through INTEGRATION TEST
  def merchants
    merchant_ids.map do |merchant_id|
      parent.find_merchant(merchant_id)
    end
  end

end