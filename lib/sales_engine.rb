require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_engine_relations'
require_relative 'sales_engine_grouping'
require_relative 'sales_engine_create'
require 'pry'

#Support for Sales Analyst layer, connecting Sales Analyst and
#various repositories with each other
class SalesEngine
  include SalesEngineRelations
  include SalesEngineGrouping
  include SalesEngineCreate

  attr_reader   :merchants,
                :items,
                :invoices,
                :invoice_items,
                :customers,
                :transactions

  def initialize(files)
    raise "Please enter a valid file name" unless valid?(files)
    @items = create_item_repository(files)
    @merchants = create_merchants_repository(files)
    @invoices = create_invoices_repository(files)
    @invoice_items = create_invoice_item_repository(files)
    @transactions = create_transaction_repository(files)
    @customers = create_customer_repository(files)
  end

  def self.from_csv(files)
    self.new(files)
  end

  def valid?(paths)
    paths.values.all? do |path|
      #binding.pry
      File.exist?(path)
    end
  end
end