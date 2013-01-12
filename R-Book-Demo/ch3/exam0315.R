# Example 3.15 on Page 186 on PDF version
rubber<-read.table("rubber.data")
sapply(rubber,mean)
cov(rubber)
cor(rubber)

attach(rubber)
cor.test(X1,X2)
cor.test(X1,X3)
cor.test(X2,X3)

