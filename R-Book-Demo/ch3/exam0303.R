# Example 3.3 Page 157 in PDF version
w <- c(75.0, 64.0, 47.4, 66.9, 62.2, 62.2, 58.7, 63.5,
       66.6, 64.0, 57.0, 69.0, 56.9, 50.0, 72.0)
hist(w, freq=FALSE) # 直方图
lines(density(w),col="blue") # 核密度估计函数
x<-44:76
lines(x, dnorm(x, mean(w), sd(w)), col="red") # 正态分布概率密度曲线
