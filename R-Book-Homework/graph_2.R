# 第七次作业
## 社会网络分析
library(igraph)
nexus.info("Davis") # 查看Davis数据集的信息；
gD<-nexus.get("Davis") # 获取Davis数据集,此时获得的是一个二分图，可用bipartite.mapping(gD)来查验；
g<-bipartite.projection(gD)$proj2 # 将二分图变成两个一模网络,并提取以事件为节点的网络；
g2<-delete.edges(g,E(g)[E(g)$weight<3]) # 对网络的边取阀值为3，提取边权仅大于或等于3的部分；
events=paste("e",1:14,sep="") # 给出14个节点的标签；
tkid<-tkplot(g2) # 按照PPT，拖动相应数据点到相应位置再继续
lay<-tkplot.getcoords(tkid)
pdf("events14.pdf") # 输出PDF格式结果到当前目录
plot(g2, edge.width=E(g)$weight,
	layout=lay,
	vertex.color="green",
	vertex.shape="square",
	vertex.frame.color="grey",
	vertex.label=events,
	vertex.label.font=2,
	vertex.label.color="black",
	vertex.label.dist=1,
	vertex.label.degree=pi/2)
dev.off()