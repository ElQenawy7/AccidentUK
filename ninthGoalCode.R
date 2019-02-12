#Differences between England, Scotland, and Wales
#first we load the libraries which we need 
library(dplyr)
library(tidyr)
library(ggplot2)

#we filter from the data the needed variables
trafficNinthGoal <- TrafficAADF %>%
  filter(Region=="Wales"| Region=="Scotland" | Region=="East of England")%>%
  group_by(Region)

#we see the average of all vehicles in each region
average_Vehicles <- summarise(trafficNinthGoal,
                              aveg_pedal= mean(PedalCyclesVolume),
                              aveg_motor = mean(MotorcyclesVolume),
                              aveg_buses = mean(BusesCoachesVolume),
                              aveg_Taxis = mean(CarsTaxisVolume),
                              aveg_Light = mean(LightGoodsVehiclesVolume),
                              aveg_V2 = mean(V2AxleRigidHGVVolume),
                              aveg_v3 = mean(V3AxleRigidHGVVolume),
                              aveg_v34 = mean(V3or4AxleArticHGVVolume),
                              aveg_v45 = mean(V4or5AxleRigidHGVVolume),
                              aveg_v5 = mean(V5AxleArticHGVVolume),
                              aveg_v6 = mean(V6orMoreAxleArticHGVVolume)
)
#we need to gather the data 
average_Vehicles <-gather(average_Vehicles,average,ValueofAverage,-Region )

#we see the average of each vehicles in regions
g<-ggplot(average_Vehicles,aes(average,ValueofAverage,color = Region))
g+geom_point()+labs(title = "the average of each vehicles in regions")

#we get the average of vehicales in all UK and combare which of this region 
#increase of this mean
global_average <- mean(TrafficAADF$allVolume)

#we search which region is more busy flow
g<-ggplot(trafficNinthGoal,aes(Region,allVolume,color = factor (AADFYear)))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "flow of each region")
#we see that the england is the first area between them,then wales then scotland
#and all region consider overcome global average
#overcome the global average over all years old and modern and less over year


#we search in data what differance between them in vehicales
#we start with the pedal cycles
g <- ggplot(trafficNinthGoal,aes(Region,PedalCyclesVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in pedal cycles")
#we see that Englan is uses pedal cycles in the bast is large and be the first
#country uses of pedal cycles. Scotland and Wales are equal

#see the differance in motor cycles
g <- ggplot(trafficNinthGoal,aes(Region,MotorcyclesVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in motor cycles")
#we see that England take the first place using the motor cycles in the old years
#and England be in first blace using motor cycles

#we see the differance in BusesCoaches
g <- ggplot(trafficNinthGoal,aes(Region,BusesCoachesVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in buses coaches")
#we see that the scotland in the first place using buses then wales then england
#not over come the global average

#we see the differance between car taxis 
g <- ggplot(trafficNinthGoal,aes(Region,CarsTaxisVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in taxis")
#overcome the global average in all region
#England be in the first place in use then Wales then Scotland

#we see the differance between light goods vehicles
g <- ggplot(trafficNinthGoal,aes(Region,LightGoodsVehiclesVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in light goods")
#over come the global average England in first place then Wales then Scotland

#we see the differace between V2AxleRigidHGV
g <- ggplot(trafficNinthGoal,aes(Region,V2AxleRigidHGVVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in V2AxleRigidHGV")
#overcome the global average only in England

#we see the differace between V3AxleRigidHGV
g <- ggplot(trafficNinthGoal,aes(Region,V3AxleRigidHGVVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in V3AxleRigidHGV")
#in the first palce Wales then Engalnd then Scotland
#and uses in Scotland less over years

#we see the differace between V3or4AxleArticHGV
g <- ggplot(trafficNinthGoal,aes(Region,V3or4AxleArticHGVVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in V3or4AxleRigidHGV")
#less uses over years and England in the first place then Scotland then Wales

#we see the differace between V4or5AxleRigidHGV
g <- ggplot(trafficNinthGoal,aes(Region,V4or5AxleRigidHGVVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in V4or5AxleRigidHGV")
#more uses in England then Scotland then Wales

#we see the differace between V5AxleArticHGV
g <- ggplot(trafficNinthGoal,aes(Region,V5AxleArticHGVVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in V5AxleRigidHGV")
#England overcomve tha global average and less uses over years then Scotland
#then Wales

#we see the differace between V6orMoreAxleArticHGV
g <- ggplot(trafficNinthGoal,aes(Region,V6orMoreAxleArticHGVVolume,color = AADFYear))
g+geom_point()+theme_bw()+geom_hline(yintercept = global_average)+labs(title = "differance between areas in V6ormoreAxleRigidHGV")
#England overcomve tha global average then Scotland
#then Wales
