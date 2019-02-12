
### clean data and manipulation process

#load dplyr and tidyr package which have a important function that we need
#in cleaning 
library(dplyr)
library(tidyr)
#read data csv files
#"acc" variable content the  accidents data which we work in, in specified period .
#for prevent character columns to convert to vector we use argument "stringsAsFactors = FALSE"
acc_2005_2007 <- read.csv("data/accidents_2005_to_2007.csv", stringsAsFactors = FALSE)
acc_2009_2011 <- read.csv("data/accidents_2009_to_2011.csv", stringsAsFactors = FALSE)
acc_2012_2014 <- read.csv("data/accidents_2012_to_2014.csv", stringsAsFactors = FALSE)
#save data as a tabular data to can work in it and use dplyr and tidyr functions
acc_05_07 <- tbl_df(acc_2005_2007)
acc_09_11 <- tbl_df(acc_2009_2011)
acc_12_14 <- tbl_df(acc_2012_2014)

#we can do last two process(read data and convert to a data frame)
#in one comand like following by this way we not need to remove original data to can transform data
#"TrafficAADF" The year data was recorded of traffic flow
TrafficAADF <- tbl_df(read.csv("data/ukTrafficAADF.csv", stringsAsFactors = FALSE))

#remove the original data to save it, and prevent confused
#we can remove only specified data as following
rm("acc_2012_2014")
#or remove all datas which i want to remove as a list in one command
rm(list = c("acc_2005_2007","acc_2009_2011"))

#we look at the head of data
head(acc_05_07)
head(acc_09_11)
head(acc_12_14)
head(TrafficAADF)

#we need to explore data and know structure of data
#so we can use some of function to do this like: summary(), str(), class()
#we not need to repeat explore proces to others accidents files
#because all have the same result.
class(acc_05_07)
str(acc_05_07)
summary(acc_05_07)

#traffic data
class(TrafficAADF)
str(TrafficAADF)
summary(TrafficAADF)

#now our data need to clean replicated data and remove missing values
#we want to check if traffic data and accidents data have duplicated data
sum(duplicated(acc_05_07))
sum(duplicated(acc_09_11))
sum(duplicated(acc_12_14))
sum(duplicated(TrafficAADF))
#we found duplicated data just in accidents data files so i remove it using
#unique() function and resave it to save data
acc_05_07 <- unique(acc_05_07)
acc_09_11 <- unique(acc_09_11)
acc_12_14 <- unique(acc_12_14)
#next step it remove missing value data.
#check if data have missing values
sum(is.na(acc_05_07))
sum(is.na(acc_09_11))
sum(is.na(acc_12_14))
sum(is.na(TrafficAADF))
#missing value just found in accident data files
#na.omit() use to remove all missing values in data frame if found
#but we not remove it now ,because i have junction_detail columns have a lot
#missing value

#the accident data devided into three files
#we need to combine data to can visualize
#we use rbind() function to combine accident data files where all accident
#files have the same strucure
AllAccidents <- rbind(acc_05_07,acc_09_11,acc_12_14)
head(AllAccidents)
summary(AllAccidents)
str(AllAccidents)
class(AllAccidents)
#now data ready to visualize but remember that we still have missing values 
#in accidents data files

#we add columns for traffic value which have traffic volume inn each road
TrafficAADF <- mutate(TrafficAADF,
                      PedalCyclesVolume = PedalCycles*LinkLength_miles*365,
                      MotorcyclesVolume = Motorcycles*LinkLength_miles*365,
                      BusesCoachesVolume = BusesCoaches*LinkLength_miles*365,
                      LightGoodsVehiclesVolume = LightGoodsVehicles*LinkLength_miles*365,
                      V2AxleRigidHGVVolume = V2AxleRigidHGV*LinkLength_miles*365,
                      V3AxleRigidHGVVolume = V3AxleRigidHGV*LinkLength_miles*365,
                      V3or4AxleArticHGVVolume = V3or4AxleArticHGV*LinkLength_miles*365,
                      V4or5AxleRigidHGVVolume = V4or5AxleRigidHGV*LinkLength_miles*365,
                      CarsTaxisVolume = CarsTaxis*LinkLength_miles*365,
                      V5AxleArticHGVVolume = V5AxleArticHGV*LinkLength_miles*365,
                      V6orMoreAxleArticHGVVolume = V6orMoreAxleArticHGV*LinkLength_miles*365,
                      allVehicles=AllMotorVehicles+PedalCycles,
                      allVolume = V6orMoreAxleArticHGVVolume + V5AxleArticHGVVolume+
                        CarsTaxisVolume+V4or5AxleRigidHGVVolume+V3or4AxleArticHGVVolume+
                        V3AxleRigidHGVVolume+V2AxleRigidHGVVolume+LightGoodsVehiclesVolume+
                        BusesCoachesVolume+MotorcyclesVolume+PedalCyclesVolume
                      )

#we edit the road category name errors
TrafficAADF$RoadCategory[TrafficAADF$RoadCategory == "Pu"] <- "PU"
TrafficAADF$RoadCategory[TrafficAADF$RoadCategory == "Tu"] <- "TU"

#we rename day of week in accidents file
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 1]<-"Monday"
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 2]<-"Tuesday"
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 3]<-"Wendsday"
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 4]<-"Thursday"
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 5]<-"Friday"
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 6]<-"Saturday"
AllAccidents$Day_of_Week[AllAccidents$Day_of_Week== 7]<-"Sunday"

#we will rename the accident 
AllAccidents$Urban_or_Rural_Area[AllAccidents$Urban_or_Rural_Area== 1]<-"Rural"
AllAccidents$Urban_or_Rural_Area[AllAccidents$Urban_or_Rural_Area== 2]<-"Urban"
#--------------------------------------------------------------------------------------
