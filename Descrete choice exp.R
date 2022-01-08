#these codes were written in respect to creating a choice data set for my Msc thesis
#Unloading the dependencies
library(support.CEs)
library(survival)
library(mded)
#Constructing the questionnaire format by specifying the attributes, alternatives and block
rd <- rotation.design(
  attribute.names = list( msource= c("solaronly", "solarinv"), capacity = c("1500", "1200"), brand = c("usa", "china"), price= c("220", "300")),
  nalternatives = 2,
  nblocks = 1)
rd
#Designing the questionnaire with a opt-out opyion and unlabeled DCE
questionnaire(choice.experiment.design = rd)
dm.rd <- make.design.matrix(
  choice.experiment.design = rd,
  optout = TRUE,
  categorical.attributes = c("msource", "brand"),
  continuous.attributes = c("capacity", "price"),
  unlabeled = TRUE,
  common = NULL,
  binary = FALSE)
dm.rd
#Expressing the data frame and respondents' choices
excelres <- data.frame(ID = c(1:150),
                       BLOCK = rep(c(1:1), times = 150),
                       C1 = c(2, 1, 3, 3, 3, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 1, 1, 1, 1, 3, 2, 1, 2, 1, 1, 3, 3, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 3, 2, 1, 1, 3, 3, 3, 1, 1, 1 ,1, 1, 1, 1, 2, 1, 1, 2, 1, 3, 1, 2, 1, 1, 3, 1, 2, 1, 2, 1, 1, 1, 3, 1, 3, 3, 1, 2, 1, 1, 1, 3, 1, 3, 3, 2, 1, 3, 3, 3, 3, 2, 1, 2, 2, 1 , ., 1,  1,  ., 3, 2, 3, 2, 2, 1, 1, 1, 2, 3, 3, 1, 2, 1, 1, 1, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 1, 3, 1, 3, 1, 3, 3, 2, 1, 2, 2, 3, 2, 3, 2, 2),
                       C2 = c(1, 1, 3, 3, 2, 2, 2, 1, 1, 3, 1, 1, 1, 2, 1, 1, 3, 3, 1, 1, 2, 2, 1, 2, 2, 2, 1, 1, 3, 3, 1, 2, 1, 1, 2, 1, 1, 2, 1, 1, 3, 2, 1, 1, 3, 1, 2, 1, 1, 1, 2, 1, 3, 2, 3, 1, 1, 2, 1, 3, 1, 1, 1, 1, 3, 1, 2, 1, 2, 2, 2, 3, 3, 2, 3, 3, 3, 1, 2, 1, 1, 3, 2, 3, 3, 1, 1, 3, 2, 3, 3, 2, 2, 2, 1, 1,  .,  2, 1,  ., 3, 1, 3, 1, 1, 2, 2, 1, 2, 1, 3, 1, 3, 2, 3, 1, 2, 1, 3, 2, 3, 3, 3, 2, 2, 2, 2, 3, 1, 1, 1, 1, 2, 1, 1, 3, 1, 3, 1, 2, 3, 3, 2, 3, 3, 2, 2, 3, 1, 1),
                       C3 =  c(2, 2, 3, 3, 1, 2, 3, 1, 2, 3, 3, 2, 1, 1, 1, 1, 2, 3, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 3, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 3, 2, 1, 1, 3, 2, 2, 1, 1, 2, 2, 1, 3, 1, 2, 2, 1, 1, 2, 3, 1, 1, 1, 2, 3, 1, 2, 1, 2, 2, 2, 2, 3, 3, 3, 3, 2, 1, 1, 1, 2, 3, 2, 3, 2, 2, 1, 2, 3, 3, 3, 2, 1, 2, 1, 2, ., 1, 1, ., 3, 2, 3, 2, 2, 3, 2, 1, 2, 2, 3, 1, 2, 2, 2, 1, 1, 1, 3, 2, 3, 3, 2, 2, 2, 1, 2, 3, 2, 1, 2, 1, 2, 1, 3, 3, 1, 3, 1, 2, 3, 2, 3, 1, 2, 1, 1, 3, 2, 3))
#Creating a the choice dataset
ds <- make.dataset(respondent.dataset = excelres,
                   design.matrix = dm.rd,
                   choice.indicators = c("C1", "C2", "C3"))
excelres <- as.data.frame(read_excel("C:/Users/Dell/Downloads/pfarmdata/excelres.xlsx"),
                        stringsAsFactors = FALSE)
View(excelres)
ds[1:10, ]
View(ds) 
#Exporting the created dataset 
install.packages(xlsx)
library(xlsx)
write.table(ds, file = "myworkbook2.xlsx", append = FALSE)
write.table(ds, file = "mysd.xlsx", append = FALSE, quote = TRUE, sep = " ", eol = "\n", na = "NA", dec= ".", row.names = TRUE, col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "UTF-16")
write_dta (ds, "C:/Users/Dell/Downloads/pfarmdata/dss.dta", version = 14, label = attr(ds,"label"))
save(ds)
write_dta(dfds, "table_car.dta")
library(writexl)
write_xlsx(ds, path = "dssdexcel.xlsx")
