require "csv"
require_relative "merchant"

class MerchantRepository

  attr_reader   :merchants_list

  def initialize(file_path)
    @merchants_list = [] 
    load_merchants(file_path)
  end


  def load_merchants(file_path)
    merchants_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    merchants_csv.each do |one_merchant|
      @merchants_list << Merchant.new({:id => one_merchant[:id], :name => one_merchant[:name]})
    end
  end

end