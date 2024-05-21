##NFL DRAFT COMBINE VISUALIZATION
##GENE PARK

library(tidyverse)
library(rvest)
library(dplyr)

##2024 Data

link <- "https://www.pro-football-reference.com/draft/2012-combine.htm"

read_data <- read_html(link)

draft_data <- read_data %>%
  html_nodes(css = "table") %>% 
  html_table(fill = TRUE)

draft_data <- data.frame(draft_data)
draft_data<- draft_data %>%
  mutate(year = 2012)

view(draft_data)



for(x in 2013:2024) {
  linkx <- ""
  link <- "https://www.pro-football-reference.com/draft/"
  x <- as.integer(x)
  last_tag <- "-combine.htm"
  linkx <- paste0(link, x, last_tag) ##link x is now the iterator from 2012 to 2023
  
  draft_web <- read_html(linkx)
  
  draft_temp <- draft_web %>%
    html_nodes(css = "table") %>% 
    html_table(fill = TRUE)
  
  draft_temp <- data.frame(draft_temp)
  
  draft_temp <- draft_temp %>%
    mutate(year = x)
  
  
  draft_data <- rbind(draft_data, draft_temp)
  
}

##View if needed. This dataset contains 2012- 2024
view(draft_data)
print(nrow(draft_data))
#4488


##Need to clean up the data

## I've notcied that some rows inform of what the column represents every once in a while in the data
## Therefore, I'm going to be getting rid of those. There is around 5 of these in each year, so there should
## 13 * 5 => 75 rows

draft_data_clean <- draft_data %>%
  filter(Player != "Player")


print(nrow(draft_data_clean))
##4407 


## I've also noticed that rows have 40yd but don't have their weight or vice versa.
##If I'm trying to make a correlation out of the two, I need both values not just one. 

combine_data <- draft_data_clean %>%
  filter(!X40yd == "" &  !Wt == "")


print(nrow(combine_data))
view(combine_data)


names(combine_data)[13] <- "draft_info"

view(combine_data)




write.csv(combine_data, file = "combine_data.csv", row.names = FALSE)







