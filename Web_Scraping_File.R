library(rvest)
library(dplyr)

plastic_ind <- read_html("https://www.iqsdirectory.com/plastics/plastics-2/")




name <- plastic_ind %>% html_nodes("a span") %>% 
  html_text()


city_state <- plastic_ind %>% html_nodes(".addr span") %>% 
  html_text()

tel <- plastic_ind %>% html_nodes(".addr a") %>% 
  html_text()


plastic_industry <- data.frame(Name = name, City = city_state, phone = tel)


plastic_industry <- plastic_industry %>% separate(City, c("City", "State"), ",")


library("writexl")
write_xlsx(plastic_industry,"C:\\Users\\amolk\\Box Sync\\Facepiece Respirator Project\\plastic_industries.xlsx")




url <- "https://www.thomasnet.com/local.html?cov=NA&heading=60109006&radius=1000&sortby=Featured&what=plastics&which=prod&zip=16801&pg=1"

url %>% read_html() %>% html_nodes(".profile-card__location+ span , .profile-card__location a , .profile-card__title a") %>% html_text()

ls <- paste("https://www.thomasnet.com/local.html?cov=NA&heading=60109006&radius=1000&sortby=Featured&what=plastics&which=prod&zip=16801&pg=", 1:21, sep ="")

names <- {}
locations <- {}
types <- {}
for (i in ls){
   name <- i %>% read_html() %>%
              html_nodes(".profile-card__title a") %>%
                  html_text()
   location <- i %>% read_html() %>%
                  html_nodes(".profile-card__location a") %>% html_attr("href")
   
   type <- i %>% read_html() %>%
              html_nodes(".profile-card__location+ span") %>%
                html_text()
   
   names <- c(names, name)
   locations <- c(locations, location)
   types <- c(types, type)
}

address <- {}
types1 <- {}
for (j in locations){
  url <- paste("https://www.thomasnet.com", j, sep = "")
  #add <- url %>% read_html() %>%
  #              html_nodes(".addrline") %>% html_text()
  
  type1 <- url %>% read_html() %>%
                html_node(".supplier-badge--mobile-icon+ span") %>% html_text()
  
  #address <- c(address, add)        
  types1 <- c(types1, type1)
  
}


plastic_ind <- data.frame(Name = names, Type = types, Location = address)
write_xlsx(plastic_ind,"C:\\Users\\amolk\\Box Sync\\Facepiece Respirator Project\\plastic_industries_thomas.xlsx")
