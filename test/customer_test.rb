require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/customer'

class CustomerTest < MiniTest::Test

  attr_reader     :test_customer

  def setup
    @test_customer = Customer.new({:id => 6,
                                    :first_name => "Joan",
                                    :last_name => "Clarke",
                                    :created_at => "2012-03-27 14:54:11 UTC",
                                    :updated_at => "2012-03-27 14:54:11 UTC"}, "parent")
  end

  def test_initializes_customer
    assert test_customer
  end

  def test_it_stores_id
    assert_equal 6, test_customer.id
  end

  def test_it_stores_first_name
    assert_equal "Joan", test_customer.first_name
  end

  def test_it_stores_last_name
    assert_equal "Clarke", test_customer.last_name
  end

  def test_it_stores_created_at
    expected = Time.parse("2012-03-27 14:54:11 UTC")
    assert_equal expected, test_customer.created_at
  end

  def test_it_stores_updated_at
    expected = Time.parse("2012-03-27 14:54:11 UTC")
    assert_equal expected, test_customer.updated_at
  end

end