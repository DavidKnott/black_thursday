require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/merchant'

class MerchantTest < MiniTest::Test

  attr_reader   :test_merchant1,
                :test_merchant2

  def setup
    @test_merchant1 = Merchant.new({:id => 5, :name => "Turing School"})
    @test_merchant2 = Merchant.new({:id => 26, :name => "Laszlo and David Boulder School"})
  end

  def test_initializes_merchant
    assert test_merchant1
    assert test_merchant2
  end

  def test_it_stores_id
    assert_equal 5, test_merchant1.id
    assert_equal 26, test_merchant2.id
  end

  def test_it_stores_name
    assert_equal "Turing School", test_merchant1.name
    assert_equal "Laszlo and David Boulder School", test_merchant2.name
  end


end