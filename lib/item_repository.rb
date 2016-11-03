require "csv"
require 'time'
require_relative "item"


class ItemRepository

  attr_reader   :items_list,
                :parent

  def inspect
  end

  def initialize(file_path, parent)
    @parent = parent
    @items_list = [] 
    load_items(file_path)
  end

  def load_items(file_path)
    items_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    items_csv.each do |one_item|
      @items_list << Item.new(one_item, self)
    end
  end

  def all
    items_list
  end

  def count_all
    items_list.count
  end

  def find_by_id(item_id)
    items_list.find do |item|
      item.id == item_id
    end
  end

  def find_by_name(item_name)
    items_list.find do |item|
      item.name.downcase == item_name.downcase
    end
  end

  def find_all_with_description(segment)
    items_list.find_all do |item|
      item.description.downcase.include?(segment.downcase)
    end
  end

  def find_all_by_price(price)
    items_list.find_all do |item|
      item.unit_price == BigDecimal.new(price, 4)
    end
  end

  def find_all_by_price_in_range(price_range)
    items_list.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items_list.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_merchant(merchant_id)
    parent.find_merchant(merchant_id)
  end

end