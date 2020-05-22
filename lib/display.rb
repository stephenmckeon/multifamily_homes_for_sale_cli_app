module Display
  def display_description_and_details(property)
    puts File.open(property.ascii_art).read
    puts "\nDescription".underline
    puts "\n#{property.description.blue}"
    display_property_info(property)
    display_property_details(property)
  end

  def display_market
    puts
    City.all.each do |city|
      puts "‣ " + city.name.light_yellow
      sleep 0.2
    end
    puts
  end

  def display_property_info(property)
    puts light_black_bold("\nBeds:       ") + property.beds + \
         light_black_bold("   Baths:    ") + property.baths + \
         light_black_bold("         Sq. Ft.:        ") + property.sqft
  end

  def display_property_details(property)
    puts light_black_bold("Year Built: ") + property.year_built + \
         light_black_bold("     Lot Size: ") + property.lot_size + \
         light_black_bold("     Time on Market: ") + property.time_on_market \
         + "\n\n"
  end

  def display_properties(city)
    listings_in_city?(city)
    city.properties.each do |property|
      puts "‣ " + underline_yellow(property.address)
      puts "  ➼ #{property.price}".green
      puts "  ➼ #{property.beds}"
      puts "  ➼ #{property.baths}"
      puts "  ➼ #{property.sqft}\n\n"
      sleep 0.2
    end
  end
end
