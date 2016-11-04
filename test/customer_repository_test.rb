require_relative 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  attr_reader     :test_customer_repo,
                  :customers_list

  def setup
    @test_customer_repo = CustomerRepository.new("./data/customers_one.csv", "parent")
    @customers_list = test_customer_repo.customers_list
  end

  def test_initialize_invoiceitem_repository
    assert test_customer_repo
  end

  def test_creates_customer_list
    refute_empty customers_list
  end

  def test_customer_list_stores_customers
    assert_equal Customer, customers_list.first.class
  end

  def test_all_method_returns_all_transactions
    assert_equal 99, test_customer_repo.all.length
  end

  def test_finds_customer_by_id
    assert_equal 9, test_customer_repo.find_by_id(9).id
  end

  def test_finds_all_by_first_name
    assert_equal 6, test_customer_repo.find_all_by_first_name("Heber")[0].id
  end

  def test_finds_all_by_last_name
    assert_equal 6, test_customer_repo.find_all_by_last_name("Kuhn")[0].id
  end

end