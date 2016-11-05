require_relative 'calculator'
require_relative 'invoice_analyst'
require_relative 'item_analyst'
require_relative 'merchant_analyst'
require_relative 'customer_analyst'

#Collection of Sales Analysis related methods
#using data from the various repositories
class SalesAnalyst
  include Calculator

  include InvoiceAnalyst
  include ItemAnalyst
  include MerchantAnalyst
  include CustomerAnalyst

  attr_reader   :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end