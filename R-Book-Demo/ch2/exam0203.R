# Example 2.3 in Page 45 in Paper version

# 从exam0203.txt直接读取数据，有表头
rt<-read.table("exam0203.txt", head=TRUE); rt

# 对数据中的重量和高度作线性回归，计算结果放在lm.sol变量中
lm.sol<-lm(Weight~Height, data=rt)

# 显示变量lm.sol中的详细内容，将给出回归模型的攻势，残差的最小最大值，线性回归系数，以及估计与检验，详见第六章
summary(lm.sol)