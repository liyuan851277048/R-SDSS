data_outline <- function(x){
   n <- length(x) # 维度   
   m <- mean(x)   # 均值
   v <- var(x)    # 样本方差
   s <- sd(x)     # 样本标准差
   me <- median(x) # 中位数
   cv <- 100*s/m   # 变异系数
   css <- sum((x-m)^2) # 样本校正平方和
   uss <- sum(x^2) # 样本未校正平方和
   R <-  max(x)-min(x) # 样本极差
   R1 <- quantile(x,3/4)-quantile(x,1/4) # 四分位差/半极差
   sm <- s/sqrt(n) # 样本标准误
   g1 <- n/((n-1)*(n-2))*sum((x-m)^3)/s^3 # 偏度系数
   g2 <- ((n*(n+1))/((n-1)*(n-2)*(n-3))*sum((x-m)^4)/s^4
          - (3*(n-1)^2)/((n-2)*(n-3)))    # 峰度系数
   data.frame(N=n, Mean=m, Var=v, std_dev=s, Median=me, 
        std_mean=sm, CV=cv, CSS=css, USS=uss, R=R, 
        R1=R1, Skewness=g1, Kurtosis=g2, row.names=1)
}