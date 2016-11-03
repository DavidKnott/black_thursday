require 'bigdecimal'
require 'time'
require_relative 'calculator'

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

end