require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  attr_reader   :test_merchant_repo,
                :test_one_merchant_repo

  def setup
    # @test_merchant_repo = MerchantRepository.new("./data/merchants.csv", "parent")
    @test_merchant_repo = MerchantRepository.new("./data/merchants_fixture.csv", "parent")
  end

  # def test_initialize_merchant_repository
  #   assert test_merchant_repo
  # end

  # def test_creates_merchant_list
  #   refute_empty test_merchant_repo.merchants_list
  # end

  # def test_merchant_list_stores_merchants
  #   assert_equal Merchant, test_merchant_repo.merchants_list.first.class
  # end

  # def test_all_method_on_csv_with_one_merchant
  #   assert_equal 475, test_merchant_repo.all.count
  # end

  # def test_all_method_on_merchant_all_details_id
  #   assert_equal 12334105, test_merchant_repo.all.first.id
  # end

  # def test_all_method_on_merchant_all_details_name
  #   assert_equal "Shopin1901", test_merchant_repo.all.first.name
  # end

  # def test_find_by_id_not_in_repository
  #   assert_nil test_merchant_repo.find_by_id(999)
  # end

  # def test_find_by_id_is_in_merchant_list
  #   assert_equal 12334105, test_merchant_repo.find_by_id(12334105).id
  # end

  # def test_find_by_name_not_in_repository
  #   assert_nil test_merchant_repo.find_by_name("999")
  # end

  # def test_find_by_name_is_in_merchant_list
  #   assert_equal 12334105, test_merchant_repo.find_by_name("Shopin1901").id
  #   assert_equal "Shopin1901", test_merchant_repo.find_by_name("Shopin1901").name
  # end
  
  # def test_find_all_by_name_not_in_repository
  #   assert_empty test_merchant_repo.find_all_by_name("999")
  # end

  # def test_find_all_by_name_is_in_merchant_list
  #   assert_equal "ShopAtPinkFlamingo", test_merchant_repo.find_all_by_name("pin").last.name
  # end

  def test_merchant_calls_parent_to_find_items
    parent = MiniTest::Mock.new
    merchant_repo = MerchantRepository.new("./data/merchants_one.csv", parent)
    parent.expect(:find_items, nil, [5])
    merchant_repo.find_items(5)
    parent.verify
  end

  def test_merchant_calls_parent_to_find_invoices
    parent = MiniTest::Mock.new
    merchant_repo = MerchantRepository.new("./data/merchants_one.csv", parent)
    parent.expect(:find_invoices, nil, [5])
    merchant_repo.find_invoices(5)
    parent.verify
  end

#TESTS USING TEST FEXTURES

  def test_initialize_merchant_repository
    assert test_merchant_repo
  end

  def test_creates_merchant_list
    refute_empty test_merchant_repo.merchants_list
  end

  def test_merchant_list_stores_merchants
    assert_equal Merchant, test_merchant_repo.merchants_list.first.class
  end

  def test_all_method_on_csv_with_one_merchant
    assert_equal 3, test_merchant_repo.all.count
  end

  def test_all_method_on_merchant_all_details_id
    assert_equal 22222222, test_merchant_repo.all.first.id
  end

  def test_all_method_on_merchant_all_details_name
    assert_equal "MerchantName22222222", test_merchant_repo.all.first.name
  end

  def test_find_by_id_not_in_repository
    assert_nil test_merchant_repo.find_by_id(999)
  end

  def test_find_by_id_is_in_merchant_list
    assert_equal "MerchantName12334303", test_merchant_repo.find_by_id(12334303).name
  end

  def test_find_by_name_not_in_repository
    assert_nil test_merchant_repo.find_by_name("999")
  end

  def test_find_by_name_is_in_merchant_list
    assert_equal 44434165, test_merchant_repo.find_by_name("MERCHANTNAME44434165").id
    assert_equal "MerchantName44434165", test_merchant_repo.find_by_name("MeRcHaNtNaMe44434165").name
  end
  
  def test_find_all_by_name_not_in_repository
    assert_empty test_merchant_repo.find_all_by_name("999")
  end

  def test_find_all_by_name_is_in_merchant_list
    assert_equal 22222222, test_merchant_repo.find_all_by_name("ERC").first.id
    assert_equal "MerchantName44434165", test_merchant_repo.find_all_by_name("hANTn").last.name
  end

end