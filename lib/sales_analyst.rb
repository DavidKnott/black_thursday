require 'pry'
require_relative 'calculator'
require_relative 'sa_invoice'
require_relative 'sa_item'
require_relative 'sa_merchant'
require_relative 'customer_analyst'

class SalesAnalyst
  include Calculator

  include SaInvoice
  include SaItem
  include SaMerchant
  include CustomerAnalyst

  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end