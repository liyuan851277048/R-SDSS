# Example 2.6 in Page 137 in PDF, Page 104 in Paper version

source('Newtons.R')

funs<-function(x){
   f<-c(x[1]^2+x[2]^2-5, (x[1]+1)*x[2]-(3*x[1]+1))
   J<-matrix(c(2*x[1], 2*x[2], x[2]-3, x[1]+1),
             nrow=2, byrow=T)
   list(f=f, J=J)
}

Newtons(funs, c(0,1))