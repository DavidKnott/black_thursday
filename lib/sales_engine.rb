require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_engine_relations'
require_relative 'sales_engine_grouping'
require_relative 'sales_engine_create'

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
    file_loader(files)
  end

  def from_csv(files)
    file_loader(files)
  end

  def file_loader(files)
    raise "Please enter a valid file name" unless valid?(files)
    @items = create_item_repo(files) if files[:items]
    @invoices = create_invoices_repo(files) if files[:invoices]
    @invoice_items = create_invoice_item_repo(files) if files[:invoice_items]
    @transactions = create_transaction_repo(files) if files[:transactions]
    @customers = create_customer_repo(files) if files[:customers]
    @merchants = create_merchants_repo(files) if files[:merchants]
  end

  def self.from_csv(files)
    self.new(files)
  end

  def valid?(paths)
    paths.values.all? do |path|
      File.exist?(path)
    end
  end
end