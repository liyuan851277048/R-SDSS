# Example 3.14 on Page 182 on PDF version
ore<-data.frame(
     x=c(67, 54, 72, 64, 39, 22, 58, 43, 46, 34),
     y=c(24, 15, 23, 19, 16, 11, 20, 16.1, 17, 13)
)
ore.m<-mean(ore); ore.m# 计算均值
ore.s<-cov(ore); ore.s # 计算协方差阵
ore.r<-cor(ore); ore.r # 计算相关矩阵

attach(ore)
cor.test(x,y) # 计算相关性检验

cor.test(x,y, method="spearman")

cor.test(x,y, method="kendall")

