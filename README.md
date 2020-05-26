## Mission Statement

Using this CLI app, users are able to view the multifamily homes, and their details, listed for sale in and around Gloucester County.

## Overview

This app scrapes the Gloucester County Redfin page for a list of cities in and around the area. The user is able to choose a city to search, then the program scrapes a new page based on the user's input and displays the multifamily homes for sale in that city. The user is then able to view more details about the home like the description, home details, and pricing information which is then scraped by the program using a link scraped from the previous scraping. Users can even open the home's listing page in a browser.

Upon running the program, the users have the option to sign-in to a profile with a username/password or continue as a guest. A profile knows a user's name and default search area and goes right to the listings in that city, bypassing the "choose a city" step. A profile also knows a user's birthday and display's a special message on their birthday.

At any point, a user can go back to the previous page to choose a new city, new address, or log out and login to a new profile. The program will always alert the user if invalid input is received and prompt the user the try again.

## How to Run the Program

1. Fork and clone the repo and navigate to repo in your terminal of choice.
2. Type `bundle install` into the terminal to install the gems needed to run the program.
3. Run the program by typing `ruby bin/run.rb` in the terminal (this requires the environment, creates a new instance of CLI, and runs the call method which starts the program).
4. If you have a profile, login now by typing `login`, otherwise type `guest` to proceed as a guest user.
5. Using the list of cities, choose a city to search by typing its name. ex: Vineland
6. Using the list of addresses, choose an address to view more details by typing it into the terminal exactly as seen in the list. ex: 123 Main St
7. The program will ask if you would like to see price insights for the property. Type `yes` or `no`.
8. At this point users can type:
  * `back` to go back to the cities
  * `open` to open the listing in a browser
  * `exit` to exit the program


