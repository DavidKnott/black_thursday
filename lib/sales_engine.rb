require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_accessor   :items_file,
                  :merchants_file,
                  :merchants,
                  :items

  def self.from_csv(list_of_file_names)
    return "Please Enter Valid File Names" if all_valid?(list_of_file_names)
    sales_engine = self.new
    list_of_file_names.keys.each do |key|
      sales_engine.items_file = list_of_file_names[:items] if key == :items
      sales_engine.items = create_item_repository(sales_engine.items_file) if key == :items
      sales_engine.merchants_file = list_of_file_names[:merchants] if key == :merchants 
      sales_engine.merchants = create_merchant_repository(sales_engine.merchants_file) if key == :merchants
    end
    sales_engine
  end

  def self.create_item_repository(items_file)
    ItemRepository.new(items_file)
  end

  def self.create_merchant_repository(merchants_file)
    MerchantRepository.new(merchants_file)
  end

  def self.all_valid?(list_of_file_names)
    list_of_file_names.values.none? do |path|
      File.exist?(path)
    end
  end

end