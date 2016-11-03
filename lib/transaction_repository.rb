require 'csv'
require_relative 'transaction'
require 'pry'

class TransactionRepository

  attr_reader     :transactions_list,
                  :parent

  def inspect
  end

  def initialize(file_path, parent)
    @parent = parent
    @transactions_list = [] 
    load_transactions(file_path)
  end

  def load_transactions(file_path)
    transactions_csv = CSV.open(file_path, headers:true, header_converters: :symbol)
    transactions_csv.each do |one_transaction|
      @transactions_list << Transaction.new(one_transaction, self)
    end
  end

  def all
    transactions_list
  end

  def find_by_id(transaction_id)
    transactions_list.find do |transaction|
      transaction.id == transaction_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions_list.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions_list.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions_list.find_all do |transaction|
      transaction.result == result
    end
  end

end