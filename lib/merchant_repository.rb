require "csv"
require 'pry'
require_relative "merchant"

class MerchantRepository

  attr_reader   :merchants_list,
                :parent

  def inspect
    "#<#{self.class} #{@merchants_list.size} rows>"
  end

  def initialize(file_path, parent)
    @parent = parent
    @merchants_list = [] 
    load_merchants(file_path)
  end

  def load_merchants(file_path)
    merchants_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    merchants_csv.each do |one_merchant|
      @merchants_list << Merchant.new({:id => one_merchant[:id].to_i, :name => one_merchant[:name]}, self)
    end
  end

  def all
    merchants_list
  end

  def find_by_id(merchant_id)
    merchants_list.find do |merchant|
      merchant.id == merchant_id
    end
  end

  def find_by_name(merchant_name)
    merchants_list.find do |merchant|
      merchant.name.downcase == merchant_name.downcase
    end
  end

  def find_all_by_name(merchant_name)
    merchants_list.find_all do |merchant|
      merchant.name.downcase.include?(merchant_name.downcase)
    end
  end

  def find_items_by_merchant_id(merchant_id)
    parent.find_items_by_merchant_id(merchant_id)
  end

end