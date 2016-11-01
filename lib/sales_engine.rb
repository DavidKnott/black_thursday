require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  CREATE_REPOS = {:items => :create_item_repository,
            :merchants => :create_merchant_repository}

  SET_REPOS = {:items => :items=,
            :merchants => :merchants=}

  attr_accessor   :merchants,
                  :items

  def self.from_csv(list_of_file_names)
    return "Please Enter Valid File Names" if all_valid?(list_of_file_names)
    sales_engine = self.new
    list_of_file_names.keys.each do |key|
      repository = self.send CREATE_REPOS[key], list_of_file_names[key]
      sales_engine.send SET_REPOS[key], repository
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