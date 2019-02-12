#How have Rural and Urban areas differed (See RoadCategory column) 
library(dplyr)
library(tidyr)
library(ggplot2)

#we selected the needed columns for accidents files
accEighthGoal <- AllAccidents %>%
  select(Accident_Index,Urban_or_Rural_Area)

#we select the needed columns for traffic files
trafficEighthGoal <- TrafficAADF %>%
  select(AADFYear,Region,LocalAuthority,Road,RoadCategory,PedalCyclesVolume,
        MotorcyclesVolume,BusesCoachesVolume,
        LightGoodsVehiclesVolume,
        V2AxleRigidHGVVolume,V3AxleRigidHGVVolume,
        CarsTaxisVolume,V3or4AxleArticHGVVolume,
        V4or5AxleRigidHGVVolume,V5AxleArticHGVVolume,
        V6orMoreAxleArticHGVVolume,
        AllHGVs,AllMotorVehicles,allVolume,allVehicles)

#check if have missing value
sum(is.na(trafficEighthGoal))
sum(is.na(accEighthGoal))
#we not found any missing value

#we see where the accident be more in rural or urban
g<- ggplot(accEighthGoal,aes(Urban_or_Rural_Area,fill = factor( Urban_or_Rural_Area)))
g+geom_bar()+labs(title = "the accident rate in rural and urban")
#the accident in rural is more than in urban and we see that the 
#flow in rural is more than urban in road category

#we see which road category be more flow
g <- ggplot(trafficEighthGoal,aes(RoadCategory,allVolume,color ="red"))
g+geom_point()+theme_bw()+labs(title = "flow for each road category")
#and see that in the first place TM

#we now filter data to get the rural and urban roads for road category
UrbanRural <- filter(trafficEighthGoal,RoadCategory == "TR" | RoadCategory == "PR"
                     | RoadCategory == "PU" | RoadCategory == "TU") %>%
  group_by(AADFYear,RoadCategory)

average_category <- summarise(UrbanRural,meanallVolume = mean(allVolume))
g<-ggplot(average_category,aes(AADFYear,meanallVolume,color = RoadCategory))
g+geom_point()+theme_bw()+geom_smooth(method = "loess",se = F)+scale_x_discrete(limits=(2000:2016))+labs(title = "the rural and urban roads for road category")
#we see that the average of traffic volume in Rural is be more than in Urban

#we will study the average of each vehicles in over years in road category
g <- ggplot(average_category,aes(AADFYear,meanallVolume,color = AADFYear))
g+geom_point()+geom_smooth(method = "lm",se = F)+facet_grid(.~RoadCategory)+theme_bw()+labs(title = "the average of each vehicles in over years in road category")
#we see that the average of vehicles in urban is be more than in rural

#we calculate the global average of all vehicles to use it as standred
global_average <- mean(TrafficAADF$allVolume)

