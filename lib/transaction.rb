require 'bigdecimal'
require 'time'
require_relative 'calculator'

class Transaction
  include Calculator

  attr_reader       :id,
                    :invoice_id,
                    :credit_card_number,
                    :credit_card_expiration_date,
                    :result,
                    :created_at,
                    :updated_at,
                    :parent

  def initialize(transaction_info, parent)
    @parent = parent
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id].to_i
    @credit_card_number = transaction_info[:credit_card_number].to_i
    @credit_card_expiration_date  = transaction_info[:credit_card_expiration_date]
    @result = transaction_info[:result]
    @created_at = Time.parse(transaction_info[:created_at])
    @updated_at = Time.parse(transaction_info[:updated_at])
  end

  def invoice
    parent.find_invoice(invoice_id)
  end

end