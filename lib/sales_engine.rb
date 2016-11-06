require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'pry'

#Support for Sales Analyst layer, connecting Sales Analyst and
#various repositories with each other
class SalesEngine

  attr_reader   :merchants,
                :items,
                :invoices,
                :invoice_items,
                :customers,
                :transactions

  def initialize(files)
    @items = create_item_repository(files)
    @merchants = create_merchants_repository(files)
    @invoices = create_invoices_repository(files)
    @invoice_items = create_invoice_item_repository(files)
    @transactions = create_transaction_repository(files)
    @customers = create_customer_repository(files)
    if items.nil? && merchants.nil? && invoices.nil?
      raise "Please enter a valid file name"
    end
  end

  def self.from_csv(files)
    self.new(files)
  end

  def create_item_repository(files)
    ItemRepository.new(files[:items], self)  if files.include?(:items)
  end

  def create_merchants_repository(files)
    MerchantRepository.new(files[:merchants], self) \
                        if files.include?(:merchants)
  end

  def create_invoices_repository(files)
    InvoiceRepository.new(files[:invoices], self) \
                        if files.include?(:invoices)
  end

  def create_invoice_item_repository(files)
    InvoiceItemRepository.new(files[:invoice_items], self) \
                            if files.include?(:invoice_items)
  end

  def create_transaction_repository(files)
    TransactionRepository.new(files[:transactions], self) \
                            if files.include?(:transactions)
  end

  def create_customer_repository(files)
    CustomerRepository.new(files[:customers], self) \
                        if files.include?(:customers)
  end

  def find_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_items(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_transaction(transaction_id)
    transactions.find_by_id(transaction_id)
  end

  def find_transactions(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_invoices_for_customer(customer_id)
    invoices.find_all_by_customer_id(customer_id)
  end

  def find_item(item_id)
    items.find_by_id(item_id)
  end

  def merchants_list
    merchants.all
  end

  def merchants_count
    merchants.count_all
  end

  def items_list
    items.all
  end

  def items_count
    items.count_all
  end

  def invoices_list
    invoices.all
  end

  def invoices_count
    invoices.count_all
  end

  def transactions_list
    transactions.all
  end

end