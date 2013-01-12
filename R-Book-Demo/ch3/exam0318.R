# Example 3.18 on Page 199 on PDF version
X <- read.table("course.data")
source("outline.R")
outline(X)
stars(X)
stars(X, full=FALSE,
      draw.segments=TRUE,
      key.loc = c(5,0.5),
      ,mar=c(2,0,0,0))