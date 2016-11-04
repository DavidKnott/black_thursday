require_relative 'test_helper'
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

  def test_invoice_item_list_stores_invoices
    assert_equal InvoiceItem, invoice_items_list.first.class
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

end