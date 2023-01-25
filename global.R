library(dplyr)
library(ggplot2)
library(ggtext)
library(plotly)
library(maps)
library(leaflet)
library(DT)
library(shinyBS)
library(rgdal)

#NGO data
my_data <- NGOs

#structure of the data
my_data %>%
  str()

#first few observations
my_data%>%
  head()

#Assigning row names
Nama = rownames(my_data)


#PWD data
my_PWDdata <- PWDs

#structure of the data
my_PWDdata %>%
  str()

#Summary
my_PWDdata%>%
  summary()

#first few observations
my_PWDdata%>%
  head()

#Scatter data
Newscatter_data <- average

#structure of the data
Newscatter_data %>%
  str()

#Summary
Newscatter_data%>%
  summary()

#first few observations
Newscatter_data%>%
  head()

#Bae chart data
bar_data <- PWDs


#structure of the data
bar_data %>%
  str()

#Summary
bar_data%>%
  summary()

#first few observations
bar_data%>%
  head()

#NGO bar chart data
barNGO_data <- NGOnum

#structure of the data
barNGO_data %>%
  str()

#Summary
barNGO_data%>%
  summary()

#first few observations
barNGO_data%>%
  head()

#Column without state and total
c1 = bar_data %>%
  select(-"State") %>%
  names()


#NGO lat and long data
NGOlatlong_data <- NGOlat_long


#structure of the data
NGOlatlong_data %>%
  str()

#Summary
NGOlatlong_data%>%
  summary()

#first few observations
NGOlatlong_data%>%
  head()


#Column without state and total
c2 = NGOlatlong_data %>%
  select(-"Nama Pertubuhan", -"Alamat", 
         -"Email", -"No Tel", -"Latitude", -"Longitude") %>%
  names()

#Chloro chart data
chloro_data <- Chloro

#structure of the data
chloro_data %>%
  str()

#Summary
chloro_data%>%
  summary()

#first few observations
chloro_data%>%
  head()

#NGO data
myNew_data <- NGOs

#structure of the data
myNew_data %>%
  str()

#first few observations
myNew_data%>%
  head()
