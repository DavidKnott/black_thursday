require 'pry'
require_relative 'calculator'
require_relative 'sa_invoice'
require_relative 'sa_item'
require_relative 'sa_merchant'

class SalesAnalyst
  include Calculator

  include SaInvoice
  include SaItem
  include SaMerchant

  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end