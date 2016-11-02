require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine

  attr_reader   :merchants,
                :items,
                :invoices

  def initialize(files)
    @items = create_item_repository(files)
    @merchants = create_merchants_repository(files)
    @invoices = create_invoices_repository(files)
    raise "Please enter a valid file name" if items.nil? && merchants.nil? && invoices.nil?
  end


  def self.from_csv(files)
    self.new(files)
  end

  def create_item_repository(files)
    ItemRepository.new(files[:items], self)  if files.include?(:items) &&  File.exist?(files[:items])
  end

  def create_merchants_repository(files)
    MerchantRepository.new(files[:merchants], self)  if files.include?(:merchants)
  end

  def create_invoices_repository(files)
    InvoiceRepository.new(files[:invoices], self)  if files.include?(:invoices)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

end