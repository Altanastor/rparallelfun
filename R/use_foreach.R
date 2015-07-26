library(foreach)
library(doParallel)
library(agricolae)
data("ComasOxapampa")
#This code is used to bind thousend of columns 

#The foreach function makes possible to run R-code in parallel.
#When we have large data set, it reduce a lot of time many common operations

#In case Local-Machine
cl<-makeCluster(8)

#In case CIP-WorkStation 
#cl<-makeCluster(40)

registerDoParallel(cl)
#strt<-Sys.time()


n <- ncol(ComasOxapampa)
column_together <- foreach(i=1:n, .combine='cbind') %dopar% 
{
  ComasOxapampa[i]
}
column_together

#print(Sys.time()-strt)
stopCluster(cl)
#strt<-Sys.time()


