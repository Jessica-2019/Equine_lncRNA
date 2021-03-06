##obtaining lncRNA promoters < 1kb 5'
setwd("~/Desktop/lncRNA")
lncRNA_all_bed <- read.table("all_lncRNA_final.bed", header=F,stringsAsFactors=F )
lncRNA_all_bed ["up"] <- (lncRNA_all_bed [ ,2]-1000)
lncRNA_all_bed ["down"]<- (lncRNA_all_bed [ ,3] + 1000)
#convert all negative numbers into 0
lncRNA_all_bed$up[lncRNA_all_bed$up < 0] <- 0
lncRNA_promoters<- lncRNA_all_bed[ ,c("V1","up","V2","V4","V5","V6","V7","V8","V9","V10","V11","V12")]
lncRNA_down<- lncRNA_all_bed[ ,c("V1","V3","down","V4","V5","V6","V7","V8","V9","V10","V11","V12")]
#remove mt chromosome
promoter_noM <- subset(lncRNA_promoters,(V1=="chrM"))
rownames(promoter_noM) <- c()
lncRNA_promoters <- anti_join(lncRNA_promoters,promoter_noM, by="V1")
down_noM <- subset(lncRNA_down,(V1=="chrM"))
rownames(down_noM) <- c()
lncRNA_down <- anti_join(lncRNA_down,down_noM, by="V1")
#order chr properly
lncRNA_promoters <- lncRNA_promoters[with(lncRNA_promoters, order(V1, up)), ]
lncRNA_down <- lncRNA_down[with(lncRNA_down, order(V1, V3)), ]

write.table(lncRNA_promoters, "lncRNA_promoters.bed", row.names=F, col.names=F, quote=F,, sep = "\t")
write.table(lncRNA_down, "lncRNA_down.bed", row.names=F, col.names=F, quote=F,, sep = "\t")
