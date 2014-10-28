require(rvest)

# This is the State Department website for the US Visa Waiver Program. We want to get a list of all
# countries whose citizens do not require a tourist visa to enter the US.

stateSite <- "http://travel.state.gov/content/visas/english/visit/visa-waiver-program.html"
  
visaWaiver <- stateSite %>%
  html() %>%
  html_nodes("#countryList span+ span , .alpha+ span") %>%
  html_text()

visaWaiver

# I also wanted to pull the images of the tiny flags for each country

flags <- stateSite %>%
  html() %>%
  html_nodes("#countryList img") %>%
  html_attr("src")

# Now let's pull the topics from the index

stateSite2 <- "http://travel.state.gov/content/visas/english/general/a-z.html"

visaIndex <- stateSite2 %>%
  html() %>%
  html_nodes(".simple_richtextarea a") %>%
  html_text()

visaIndex


