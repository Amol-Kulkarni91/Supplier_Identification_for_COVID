# load the necessary libraries

library(rvest)
library(dplyr)
library("writexl")

# Parse the contents using the read_html function

plastic_ind <- read_html("https://www.iqsdirectory.com/plastics/plastics-2/")

# Extract the html node matching the css selector object and convert it into text using html_text

name <- plastic_ind %>% html_nodes("a span") %>% 
  html_text()
city_state <- plastic_ind %>% html_nodes(".addr span") %>% 
  html_text()
tel <- plastic_ind %>% html_nodes(".addr a") %>% 
  html_text()

# Combine the text files into a dataframe

plastic_industry <- data.frame(Name = name, City = city_state, phone = tel)

# Separate the City and State from the address into their features

plastic_industry <- plastic_industry %>% separate(City, c("City", "State"), ",")

# Write into an excel file
write_xlsx(plastic_industry,"filepath//plastic_industries.xlsx")
