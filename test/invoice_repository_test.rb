require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader    :test_invoice_repo

  def setup
    @test_invoice_repo = InvoiceRepository.new("./data/invoices.csv", "parent")
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
    assert_equal 4985, test_invoice_repo.all.length
  end

  def test_finds_invoice_by_id
    assert_equal 2, test_invoice_repo.find_by_id(2).id
  end

  def test_finds_all_by_customer_id
    assert_equal 5, test_invoice_repo.find_all_by_customer_id(6).length
  end

  def test_finds_all_by_merchant_id
    actual = test_invoice_repo.find_all_by_merchant_id(12336163).first.id
    assert_equal 20, actual
  end

  def test_finds_all_by_status_id
    actual = test_invoice_repo.find_all_by_status(:shipped).first.id
    assert_equal 2, actual
  end
  
  def test_invoice_repo_calls_parent_for_merchant
    parent = MiniTest::Mock.new
    invoice_repo = InvoiceRepository.new("./data/invoices_one.csv", parent)
    parent.expect(:find_merchant_by_merchant_id, nil, [26])
    invoice_repo.find_merchant_by_merchant_id(26)
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
    parent.expect(:find_transactions_by_invoice_id, nil, [26])
    invoice_repo.find_transactions_by_invoice_id(26)
    parent.verify
  end

  def test_invoice_repo_calls_parent_for_customers
    parent = MiniTest::Mock.new
    invoice_repo = InvoiceRepository.new("./data/invoices_one.csv", parent)
    parent.expect(:find_customer_by_customer_id, nil, [26])
    invoice_repo.find_customer_by_customer_id(26)
    parent.verify
  end
end