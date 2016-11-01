require "csv"
require_relative "item"

class ItemRepository

  attr_reader   :items_list,
                :parent

  def initialize(file_path, parent)
    @parent = parent
    @items_list = [] 
    load_items(file_path)
  end


  def load_items(file_path)
    items_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    items_csv.each do |one_item|
      @items_list << Item.new({:id => one_item[:id],
                                :name => one_item[:name],
                                :description => one_item[:description],
                                :unit_price => one_item[:unit_price],
                                :created_at => one_item[:created_at],
                                :updated_at => one_item[:updated_at],
                                :merchant_id => one_item[:merchant_id]}, self)
    end
  end

  def all
    items_list
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

  def find_merchant_by_item_id(item_id)
    parent.find_merchant_by_item_id(item_id)
  end

end