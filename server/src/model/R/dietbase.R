#加载包
library(RPostgreSQL)
conn = dbDriver("PostgreSQL") 
#建立连接
con <- dbConnect(conn ,
                 host = "localhost", #主机名，默认localhost
                 port = '5432', #端口号，默认5432
                 dbname = 'postgres',  #数据库
                 user = 'postgres', #用户名
                 password = '123456') #安装的时候设的postgresql的密码

#SQL操作: 这里引号里写SQL代码
re <- dbSendQuery(con, "SELECT * FROM ecopathdiet")
#保存数据
diag <- dbFetch(re) 
#print(diag)
dbClearResult(re)

groups <- c('Seabirds', 'Whales', 'Seals', 'JuvRoundfish1', 'AduRoundfish1', 
            'JuvRoundfish2', 'AduRoundfish2', 'JuvFlatfish1', 'AduFlatfish1',
            'JuvFlatfish2', 'AduFlatfish2', 'OtherGroundfish', 'Foragefish1',
            'Foragefish2', 'OtherForagefish', 'Megabenthos', 'Shellfish',
            'Macrobenthos', 'Zooplankton')
			
pred <- as.vector(unlist(diag[1]))
prey <- as.vector(unlist(diag[2]))
diet <- as.vector(unlist(diag[3]))
print(pred)
print(prey)
print(diet)
# 遍历猎人群组
for(i in seq(along=groups)){
  print(groups[i])
  # diet值对应的位置
  index <- which(pred==i)
  #print(index)
  # 吃了那些物种的id索引
  print(prey[index])
  # 用来遍历diet
  num <- 1
  tmp = c()
  # 遍历捕食者
  for(j in seq(23)){
	#print(j %in% prey[index])
	#print(j)
	{
		if(j %in% prey[index]){
			#print(num)
			#tmp <- c(tmp,diet[j])
			tmp[j]=diet[index[num]]
			num <- num+1
		}
		else
		{
			#tmp <- c(tmp,NA)
			tmp[j]=NA
		}
	}
  }
  print(tmp)
}



