require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  attr_reader   :test_merchant_repo,
                :test_one_merchant_repo

  def setup
    @test_merchant_repo = MerchantRepository.new("./data/merchants.csv")
    @test_one_merchant_repo = MerchantRepository.new("./data/merchants_one.csv")
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

  def test_all_method_on_csv_with_one_merchant
    assert_equal 1, test_one_merchant_repo.all.count
    assert_equal 475, test_merchant_repo.all.count
  end

  def test_all_method_on_merchant_all_details_id
    assert_equal "12334165", test_one_merchant_repo.all.first.id
    assert_equal "12334105", test_merchant_repo.all.first.id
  end

  def test_all_method_on_merchant_all_details_name
    assert_equal "JUSTEmonsters", test_one_merchant_repo.all.first.name
    assert_equal "Shopin1901", test_merchant_repo.all.first.name
  end

  def test_find_by_id_not_in_merchant_list
    assert_nil test_one_merchant_repo.find_by_id("555")
    assert_nil test_merchant_repo.find_by_id("999")
  end

  def test_find_by_id_is_in_merchant_list
    assert_equal "12334165", test_one_merchant_repo.find_by_id("12334165").id
    assert_equal "JUSTEmonsters", test_one_merchant_repo.find_by_id("12334165").name
    assert_equal "12334105", test_merchant_repo.find_by_id("12334105").id
    assert_equal "Shopin1901", test_merchant_repo.find_by_id("12334105").name
  end

  def test_find_by_name_not_in_merchant_list
    assert_nil test_one_merchant_repo.find_by_name("555")
    assert_nil test_merchant_repo.find_by_name("999")
  end

  def test_find_by_name_is_in_merchant_list
    assert_equal "12334165", test_one_merchant_repo.find_by_name("JUSTEmonsters").id
    assert_equal "JUSTEmonsters", test_one_merchant_repo.find_by_name("JUSTEmonsters").name
    assert_equal "12334105", test_merchant_repo.find_by_name("Shopin1901").id
    assert_equal "Shopin1901", test_merchant_repo.find_by_name("Shopin1901").name
  end
  
  def test_find_all_by_name_not_in_merchant_list
    assert_empty test_one_merchant_repo.find_all_by_name("555")
    assert_empty test_merchant_repo.find_all_by_name("999")
  end

  def test_find_all_by_name_is_in_merchant_list
    assert_equal "12334165", test_one_merchant_repo.find_all_by_name("nster").first.id
    assert_equal "JUSTEmonsters", test_one_merchant_repo.find_all_by_name("TEmo").first.name
    assert_equal "12335519", test_merchant_repo.find_all_by_name("pin").last.id
    assert_equal "TIGHTpinch", test_merchant_repo.find_all_by_name("pin").last.name
  end

end