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

head(ICEWS.aoi)

#Check values
sort(unique(ICEWS.aoi$CAMEO.Code))

#### CAMEO Codes Processing #### 

# Copy over CAMEO codes
ICEWS.aoi$CAMEO.Code.2 <- as.character(ICEWS.aoi$CAMEO.Code)

head(ICEWS.aoi$CAMEO.Code.2)
unique(ICEWS.aoi$CAMEO.Code.2)

# Truncate cameo code by 1 if value over 1000
ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 1000] <- 
  substr(ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 1000], 1, 
         nchar(ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) >= 1000]) - 1)


# Truncate cameo code by 1 if value over 100
ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 100] <- 
  substr(ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 100], 1, 
         nchar(ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) >= 100]) - 1)

# Truncate cameo code by 1 if Cameo.Code.2 value over 20
ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 20] <- 
  substr(ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 20], 1, 
         nchar(ICEWS.aoi$CAMEO.Code.2[as.numeric(ICEWS.aoi$CAMEO.Code.2) > 20]) - 1)

# Convert to numeric
ICEWS.aoi$CAMEO.Code.2 <- as.numeric(ICEWS.aoi$CAMEO.Code.2)

head(ICEWS.aoi)

# Check values
sort(unique(ICEWS.aoi$CAMEO.Code.2))

# Assign Cameo root according to 2-digit code
ICEWS.aoi$cameo.root <- "Material conflict" 
ICEWS.aoi$cameo.root[ICEWS.aoi$CAMEO.Code.2 == 16] <- "Verbal conflict" 
ICEWS.aoi$cameo.root[ICEWS.aoi$CAMEO.two < 14] <- "Verbal conflict" 
ICEWS.aoi$cameo.root[ICEWS.aoi$CAMEO.Code.2 < 9 ] <- "Material cooperation"
ICEWS.aoi$cameo.root[ICEWS.aoi$CAMEO.Code.2 < 6 ] <- "Verbal cooperation" 
ICEWS.aoi$cameo.root[ICEWS.aoi$CAMEO.Code.2 < 3] <- "Neutral" 

unique(ICEWS.aoi$cameo.root)
head(ICEWS.aoi)

nrow(ICEWS.aoi)

# 30% sample
ICEWS.sample <- sample_frac(ICEWS.aoi, .3)

write.csv(ICEWS.sample, "Mark Tutorial/Mark-SODA-502-Methods/data/ICEWS.csv",  row.names=FALSE)


#### Misc ####

NYT$countryname

#### Bounding Box for Rus-Georgia war ####
map <- get_map(location =c(43.6, 42), zoom = 7)
ggmap(map)
rus.geo.war.bb <- attr(map, "bb")
