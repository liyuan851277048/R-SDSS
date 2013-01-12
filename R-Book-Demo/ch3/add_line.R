# Example 3.14 on Page 180 on PDF version
rt<-read.table("../ch2/exam0203.txt", head=TRUE);
lm.sol<-lm(Weight~Height, data=rt)
attach(rt)
plot(Weight~Height);
abline(lm.sol) #绘出线性模型的线性方程
