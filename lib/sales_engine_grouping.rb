#Collection of methods used for Sales Engine group function
module SalesEngineGrouping

  def merchants_list
    merchants.all
  end

  def merchants_count
    merchants.count_all
  end

  def items_list
    items.all
  end

  def items_count
    items.count_all
  end

  def invoices_list
    invoices.all
  end

  def invoices_count
    invoices.count_all
  end

end