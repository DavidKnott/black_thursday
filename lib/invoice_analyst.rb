require_relative 'calculator'

#Colection of methods used for Invoice related
#sales analysis within sales_analyst
module InvoiceAnalyst
  include calculator
  
  def invoices_list
    sales_engine.invoices_list
  end

  def total_invoices
    sales_engine.invoices_count
  end

  def build_invoice_count_list()
    merchants_list.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant
    invoice_count_list = build_invoice_count_list
    bigdecimal_to_float(list_average(invoice_count_list))
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_count_list = build_invoice_count_list
    standard_deviation(invoice_count_list)
  end

  def top_merchants_filter(invoice_count_mean, invoice_count_std_dev)
    merchants_list.find_all do |merchant|
      merchant.invoices.count > invoice_count_mean + (2 * invoice_count_std_dev)
    end
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    top_merchants_filter(average, standard_deviation)
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    merchant_stndrd_dviation = average_invoices_per_merchant_standard_deviation
    merchants_list.find_all do |merchant|
      merchant.invoices.count < average - (2 * merchant_stndrd_dviation)
    end
  end

  def invoice_count_per_weekday
    invoices_list.reduce({}) do |sum, invoice|
      sum[invoice.created_at.wday] = 1 if sum[invoice.created_at.wday].nil?
      sum[invoice.created_at.wday] += 1 if !sum[invoice.created_at.wday].nil?
      sum
    end
  end

  def top_count_filter(summary, summary_average, summary_standard_devitation)
    numbered_weekdays = summary.keys.find_all do |weekday|
      summary[weekday] > summary_average + summary_standard_devitation
    end
    top_weekday_identifier(numbered_weekdays)
  end

  def top_weekday_identifier(numbered_weekdays)
    numbered_weekdays.map do |num|
      WEEKDAYS[num]
    end
  end

  def top_days_by_invoice_count
    weekdays = invoice_count_per_weekday
    average = list_average(weekdays.values)
    weekday_standard_deviation = standard_deviation(weekdays.values)
    top_count_filter(weekdays, average, weekday_standard_deviation)
  end

  def invoice_status(requested)
    requested_count = invoices_list.reduce(0) do |count, invoice|
      count += 1 if invoice.status == requested
      count
    end
    percentage(requested_count, total_invoices)
  end

end