#we will see the flow of each vehicle in urban and rural for whole road category
#we start with pedal cycles
g <- ggplot(UrbanRural,aes(RoadCategory,PedalCyclesVolume,color = factor (RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of pedal cycles in urban and rural for whole road category")
#we see that the pedal cycles not overcome the global average.
#and see that the average in PU is very large in urban than rural

#motor cycles 
g <- ggplot(UrbanRural,aes(RoadCategory,MotorcyclesVolume,color = factor (RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of motor cycles in urban and rural for whole road category")
#we see that the average of motor cycle is still stand over years almost in road category 
#and not overcome the global average

#buses coaches
g <- ggplot(UrbanRural,aes(RoadCategory,BusesCoachesVolume,color =factor( RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of buses coaches in urban and rural for whole road category")
#we see that the average of buses coaches is still stand over years almost in road category 
#not overcome the global average

#Light goods
g <- ggplot(UrbanRural,aes(RoadCategory,LightGoodsVehiclesVolume,color = factor(RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of light goods in urban and rural for whole road category")
#all road category overcome the global average 
#the light goods used more in rural roads spechially TU roads

#V2AxleRigidHGV
g <- ggplot(UrbanRural,aes(RoadCategory,V2AxleRigidHGVVolume,color =factor( RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of V2AxleRigidHGV in urban and rural for whole road category")
#not overcome the global average and used more in TR road category 

#V3AxleRigidHGV
g <- ggplot(UrbanRural,aes(RoadCategory,V3AxleRigidHGVVolume,color =factor( RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of V3AxleRigidHGV in urban and rural for whole road category")
#not overcome the global average and still stand over years almost

#CarsTaxis
g <- ggplot(UrbanRural,aes(RoadCategory,CarsTaxisVolume,color = factor(RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of car taxis in urban and rural for whole road category")
#taxis is main problem of flow in rural and urban
#taxis over come the all road category in rural and uraban 

#V3or4AxleArticHGV
g <- ggplot(UrbanRural,aes(RoadCategory,V3or4AxleArticHGVVolume,color = factor(RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of V3or4AxleRigidHGV in urban and rural for whole road category")
#not overcome the global average but
#but less in TR over years

#V4or5AxleRigidHGV
g <- ggplot(UrbanRural,aes(RoadCategory,V4or5AxleRigidHGVVolume,color = factor(RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of V4or5AxleRigidHGV in urban and rural for whole road category")
#not overcome the global average and still stand almost over years

#V5AxleArticHGV
g <- ggplot(UrbanRural,aes(RoadCategory,V5AxleArticHGVVolume,color =factor( RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of V5AxleRigidHGV in urban and rural for whole road category")
#still stand almost in PR / PU / TU road category over years
#but it be very large in TR road category and almost increase over years

#V6orMoreAxleArticHGV
g <- ggplot(UrbanRural,aes(RoadCategory,V6orMoreAxleArticHGVVolume,color = factor(RoadCategory)))
g+geom_point()+facet_grid(.~AADFYear)+theme_bw()+geom_hline(yintercept = global_average )+labs(title = "the flow of V6ormoreAxleRigidHGV in urban and rural for whole road category")
#PR and TR road category increase over years 
#and other road category almost still stand

#we will make a report for each road overcome the global average in urban
#and rural roads
UrbanRural <- TrafficAADF %>%
  select(AADFYear,Road,RoadCategory,PedalCyclesVolume,
         MotorcyclesVolume,BusesCoachesVolume,
         LightGoodsVehiclesVolume,
         V2AxleRigidHGVVolume,V3AxleRigidHGVVolume,
         CarsTaxisVolume,V3or4AxleArticHGVVolume,
         V4or5AxleRigidHGVVolume,V5AxleArticHGVVolume,
         V6orMoreAxleArticHGVVolume
         )
#we group data with needed columns
UrbanRuralRoads <- group_by(UrbanRural,Road,AADFYear,RoadCategory)

#we gather the data 
gather_vehicles <- gather(UrbanRuralRoads,vehicles_type,count,-c(AADFYear,Road,RoadCategory))

#we filter data which count of vehicles over come the global average 
UrbanRuralRoads <- filter(gather_vehicles,count >= global_average)
#this report for all roads and its category over years which overcome the global average

#we will divide data to two parts Rural and Urban.
#then see if the flow in the roads which overcome global average is increase 
#or less overyears.
#first, start with Rural roads
RuralRoads <- filter(UrbanRuralRoads,RoadCategory=="TR"|RoadCategory=="PR") %>%
  group_by(AADFYear,vehicles_type)

average_year <- summarise(RuralRoads,average =mean(count))
g <- ggplot(average_year,aes(AADFYear,average))
g+geom_point()+geom_smooth(method = "lm",se = F)+geom_smooth(method = "loess",color ="red",se = F)+theme_bw()+facet_grid(.~vehicles_type)+labs(title = "the average of each vechiles which pass the global average over year in Rural")
#we see that only two types of cars overcome the global average taxis
#and light goods. and see that the average of cars increase over year
#the using of light goods starts in 2003

#second, with Ruban roads
UrbanRoads <- filter(UrbanRuralRoads,RoadCategory=="TU"|RoadCategory=="PU") %>%
  group_by(AADFYear,vehicles_type)

average_year <- summarise(UrbanRoads,average = mean(count))
g <- ggplot(average_year,aes(AADFYear,average))
g+geom_point()+geom_smooth(method = "lm",se = F)+theme_bw()+facet_grid(.~vehicles_type)+labs(title = "the average of each vechiles which pass the global average over year in Rural")
#we see that only two types of cars overcome the global average taxis
#and light goods. and see that the average of taxis increase over year
#and light goods still stand. 
#the busy starts in 2010 using of light goods

#now we will go to see the average of vehicles in all roads over years
gather_vehicles <- group_by(gather_vehicles,AADFYear,vehicles_type,RoadCategory)
average_year <- summarise(gather_vehicles,average =mean(count))
g <- ggplot(average_year,aes(AADFYear,average))
g+geom_point()+geom_smooth(method = "lm",se = F)+theme_bw()+facet_grid(RoadCategory~vehicles_type)+labs(title = "the average of vehicles in all roads over years")
#we recoginze that taxis increase over years in all road categery
