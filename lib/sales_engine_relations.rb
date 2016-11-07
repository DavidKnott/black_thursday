#Collection of methods used for Sales Engine relations methods
module SalesEngineRelations

  def find_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_items(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_transaction(transaction_id)
    transactions.find_by_id(transaction_id)
  end

  def find_transactions(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_invoices_for_customer(customer_id)
    invoices.find_all_by_customer_id(customer_id)
  end

  def find_item(item_id)
    items.find_by_id(item_id)
  end

end