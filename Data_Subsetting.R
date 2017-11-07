# Setting up for R Tutorial

#### Set working directory ####

# Mark's home computer
#setwd("C:/Users/kramp_000/SkyDrive/Documents/502 Project Online")

#### Packages ####

#install.packages("dplyr")
#install.packages("tidyr")

#install.packages("ggmap")
#install.packages("countrycode")

library(dplyr)
library(tidyr)

library(ggmap)
library(countrycode)

#### Read NYT Phoenix ####
NYT <- read.csv(file ="502 Project/Phoenix Processed/NYT_Geolocated.csv")

head(NYT)

NYT.aoi <- NYT %>% 
  filter(countryname == "RUS" | 
           countryname == "GEO" | 
           countryname == "ARM" | 
           countryname == "AZE" | 
           countryname == "TUR") %>%
  mutate(date = as.Date(date))
  
unique(NYT.aoi$countryname)

NYT.aoi$cameo.root[NYT.aoi$quad_class == 0] <- "Neutral" 
NYT.aoi$cameo.root[NYT.aoi$quad_class == 1] <- "Verbal cooperation" 
NYT.aoi$cameo.root[NYT.aoi$quad_class == 2] <- "Material cooperation" 
NYT.aoi$cameo.root[NYT.aoi$quad_class == 3] <- "Verbal conflict" 
NYT.aoi$cameo.root[NYT.aoi$quad_class == 4] <- "Material conflict" 

head(NYT.aoi)

write.csv(NYT.aoi, "Mark Tutorial/data/NYT.csv",  row.names=FALSE)

#### Read FBIS Phoenix ####
FBIS <- read.csv(file ="502 Project/Phoenix Processed/FBIS_Geolocated.csv")

head(FBIS)

FBIS.aoi <- FBIS %>% 
  filter(countryname == "RUS" | 
           countryname == "GEO" | 
           countryname == "ARM" | 
           countryname == "AZE" | 
           countryname == "TUR") %>%
  mutate(date = as.Date(date))

FBIS.aoi$cameo.root[FBIS.aoi$quad_class == 0] <- "Neutral" 
FBIS.aoi$cameo.root[FBIS.aoi$quad_class == 1] <- "Verbal cooperation" 
FBIS.aoi$cameo.root[FBIS.aoi$quad_class == 2] <- "Material cooperation" 
FBIS.aoi$cameo.root[FBIS.aoi$quad_class == 3] <- "Verbal conflict" 
FBIS.aoi$cameo.root[FBIS.aoi$quad_class == 4] <- "Material conflict" 

head(FBIS.aoi)

write.csv(FBIS.aoi, "Mark Tutorial/data/FBIS.csv",  row.names=FALSE)

#### Read SWB Phoenix ####
SWB <- read.csv(file ="502 Project/Phoenix Processed/SWB_Geolocated.csv")

head(SWB.aoi)

SWB.aoi <- SWB %>% 
  filter(countryname == "RUS" | 
           countryname == "GEO" | 
           countryname == "ARM" | 
           countryname == "AZE" | 
           countryname == "TUR") %>%
  mutate(date = as.Date(story_date, format="%m/%d/%Y") )

SWB.aoi$cameo.root[SWB.aoi$quad_class == 0] <- "Neutral" 
SWB.aoi$cameo.root[SWB.aoi$quad_class == 1] <- "Verbal cooperation" 
SWB.aoi$cameo.root[SWB.aoi$quad_class == 2] <- "Material cooperation" 
SWB.aoi$cameo.root[SWB.aoi$quad_class == 3] <- "Verbal conflict" 
SWB.aoi$cameo.root[SWB.aoi$quad_class == 4] <- "Material conflict" 

head(SWB.aoi)

write.csv(SWB.aoi, "Mark Tutorial/data/SWB.csv",  row.names=FALSE)

#### Read ICEWS Phoenix ####
ICEWS <- read.csv(file ="C:/Users/mbs278/Desktop/ICEWS/Processed Data/ICEWS_Geo_Select.csv")

head(ICEWS)

sort(unique(ICEWS$Country))
#countries <- unique(ICEWS$Country)
#countrycode(countries, "country.name", "iso3c")

ICEWS.aoi <- ICEWS %>% 
  filter(Country == "Russian Federation" | 
           Country == "Georgia" | 
           Country == "Armenia" | 
           Country == "Azerbaijan" | 
           Country == "Turkey") %>%
  mutate(date = as.Date(Event.Date )) %>%
  mutate(countryname = countrycode(Country, "country.name", "iso3c"))

# Check data
head(ICEWS.aoi)


# 30% sample
ICEWS.sample <- sample_frac(ICEWS.aoi, .3)

write.csv(ICEWS.sample, "W:/Mark OneDrive/OneDrive/Documents/502 Project Online/Mark Tutorial/Mark-SODA-502-Methods/data/ICEWS.csv",  row.names=FALSE)


#### Misc ####

NYT$countryname

#### Bounding Box for Rus-Georgia war ####
map <- get_map(location =c(43.6, 42), zoom = 7)
ggmap(map)
rus.geo.war.bb <- attr(map, "bb")
