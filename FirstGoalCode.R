##(How has changing traffic flow impacted accidents?)
#not forget loaded libraries
library(dplyr)
library(ggplot2)
library(tidyr)
#we need select the columns 
#i am work on traffic data first to select the columns which we worked on

TrafficFirstGoal <- TrafficAADF %>%
  select(AADFYear,CP,Region,PedalCyclesVolume,
         MotorcyclesVolume,BusesCoachesVolume,
         LightGoodsVehiclesVolume,
         V2AxleRigidHGVVolume,V3AxleRigidHGVVolume,
         CarsTaxisVolume,V3or4AxleArticHGVVolume,
         V4or5AxleRigidHGVVolume,
         V5AxleArticHGVVolume,
         V6orMoreAxleArticHGVVolume,
         allVolume,allVehicles
  ) %>%
  #we filter the selected data by years to get the same years in traffic and accident files 
  #we remove the 2008 and all years that not have accidents records.
  #we remove rows which have missing value.
  filter(AADFYear != 2000,AADFYear !=2001,AADFYear !=2002,AADFYear !=2003,
         AADFYear !=2004,AADFYear !=2008,AADFYear !=2015,AADFYear !=2016)%>%
  #add columns name allVehicles be sum of AllMotorVehicles + pedal cycles
  #we add trafficVolume for calculating the volume of traffic for the whole year = lenth*365*number of vehicles 
  group_by(AADFYear)

#we selected needed columns in second data
accFirstGoal <-AllAccidents %>%
  select(Accident_Index,Number_of_Vehicles,Date,Year) %>%
  group_by(Year,Date)
#check if have missing value
sum(is.na(accFirstGoal))
sum(is.na(TrafficFirstGoal))
#not have missing values

#we do visualizations for data to know how chaging traffic flow over years
#impact on accidents by number of vehicles and traffic volume

#we see the change of  average of traffic volume over years
average_year <- summarise(TrafficFirstGoal,meanVolume = mean(allVolume))
g <- ggplot(average_year,aes(AADFYear,meanVolume))
g+geom_point()+geom_smooth(method = "lm",se = FALSE)+theme_bw()+geom_smooth(method = "loess",color="red",se = FALSE)+scale_x_discrete(limits=(2005:2014))+labs(title = "average of traffic volume over years")
#we see that the average of the traffic volume less over year

#we see the impact by average of allvehicles on each road over years
average_year <- summarize(TrafficFirstGoal,meanVehicle = mean(allVehicles))
g <- ggplot(average_year,aes(AADFYear,meanVehicle))
g+geom_point()+geom_smooth(method = "lm",se = FALSE)+geom_smooth(method = "loess",se = FALSE,color = "red")+theme_bw()+geom_smooth(method = "loess",color="red",se = FALSE)+scale_x_discrete(limits=(2005:2014))+labs(title ="average of allvehicles on each road over years")
#we see that over years traffic less more than year before so we look at the
#accidents average over year too

#to make the best and specified result we sould take care that the traffic flow
#be the average annual daily so we must get the all accident on a day and
#then calculate the annual average

#get the sum of accidents be done on every day
average_day<- summarize(accFirstGoal,number_accident_day=n())
#group the data result by year to can get the mean of year of accidents 
average_year<-group_by(average_day,Year)
#we can get the daily annually average of accidents 
average_year <- summarize(average_year,average_in_year = mean(number_accident_day))
g<- ggplot(average_year,aes(Year,average_in_year))
g+geom_point()+geom_smooth(method = "lm",se = FALSE)+geom_smooth(method = "loess",se = FALSE,color = "red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "daily annually average of accidents")

#get the sum of number of vehicles accidents be done on every day
average_day<- summarize(accFirstGoal,sum_accident_day=sum(Number_of_Vehicles))
#group the data result by year to can get the mean of year of number of vehicles of accidents 
average_year<-group_by(average_day,Year)
#we can get the annual daily average of number of vehicles of accidents 
average_year <- summarize(average_year,number_of_vehicles = mean(sum_accident_day))

#we visualize the result to see the average of Number_of_Vehicles of accidents over years
g<- ggplot(average_year,aes(Year,number_of_vehicles))
g+geom_point()+geom_smooth(method = "loess",se = F)+geom_smooth(method = "loess",se = FALSE,color = "red")+geom_smooth(method = "lm",se = F)+theme_bw()+ scale_x_discrete(limits=(2005:2014))+labs(title = "average of Number_of_Vehicles of accidents over years")
#we see that the accidents less over year

#we see the most year accidents be done
g<-ggplot(accFirstGoal,aes(Year,color = Year))
g+geom_bar()+scale_x_discrete(limits=(2005:2014))+labs(title = "accident rate over years")
#we see how accident rate less over time

#when look to the two graph we see when the traffic flow less over year
#the accidents less too

#we look to the number of all kind of cars and how changed over years
pedalCycle<- summarise(TrafficFirstGoal,average_cycle = mean(PedalCyclesVolume))
g <- ggplot(pedalCycle,aes(AADFYear,average_cycle))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "pedal cycle average over year")
#we see that the use of cycles increase over years

