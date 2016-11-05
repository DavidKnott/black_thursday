require_relative 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  attr_reader     :test_customer_repo,
                  :customers_list

  def setup
    # @test_customer_repo = CustomerRepository.new("./data/customers_one.csv", "parent")
    @test_customer_repo = CustomerRepository.new("./data/customers_fixture.csv", "parent")
    @customers_list = test_customer_repo.customers_list
  end

  # def test_initialize_invoiceitem_repository
  #   assert test_customer_repo
  # end

  # def test_creates_customer_list
  #   refute_empty customers_list
  # end

  # def test_customer_list_stores_customers
  #   assert_equal Customer, customers_list.first.class
  # end

  # def test_all_method_returns_all_transactions
  #   assert_equal 99, test_customer_repo.all.length
  # end

  # def test_finds_customer_by_id
  #   assert_equal 9, test_customer_repo.find_by_id(9).id
  # end

  # def test_finds_all_by_first_name
  #   assert_equal 6, test_customer_repo.find_all_by_first_name("Heber")[0].id
  # end

  # def test_finds_all_by_last_name
  #   assert_equal 6, test_customer_repo.find_all_by_last_name("Kuhn")[0].id
  # end




#Testing using TEST FIXTURE
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
    result = test_customer_repo.all
    assert_equal 9, result.length
  end

  def test_finds_customer_by_id
    result = test_customer_repo.find_by_id(5)
    assert_equal "FirstName5", result.first_name
  end

  def test_finds_all_by_first_name
    result = test_customer_repo.find_all_by_first_name("DaLLnA")
    assert_equal Customer, result.first.class
    assert_equal 3, result.count
    assert_equal "LastName4", result.first.last_name
    assert_equal 8, result.last.id
  end

  def test_finds_all_by_first_name_not_in_repository
    result = test_customer_repo.find_all_by_first_name("notinrepository")
    assert_empty result
  end

  def test_finds_all_by_last_name
    result = test_customer_repo.find_all_by_last_name("TfINdAL")
    assert_equal Customer, result.first.class
    assert_equal 4, result.count
    assert_equal 2, result.first.id
    assert_equal "FirstName6", result.last.first_name
  end

  def test_finds_all_by_last_name_not_in_repository
    result = test_customer_repo.find_all_by_last_name("notinrepository")
    assert_empty result
  end

end