library(rjson)
library(Rpath)

args <- commandArgs(trailingOnly = TRUE)
# 文件路径 args[1]

#Groups and types for the R Ecosystem

# 获取 json 数据
#resultsum <- fromJSON(file = args[1])
resultsum <- fromJSON(file = 'G:\\fhm\\postgraduate\\yanyi_up\\后端\\react_server\\R\\file.json')
result <- resultsum$sumGroup
# 将字符串的NA 换成 真NA
result$stgroups[which(result$stgroups =='NA')] <- NA
result$Biomass[which(result$Biomass =='NA')] <- NA
result$PB[which(result$PB =='NA')] <- NA
result$QB[which(result$QB =='NA')] <- NA
result$EE[which(result$EE =='NA')] <- NA
result$ProdCons[which(result$ProdCons =='NA')] <- NA
result$BioAcc[which(result$BioAcc =='NA')] <- NA
result$UNAssim[which(result$UNAssim =='NA')] <- NA
result$DetInput[which(result$DetInput =='NA')] <- NA
result$Detritus[which(result$Detritus =='NA')] <- NA
result$Discards[which(result$Discards =='NA')] <- NA
result$Trawlers[which(result$Trawlers =='NA')] <- NA
result$Midwater[which(result$Midwater =='NA')] <- NA
result$Dredgers[which(result$Dredgers =='NA')] <- NA
result$Trawlersdisc[which(result$Trawlersdisc =='NA')] <- NA
result$Midwaterdisc[which(result$Midwaterdisc =='NA')] <- NA
result$Dredgersdisc[which(result$Dredgersdisc =='NA')] <- NA
groups <- result$group
types <- result$type
stgroups <- result$stgroups
# 转成数值型，要不会报   二进列运算符中有非数值参数
biomass <- as.numeric(result$Biomass)
pb<-as.numeric(result$PB)
qb<-as.numeric(result$QB)
ee<-as.numeric(result$EE)
prodCons<-as.numeric(result$ProdCons)
bioAcc<-as.numeric(result$BioAcc)
uNAssim<-as.numeric(result$UNAssim)
detInput<-as.numeric(result$DetInput)
detritus<-as.numeric(result$Detritus)
discards<-as.numeric(result$Discards)
trawlers<-as.numeric(result$Trawlers)
midwater<-as.numeric(result$Midwater)
dredgers<-as.numeric(result$Dredgers)
trawlersdisc<-as.numeric(result$Trawlersdisc)
midwaterdisc<-as.numeric(result$Midwaterdisc)
dredgersdisc<-as.numeric(result$Dredgersdisc)

REco.params <- create.rpath.params(group = groups, type = types,stgroup=stgroups)

#Example of filling specific slots
REco.params$model[, EE := ee]

#Example of filling an entire column

REco.params$model[, Biomass := biomass]

#Model
REco.params$model[, PB := pb]
REco.params$model[, QB := qb]

#Production to Consumption for those groups without a QB
REco.params$model[, ProdCons:= prodCons]


#Biomass accumulation and unassimilated consumption
REco.params$model[, BioAcc  := bioAcc]
REco.params$model[, Unassim := uNAssim]

#Detrital Fate
REco.params$model[, Detritus := detritus]
REco.params$model[, Discards := discards]

#Fisheries
#Landings
REco.params$model[, Trawlers := trawlers]
REco.params$model[, Midwater := midwater]
REco.params$model[, Dredgers := dredgers]

#Discards
REco.params$model[, Trawlers.disc := trawlersdisc]
REco.params$model[, Midwater.disc := midwaterdisc]
REco.params$model[, Dredgers.disc := dredgersdisc]

#Group parameters
REco.params$stanzas$stgroups[, VBGF_Ksp := c(0.145, 0.295, 0.0761, 0.112)]
REco.params$stanzas$stgroups[, Wmat     := c(0.0769, 0.561, 0.117,  0.321)]

#Individual stanza parameters
REco.params$stanzas$stindiv[, First   := c(rep(c(0, 24), 3), 0, 48)]
REco.params$stanzas$stindiv[, Last    := c(rep(c(23, 400), 3), 47, 400)]
REco.params$stanzas$stindiv[, Z       := c(2.026, 0.42, 2.1, 0.425, 1.5, 0.26, 1.1, 0.18)]
REco.params$stanzas$stindiv[, Leading := rep(c(F, T), 4)]

REco.params <- rpath.stanzas(REco.params)

# 设置DIET
###################
resultDiet <- resultsum$sumDiet

