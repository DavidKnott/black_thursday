require 'csv'
require_relative 'customer'
require 'pry'

class CustomerRepository

  attr_reader     :customers_list,
                  :parent

  def inspect
  end

  def initialize(file_path, parent)
    @parent = parent
    @customers_list = []
    load_costumers(file_path)
  end

  def load_costumers(path)
    costumers_csv = CSV.open(path, headers:true, header_converters: :symbol)
    costumers_csv.each do |one_customer|
      @customers_list << Customer.new(one_customer, self)
    end
  end

  def all
    customers_list
  end

  def find_by_id(customer_id)
    customers_list.find do |customer|
      customer.id == customer_id
    end
  end

  def find_all_by_first_name(input)
    customers_list.find_all do |customer|
      customer.first_name.downcase.include?(input.downcase)
    end
  end

  def find_all_by_last_name(input)
    customers_list.find_all do |customer|
      customer.last_name.downcase.include?(input.downcase)
    end
  end

  def find_invoices_for_customer(customer_id)
    parent.find_invoices_for_customer(customer_id)
  end

  def find_merchant(merchant_id)
    parent.find_merchant(merchant_id)
  end

end
