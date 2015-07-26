library(readxl)
library(openxlsx)

library(foreach)
library(doParallel)

fp <- "C:\\Users\\Omar\\Desktop\\PTYL200211_CHIARA.xlsx"
fb <- readxl::read_excel(fp,sheet="Fieldbook")

check_trait_condition <- function(fp, trait) {
  
  wb <- openxlsx::loadWorkbook(fp)
  fb <- readxl::read_excel(fp,sheet="Fieldbook")
  #fb <- iris
  negStyle <- openxlsx::createStyle(fontColour = "#9C0006", bgFill = "#FFC7CE")
  #posStyle <- openxlsx::createStyle(fontColour = "#006100", bgFill = "#C6EFCE")
  
  sheet <- "Fieldbook"
  #col_number<-which(names(fb)=="NMTP")
  col_number<-which(names(fb)==trait)
  nc <- nrow(fb)+1
  openxlsx::conditionalFormatting(wb, sheet, cols=col_number,rows = 2:nc ,rule=">=5", style = negStyle)
  ## Save workbook
  openxlsx::saveWorkbook(wb, fp, overwrite = TRUE)
  #shell.exec(fp)
}

# check_trait_condition(fp,"MTWP")
# check_trait_condition(fp,"NPH")

###========version 1 con lapply========
p <- names(fb)
ret <- c("PLOT","REP","INSTN")
p <- p[!p %in% ret]
#start time
strt<-Sys.time()
lapply(p, function(x)  check_trait_condition(fp,x))
print(Sys.time()-strt)
####


#####===version 2 con doParellel====
#  version 2 con doParellel
library(foreach)
library(doParallel)
cl<-makeCluster(40)
registerDoParallel(cl)
strt<-Sys.time()

p <- names(fb)
ret <- c("PLOT","REP","INSTN")
p <- p[!p %in% ret]
n <- length(p)
#loop
foreach(i=1:n) %dopar% { 
  pol <- p[i]
  check_trait_condition(fp=fp,trait=pol)
}

print(Sys.time()-strt)
stopCluster(cl)
strt<-Sys.time()
####


#####==== other aplications ==== 
#vapply(p, function(x)  check_trait_condition(fp,x))
#mclapply(p,check_trait_condition(fp,p))
#sapply(p, function(fp,x) check_trait_condition(fp = fp,trait = x))
#vapply(p, function(...) check_trait_condition(fp = fp,trait = p),FUN.VALUE=0)
#sapply(p, function(...) check_trait_condition(fp = fp,trait = x),FUN.VALUE=1)
