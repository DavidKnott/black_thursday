class SalesEngine

  attr_accessor   :items_file,
                  :merchants_file,
                  :merchants

  def self.from_csv(list_of_file_names)
    return "Please Enter Valid File Names" if all_valid?(list_of_file_names)
    sales_engine = self.new
    sales_engine.items_file = list_of_file_names[:items]
    sales_engine.merchants_file = list_of_file_names[:merchants]
    create_merchant_repository
    sales_engine
  end

  def self.create_merchant_repository
    # merchants = MerchantRepository.new(merchants_file)
    "hi from merhant repo"
  end

  def self.all_valid?(list_of_file_names)
    list_of_file_names.values.none? do |path|
      File.exist?(path)
    end
  end

end