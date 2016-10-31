require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  attr_reader    :test_merchant_repo

  def setup
    @test_merchant_repo = MerchantRepository.new("./data/merchants.csv")
  end

  def test_initialize_merchant_repository
    assert test_merchant_repo
  end

  def test_creates_merchant_list
    refute_empty test_merchant_repo.merchants_list
  end

  def test_merchant_list_stores_name
    assert_equal "Candisart", test_merchant_repo.merchants_list[1].name
  end

  def test_merchant_list_stores_id
    assert_equal "12334208", test_merchant_repo.merchants_list[26].id
  end
end