module Check
  def year_built_check
    year_built = @home_details.find do |item|
      text = item.text
      (text.start_with?("18") && text.length == 4) ||
        (text.start_with?("19") && text.length == 4) ||
        (text.start_with?("20") && text.length == 4)
    end
    @year_built = year_built.nil? ? "-- " : year_built.text
  end

  def lot_size_check
    lot_size = @home_details.find do |item|
      item.text.include?("Sq. Ft.") || item.text.include?("Acre")
    end
    @lot_size = lot_size.nil? ? "-- " : lot_size.text
  end

  def time_on_market_check
    time_on_market = @home_details.find do |item|
      item.text.include?("day")
    end
    @time_on_market = time_on_market.nil? ? "-- " : time_on_market.text
  end

  def est_price_check
    est_price = nil
    if @home_details[2].text.length.between?(7, 11)
      est_price = @home_details[2].text
    end
    @est_price = est_price.nil? ? "--        " : est_price
  end

  def est_mo_payment_check
    est_mo_payment = nil
    if @home_details[1].text.length.between?(4, 6) &&
       @home_details[1].text.start_with?("$")
      est_mo_payment = @home_details[1].text
    end
    @est_mo_payment = est_mo_payment.nil? ? "-- " : est_mo_payment
  end

  def price_sqft_check
    if @property.sqft == "\u2014Sq. Ft."
      @price_sqft = "-- "
    else
      price_sqft = @property.price.delete("$,").to_i \
                 / @property.sqft.delete(",Sq.Ft. ").to_i
      @price_sqft = "$" + price_sqft.to_s
    end
  end
end
