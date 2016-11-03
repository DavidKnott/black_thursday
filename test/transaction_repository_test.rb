require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  attr_reader     :test_transaction_repo,
                  :transactions_list

  def setup
    @test_transaction_repo = TransactionRepository.new("./data/transactions_one.csv", "parent")
    @transactions_list = test_transaction_repo.transactions_list
  end

  def test_initialize_invoiceitem_repository
    assert test_transaction_repo
  end

  def test_creates_transaction_list
    refute_empty transactions_list
  end

  def test_transaction_list_stores_id
    assert_equal 14, transactions_list[13].id
  end

  def test_item_list_stores_invoice_id
    assert_equal 3560, transactions_list[13].invoice_id
  end

  def test_item_list_stores_credit_card_number
    assert_equal 4035885351912165, transactions_list[13].credit_card_number
  end

  def test_item_list_stores_credit_card_number_expiration_date
    assert_equal "1020", transactions_list[13].credit_card_expiration_date
  end

  def test_item_list_stores_result
    assert_equal "failed", transactions_list[13].result
  end

  def test_item_list_stores_created_at
    assert_equal Time.parse("2012-02-26 20:56:57 UTC"), transactions_list[13].created_at
  end

  def test_item_list_stores_updated_at
    assert_equal Time.parse("2012-02-26 20:56:57 UTC"), transactions_list[13].updated_at
  end

  def test_all_method_returns_all_transactions
    assert_equal 99, test_transaction_repo.all.length
  end

  def test_finds_transaction_by_id
    assert_equal 9, test_transaction_repo.find_by_id(9).id
  end

  def test_finds_all_transactions_by_invoice_id
    actual = test_transaction_repo.find_all_by_invoice_id(750)[0].id
    assert_equal 3, actual
  end

  def test_finds_all_transactions_with_given_credit_card_number
    actual = test_transaction_repo.find_all_by_credit_card_number(4271805778010747)[0].id
    assert_equal 3, actual
  end

  def test_finds_all_transactions_with_given_result
    actual = test_transaction_repo.find_all_by_result("success")[0].id
    assert_equal 1, actual
  end

  def test_transaction_calls_parent_for_invoice
    parent = MiniTest::Mock.new
    transaction_repo = TransactionRepository.new("./data/transactions_one.csv", parent)
    parent.expect(:find_invoice, nil, [26])
    transaction_repo.find_invoice(26)
    parent.verify
  end

end