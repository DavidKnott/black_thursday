require "csv"
require_relative "item"

class ItemRepository

  attr_reader   :items_list

  def initialize(file_path)
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
                                :merchant_id => one_item[:merchant_id]})
    end
  end

end