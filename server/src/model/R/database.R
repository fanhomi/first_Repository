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
re <- dbSendQuery(con, "SELECT * FROM ecopathgroup")
#保存数据
diag <- dbFetch(re) 

ll <- diag[2]

print(ll[1])
print(typeof(ll))
#diag是列表，其中的一列是连成一条的数据，需要unlist解开，并转成vector
print(as.vector(unlist(ll)))
#清空re值，以便下次使用
dbClearResult(re)
re <- dbSendQuery(con, "SELECT * FROM ecopathgroup2")
print(dbFetch(re))
dbClearResult(re)