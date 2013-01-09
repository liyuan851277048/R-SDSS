# Figure 3.6 on Page 167 on PDF version
# data InsectSprays is build in R data
boxplot(count ~ spray, data = InsectSprays, 
        col = "lightgray")
boxplot(count ~ spray, data = InsectSprays,
        notch = TRUE, col = 2:7, add = TRUE)