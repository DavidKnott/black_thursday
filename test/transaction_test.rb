require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/transaction'

require 'pry'

class TransactionTest < MiniTest::Test

  attr_reader     :transaction_info,
                  :test_transaction

  def setup
    @transaction_info = {:id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => "2012-02-26 20:56:57 UTC",
                          :updated_at => "2012-02-26 20:56:57 UTC"}
    @test_transaction = Transaction.new(transaction_info, "parent")
  end

  def test_initializes_transaction
    assert test_transaction
  end

  def test_it_stores_id
    assert_equal 6, test_transaction.id
  end

  def test_it_stores_invoice_id
    assert_equal 8, test_transaction.invoice_id
  end

  def test_it_stores_credit_card_number
    assert_equal 4242424242424242, test_transaction.credit_card_number
  end

  def test_it_stores_credit_card_expiration_date
    assert_equal "0220", test_transaction.credit_card_expiration_date
  end

  def test_it_stores_result
    assert_equal "success", test_transaction.result
  end

  def test_it_stores_created_at
    expected = Time.parse("2012-02-26 20:56:57 UTC")
    assert_equal expected, test_transaction.created_at
  end

  def test_it_stores_updated_at
    expected = Time.parse("2012-02-26 20:56:57 UTC")
    assert_equal expected, test_transaction.updated_at
  end

  def test_transaction_calls_parent_for_invoice
    parent = MiniTest::Mock.new
    transaction = Transaction.new(transaction_info, parent)
    parent.expect(:find_invoice, nil, [transaction.invoice_id])
    transaction.invoice
    parent.verify
  end

end