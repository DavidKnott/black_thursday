require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader   :merchants,
                  :items

  def initialize(list_of_file_names)
    @items = ItemRepository.new(list_of_file_names[:items], self)
    @merchants = MerchantRepository.new(list_of_file_names[:merchants])
  end

  def self.from_csv(list_of_file_names)
    self.new(list_of_file_names)
  end

  def find_merchant_by_item_id(merchant_id)
    binding.pry
    merchants.find_by_id(merchant_id)
  end

end