resultDiet$Seabirds[which(resultDiet$Seabirds =='NA')] <- NA
resultDiet$Whales[which(resultDiet$Whales =='NA')] <- NA
resultDiet$JuvRoundfish1[which(resultDiet$JuvRoundfish1 =='NA')] <- NA
resultDiet$AduRoundfish1[which(resultDiet$AduRoundfish1 =='NA')] <- NA
resultDiet$JuvRoundfish2[which(resultDiet$JuvRoundfish2 =='NA')] <- NA
resultDiet$AduRoundfish2[which(resultDiet$AduRoundfish2 =='NA')] <- NA
resultDiet$JuvFlatfish1[which(resultDiet$JuvFlatfish1 =='NA')] <- NA
resultDiet$AduFlatfish1[which(resultDiet$AduFlatfish1 =='NA')] <- NA
resultDiet$JuvFlatfish2[which(resultDiet$JuvFlatfish2 =='NA')] <- NA
resultDiet$AduFlatfish2[which(resultDiet$AduFlatfish2 =='NA')] <- NA
resultDiet$OtherGroundfish[which(resultDiet$OtherGroundfish =='NA')] <- NA
resultDiet$Foragefish1[which(resultDiet$Foragefish1 =='NA')] <- NA
resultDiet$Foragefish2[which(resultDiet$Foragefish2 =='NA')] <- NA
resultDiet$OtherForagefish[which(resultDiet$OtherForagefish =='NA')] <- NA
resultDiet$Megabenthos[which(resultDiet$Megabenthos =='NA')] <- NA
resultDiet$Shellfish[which(resultDiet$Shellfish =='NA')] <- NA
resultDiet$Macrobenthos[which(resultDiet$Macrobenthos =='NA')] <- NA
resultDiet$Phytoplankton[which(resultDiet$Phytoplankton =='NA')] <- NA
resultDiet$Zooplankton[which(resultDiet$Zooplankton =='NA')] <- NA

Seabirds <- as.numeric(resultDiet$Seabirds)
Whales <- as.numeric(resultDiet$Whales)
JuvRoundfish1 <- as.numeric(resultDiet$JuvRoundfish1)
AduRoundfish1 <- as.numeric(resultDiet$AduRoundfish1)
JuvRoundfish2 <- as.numeric(resultDiet$JuvRoundfish2)
AduRoundfish2 <- as.numeric(resultDiet$AduRoundfish2)
JuvFlatfish1 <- as.numeric(resultDiet$JuvFlatfish1)
AduFlatfish1 <- as.numeric(resultDiet$AduFlatfish1)
JuvFlatfish2 <- as.numeric(resultDiet$JuvFlatfish2)
AduFlatfish2 <- as.numeric(resultDiet$AduFlatfish2)
OtherGroundfish <- as.numeric(resultDiet$OtherGroundfish)
Foragefish1 <- as.numeric(resultDiet$Foragefish1)
Foragefish2 <- as.numeric(resultDiet$Foragefish2)
OtherForagefish <- as.numeric(resultDiet$OtherForagefish)
Megabenthos <- as.numeric(resultDiet$Megabenthos)
Shellfish <- as.numeric(resultDiet$Shellfish)
Macrobenthos <- as.numeric(resultDiet$Macrobenthos)
Phytoplankton <- as.numeric(resultDiet$Phytoplankton)
Zooplankton <- as.numeric(resultDiet$Zooplankton)

REco.params$diet[, Seabirds        := Seabirds]
REco.params$diet[, Whales          := Whales]
REco.params$diet[, Seals           := Seals]
REco.params$diet[, JuvRoundfish1   := JuvRoundfish1]
REco.params$diet[, AduRoundfish1   := AduRoundfish1]
REco.params$diet[, JuvRoundfish2   := JuvRoundfish2]
REco.params$diet[, AduRoundfish2   := AduRoundfish2]
REco.params$diet[, JuvFlatfish1    := JuvFlatfish1]
REco.params$diet[, AduFlatfish1    := AduFlatfish1]
REco.params$diet[, JuvFlatfish2    := JuvFlatfish2]
REco.params$diet[, AduFlatfish2    := AduFlatfish2]
REco.params$diet[, OtherGroundfish := OtherGroundfish]
REco.params$diet[, Foragefish1     := Foragefish1]
REco.params$diet[, Foragefish2     := Foragefish2]
REco.params$diet[, OtherForagefish := OtherForagefish]
REco.params$diet[, Megabenthos     := Megabenthos]
REco.params$diet[, Shellfish       := Shellfish]
REco.params$diet[, Macrobenthos    := Macrobenthos]
REco.params$diet[, Zooplankton     := Zooplankton]

REco <- rpath(REco.params, eco.name = 'R Ecosystem')
#print(REco.params$diet[1])
#print(REco)
#writeLines(toJSON(REco),"fin0_out1.json")
{
	if(args[2]=="EcoSim"){
		Rsim.scenario <- rsim.scenario(REco, REco.params, years = 1:100)
		RSim <-rsim.run(Rsim.scenario, method = "RK4", years = 1:100)
		# list
		#print(typeof(RSim))
		#print(typeof(REco))
		# 18 16
		#print(length(RSim))
		#print(length(REco))
		# summary统计里面的属性
		#print(summary(RSim))
		#print(summary(REco))
		# 直接打印出来是list 16里面每一个变量 
		# write.Rsim后就可以实现像当于print REco的效果
		output <- write.Rsim(RSim, file = NA)
		print(toJSON(output))
	}
	else{
		print(toJSON(REco))
		#print(REco)
	}
}