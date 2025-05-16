#setwd(" set it to the directory of the source code and data")

############setting the working directory can also be automated by the following
############ but it causes some funny restarting of R that you need to live through

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#################

############This code allows you to conduct logistic regressions, calculate hit rates 

train=read.csv(file="relay train.csv") #####import train data. Please note that you may have to change the file name to reflect the name you gave the train data in your computer.

##############estimate model in train dataset############

ttoforder=as.vector(as.Date(train$firstorder,"%m/%d/%y")-as.Date(train$created,"%m/%d/%y"))  ########calculate difference between first order and create date####################

retmod=glm(ret~bwi+ric+ttoforder+esent+avgorder+ordfreq+paperless+refill+doorstep+weekdayshopper,family="binomial",data=train)  ########estimate logistic regression#########

summary(retmod)

retcoeff=as.matrix(retmod$coefficients,ncol=1) ##########collect coefficients of logistic regression####################

#########predict probabilites in test data#######################

test=read.csv(file="relay test.csv") #####import test data. Please note that you may have to change the file name to reflect the name you gave the test data in your computer.
testrow=nrow(test)

retdattestx=as.matrix(cbind(rep(1,testrow),test[,4],test[,7:9],test[12:17]))  #############collect only columns in test that are necessary for prediction. Please note that you may need to change the subscripts you use here to reflect the columns that are significant in your model.

sigretcoeff=as.matrix(retcoeff[1:11],col=1)      ##################collect only significant coefficients. You would need to look at the results in the output from summary(retmod) in line 20, to determine the significant coefficients to include here################

pbx=retdattestx%*%sigretcoeff   #################calculate utility###################
pretprob=exp(pbx)/(1+exp(pbx))      ###############calculate probability###################
pret=(pretprob>runif(testrow))*1    ###############set retain =1 if probability > uniform random number between 0 and 1 (i.e., a coin toss)###########################
sum(diag(table(pret,test[,3])))/testrow   ##################print the hit rate##############################

