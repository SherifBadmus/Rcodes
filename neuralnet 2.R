# I constructed this for a client #Msc Thesis #Artificial Neural Network
#But I later had to use JMP Pro 14 because I had issues integrating tensorflow and keras into my R work space
# I am still out on solutions and I think getting serious with the Copernicus institute program on using the jupyter notebook should help

#########
#THE USE OF ARTIFICIAL NEURAL NETWORKS AND REGRESSION ANALYSIS IN PREDICTING MEAN BLOOD PRESSURE
######installing dependency
install.packages("neuralnet")
#Loading dataset after manual importation
View(diabone)
#loading the neural  network library
library(neuralnet)
#Setting seed to aid replicability
set.seed(1)
#Defining dataset
data = diabone
#Having a compacted view of the dataset
str(diabone)
#Normailizing the data to avoid the effect of outliers
max_data <- apply(data, 2, max)
min_data <- apply(data, 2, min)
data_scaled <- scale(data,center = min_data, scale = max_data - min_data)
#splitting the dataset for training and validation. 70% of the dataset will be for taining the network
#30% will be for validation
index = sample(1:nrow(data),round(0.70*nrow(data)))
train_data <- as.data.frame(data_scaled[index,])
test_data <- as.data.frame(data_scaled[-index,])
#Bu9ilding the neural network formula
n = names(data)
f = as.formula(paste("mbpbf ~", paste(n[!n %in% "mbpbf"], collapse = " + ")))
net_data = neuralnet(f,data=train_data,hidden= (10),linear.output=T)
#Plotting the result
plot(net_data)
#using the developed network to predict the test data
predict_net_test <- compute(net_data,test_data)
#Generating actual data point from predicted normalized observations
predict_net_test_start <- predict_net_test$net.result*(max(data$mbpbf)- min(data$mbpbf))+min(data$mbpbf)
test_start <- as.data.frame((test_data$mbpbf)*(max(data$mbpbf)-min(data$mbpbf))+min(data$mbpbf))
### Computing the MSE of the developed ANN
MSE.net_data <- sum((predict_net_test_start - test_start)^2)/nrow(test_start)
###Building a Regression Model using the full diabone dataset
Regression_Model <- lm(mbpbf~., data=data)
summary(Regression_Model)
test <- data[-index,]
#Predicing the test dataset using the built regression model
predict_lm <- predict(Regression_Model,test)
#Generating the MSE of the developed regression model
MSE.lm <- sum((predict_lm - test$mbpbf)^2)/nrow(test)
MSE.net_data
MSE.lm
print(test_start)
print(predict_net_test_start)
print(predict_lm)
#Conclusion
#The model (ANN or regression) with the lowest mean square error (MSE) would be ranked the best mosel