# Example 3.1 Page 142 in PDF version
w<-c(75.0, 64.0, 47.4, 66.9, 62.2, 62.2, 58.7, 63.5, 
      66.6, 64.0, 57.0, 69.0, 56.9, 50.0, 72.0)
w.mean<-mean(w); w.mean 

# introduce exception point
w[1]<-750
w.mean<-mean(w); w.mean # wrong

# trim the exception point
w.mean<-mean(w,trim=0.1); w.mean 

# introduce NA point
w[16]<-NA
w.mean<-mean(w); w.mean # can not get result

# trim NA point
w.mean<-mean(w,na.rm=TRUE); w.mean 
