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

  def test_transaction_list_stores_transactions
    assert_equal Transaction, transactions_list.first.class
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