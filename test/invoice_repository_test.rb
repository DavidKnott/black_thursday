require_relative 'test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader    :test_invoice_repo

  def setup
    @test_invoice_repo = InvoiceRepository.new("./data/invoices_fixture.csv", "parent")
  end
  
  def test_initialize_item_repository
    assert test_invoice_repo
  end

  def test_creates_invoices_list
    refute_empty test_invoice_repo.invoices_list
  end

  def test_invoice_list_stores_invoices
    assert_equal Invoice, test_invoice_repo.invoices_list.first.class
  end

  def test_all_method_returns_all_invoices
    result = test_invoice_repo.all
    assert_equal Invoice, result.first.class
    assert_equal 12, result.length
  end

  def test_finds_invoice_by_id
    result = test_invoice_repo.find_by_id(2)
    assert_equal Invoice, result.class
    assert_equal 22222222, result.merchant_id
  end

  def test_finds_invoice_by_id_when_id_is_not_in_repository
    result = test_invoice_repo.find_by_id(999)
    assert_nil result
  end

  def test_finds_all_by_customer_id
    result = test_invoice_repo.find_all_by_customer_id(3)
    assert_equal Invoice, result.last.class
    assert_equal 2, result.length
    assert_equal 2, result.first.id
    assert_equal 44434165, result.last.merchant_id
  end

  def test_finds_all_by_customer_id_when_id_is_not_in_repository
    result = test_invoice_repo.find_all_by_customer_id(999)
    assert_empty result
  end

  def test_finds_all_by_merchant_id
    result = test_invoice_repo.find_all_by_merchant_id(44434165)
    assert_equal Invoice, result.first.class
    assert_equal 3, result.count
    assert_equal 5, result.first.id
    assert_equal 1, result.last.customer_id
  end

  def test_finds_all_by_merchant_id_when_id_is_not_in_repository
    result = test_invoice_repo.find_all_by_merchant_id(999)
    assert_empty result
  end

  def test_finds_all_by_status
    result = test_invoice_repo.find_all_by_status(:shipped)
    assert_equal Invoice, result.first.class
    assert_equal 4, result.count
    assert_equal 7, result.first.customer_id
    assert_equal 10, result.last.id
  end

  def test_finds_all_by_status_when_no_item_in_databse_with_that_status
    result = test_invoice_repo.find_all_by_status(:notinrepository)
    assert_empty result
  end
  
  def test_invoice_repo_calls_parent_for_merchant
    parent = MiniTest::Mock.new
    invoice_repo = InvoiceRepository.new("./data/invoices_one.csv", parent)
    parent.expect(:find_merchant, nil, [26])
    invoice_repo.find_merchant(26)
    parent.verify
  end

  def test_invoice_repo_calls_parent_for_items
    parent = MiniTest::Mock.new
    invoice_repo = InvoiceRepository.new("./data/invoices_one.csv", parent)
    parent.expect(:find_invoice_items, nil, [26])
    invoice_repo.find_invoice_items(26)
    parent.verify
  end

  def test_invoice_repo_calls_parent_for_transactions
    parent = MiniTest::Mock.new
    invoice_repo = InvoiceRepository.new("./data/invoices_one.csv", parent)
    parent.expect(:find_transactions, nil, [26])
    invoice_repo.find_transactions(26)
    parent.verify
  end

  def test_invoice_repo_calls_parent_for_customers
    parent = MiniTest::Mock.new
    invoice_repo = InvoiceRepository.new("./data/invoices_one.csv", parent)
    parent.expect(:find_customer, nil, [26])
    invoice_repo.find_customer(26)
    parent.verify
  end


end