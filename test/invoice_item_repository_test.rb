require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader     :test_invoice_item_repo,
                  :invoice_items_list

  def setup
    @test_invoice_item_repo = InvoiceItemRepository.new("./data/invoice_items_one.csv", "parent")
    @invoice_items_list = test_invoice_item_repo.invoice_items_list
  end

  def test_initialize_invoiceitem_repository
    assert test_invoice_item_repo
  end

  def test_creates_invoice_item_list
    refute_empty invoice_items_list
  end

  def test_invoice_item_list_stores_invoice_items
    assert_equal InvoiceItem, invoice_items_list.first.class
  end

  def test_item_list_stores_created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_items_list[13].created_at
  end

  def test_item_list_stores_updated_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_items_list[13].updated_at
  end

  def test_all_method_returns_all_invoice_items
    assert_equal 99, test_invoice_item_repo.all.length
  end

  def test_finds_invoice_item_by_id
    assert_equal 9, test_invoice_item_repo.find_by_id(9).id
  end

  def test_finds_all_invoices_with_given_item_by_id
    assert_equal 16, test_invoice_item_repo.find_all_by_item_id(263526970)[0].id
  end

  def test_finds_all_invoices_with_given_invoice_by_id
    assert_equal 21, test_invoice_item_repo.find_all_by_invoice_id(4)[0].id
  end

  

  # def test_item_repo_calls_parent
  #   parent = MiniTest::Mock.new
  #   item_repo = ItemRepository.new("./data/items_one.csv", parent)
  #   parent.expect(:find_merchant_by_merchant_id, nil, [26])
  #   item_repo.find_merchant_by_merchant_id(26)
  #   parent.verify
  # end
end