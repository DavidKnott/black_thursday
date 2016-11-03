require 'csv'
require_relative 'customer'
require 'pry'

class CustomerRepository

  attr_reader     :customers_list,
                  :parent

  def initialize(file_path, parent)
    @parent = parent
    @customers_list = [] 
    load_costumers(file_path)
  end

  def load_costumers(file_path)
    costumers_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    costumers_csv.each do |one_customer|
      @customers_list << Customer.new(one_customer, self)
    end
  end

#   all - returns an array of all known Customers instances
# find_by_id - returns either nil or an instance of Customer with a matching ID
# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied

  def all
    customers_list
  end

  def find_by_id(customer_id)
    customers_list.find do |customer|
      customer.id == customer_id
    end
  end

  def find_all_by_first_name(first_name)
    customers_list.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    customers_list.find_all do |customer|
      customer.last_name == last_name
    end
  end


end
