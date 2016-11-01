require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader   :merchants,
                  :items

  def initialize(list_of_file_names)
    @items = ItemRepository.new(list_of_file_names[:items], self)
    @merchants = MerchantRepository.new(list_of_file_names[:merchants], self)
  end

  def self.from_csv(list_of_file_names)
    self.new(list_of_file_names)
  end

  def find_merchant_by_merchant_id(merchant_id)
    result = merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    result = items.find_all_by_merchant_id(merchant_id)
  end

end