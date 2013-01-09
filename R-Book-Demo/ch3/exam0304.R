# Example 3.4 Page 159 in PDF version
w <- c(75.0, 64.0, 47.4, 66.9, 62.2, 62.2, 58.7, 63.5,
       66.6, 64.0, 57.0, 69.0, 56.9, 50.0, 72.0)
plot(ecdf(w), # 经验分布函数
     verticals = TRUE, # 画竖线
     do.p = FALSE) # 不画点处记号
x<-44:78
lines(x, pnorm(x, mean(w), sd(w))) # 正态分布曲线