motorcycle<- summarise(TrafficFirstGoal,average_motor = mean(MotorcyclesVolume))
g <- ggplot(motorcycle,aes(AADFYear,average_motor))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "motor cycle average over year")
#we see that the motor cycle less over time.

busescoaches<- summarise(TrafficFirstGoal,average_buses = mean(BusesCoachesVolume))
g <- ggplot(busescoaches,aes(AADFYear,average_buses))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "buses coaches average over year")
#buses less slowly as fell it not change

taxis<- summarise(TrafficFirstGoal,average_taxis = mean(CarsTaxisVolume))
g <- ggplot(taxis,aes(AADFYear,average_taxis))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "taxis average over year")
#taxis less over years

lightGood<- summarise(TrafficFirstGoal,average_light = mean(LightGoodsVehiclesVolume))
g <- ggplot(lightGood,aes(AADFYear,average_light))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "light goods average over year")
#we see the light good vechicles increased over years.

hgv<- summarise(TrafficFirstGoal,average_v2 = mean(V2AxleRigidHGVVolume))
g <- ggplot(hgv,aes(AADFYear,average_v2))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "V2AxleRigidHGV average over year")
#we see that V2AxleRigidHGV less over years

hgv<- summarise(TrafficFirstGoal,average_v3 = mean(V3AxleRigidHGVVolume))
g <- ggplot(hgv,aes(AADFYear,average_v3))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "V3AxleRigidHGV average over year")
#V3AxleRigidHGV still stand but increase slowly over years

hgv<- summarise(TrafficFirstGoal,average_v34 = mean(V3or4AxleArticHGVVolume))
g <- ggplot(hgv,aes(AADFYear,average_v34))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "V3or4AxleRigidHGV average over year")
#we see this V3or4AxleRigidHGV still stand

hgv<- summarise(TrafficFirstGoal,average_v5 = mean(V5AxleArticHGVVolume))
g <- ggplot(hgv,aes(AADFYear,average_v5))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "V5AxleRigidHGV average over year")
#we see V5AxleRigidHGV less over years.

hgv<- summarise(TrafficFirstGoal,average_v45 = mean(V4or5AxleRigidHGVVolume))
g <- ggplot(hgv,aes(AADFYear,average_v45))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "V4or5AxleRigidHGV average over year")
#we see  V4or5AxleRigidHGV still stand 

hgv<- summarise(TrafficFirstGoal,average_v6 = mean(V6orMoreAxleArticHGVVolume))
g <- ggplot(hgv,aes(AADFYear,average_v6))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",se=F,color="red")+theme_bw()+scale_x_discrete(limits=(2005:2014))+labs(title = "V6ormoreAxleRigidHGV average over year")
#we see that increase of V6ormoreAxleRigidHGV 

#to overcome the busy flow we must control the average of the following cars
#V6orMoreAxleArticHGV / LightGoodsVehicles / pedal cycles

#the differance between region of flow and volume 
g<- ggplot(TrafficFirstGoal,aes(Region,allVolume,color = AADFYear))
g+geom_point()+theme_bw()+labs(title ="the differance between region of flow and volume " )
