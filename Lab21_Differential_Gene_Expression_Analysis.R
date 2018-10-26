
library(edgeR)
library(gtools)
library(gplots)
library(RColorBrewer)

# Load R package that have been installed in our server.  There are two ways to install R packages: install.packages() and biocLite().  Compiling programs could be nontrivial.  Fortunately, you don’t need to do this.  It is beyond the scope of this class.  All the packages you need have been already compiled in our server.  

wt_r1<-read.table("wt_r1_count.tab",header=FALSE)
wt_r2<-read.table("wt_r2_count.tab",header=FALSE)
ask1_r1<-read.table("mt_r1_count.tab",header=FALSE)
ask1_r2<-read.table("mt_r2_count.tab",header=FALSE)

# Read count files processed in Lab 20

count_list<-list(wt_r1,wt_r2,ask1_r1,ask1_r2)
probesets<-wt_r1[,1]
count.matrix<-do.call('cbind',
 			lapply(count_list,
 				function(x)
   					{
 					mymatch <- match(probesets,x[,1])
 					return(x[,2][mymatch])
 					}
 				)
 			)


count.matrix <- apply(count.matrix,2,function(x) {as.numeric ( as.character(x) ) } )

rownames(count.matrix) <- probesets
colnames(count.matrix) <- c("wt_r1","wt_r2","ask1_r1","ask1_r2")

rawdata<-read.table("gene_counts_file.tab",header = TRUE)

# Combine the processed transcriptomic data of four samples into one data matrix, count.matrix , and saved it as rawdata

rawdata<-na.omit(rawdata)

# omits loci with missing count

keep<-rowSums(cpm(rawdata)>2)>=3
rawdata<-rawdata[keep,]
table(keep)

#### output of table(keep)
# keep                                                                                     
# FALSE  TRUE                                                                              
# 16287 17320    

# keep the expression level > 2 cpm (count per million reads)

group<-factor(c(1,1,2,2))
y<-DGEList(counts = rawdata,group=group)
design<-model.matrix(~group,data=y$samples)
design

#### output of design

#        (Intercept) group2
# wt_r1             1      0
# wt_r2             1      0
# ask1_r1           1      1
# ask1_r2           1      1
# attr(,"assign")
# [1] 0 1
# attr(,"contrasts")
# attr(,"contrasts")$group
# [1] "contr.treatment"

######

y<-calcNormFactors(y)
y$samples

#### output of y$samples
#         group lib.size norm.factors
# wt_r1       1 17752578    0.9614987
# wt_r2       1 16821827    0.9685758
# ask1_r1     2 17405658    1.0327091
# ask1_r2     2 19576785    1.0397758

#####

y<-estimateGLMCommonDisp(y,design,verbose=TRUE)
y<-estimateGLMTrendedDisp(y,design)
y<-estimateGLMTagwiseDisp(y,design,prior.df=20)

# statistical analysis process by edgeR

corraw_y_counts<-cor(y$counts,use="na.or.complete",method="pearson")

heatmap.2(corraw_y_counts,
         col=brewer.pal(10,"Set3"),
         keysize=2,
         margins=c(10,10),
         trace=c("none"),
         dendrogram="column",
         density.info=c("none"),
         cexRow=1,
         cexCol=1)

# You may recall what this does from Lab 18.

fit<-glmFit(y,design)
lrt.1vs2<-glmLRT(fit,coef=2)

FDR<-p.adjust(lrt.1vs2$table$PValue,method="BH")
sum(FDR < 0.05)

#Differential Gene count

diff_genes<-topTags(lrt.1vs2,n=sum(FDR<0.05),adjust.method="BH",
                    sort.by="p.value")

diff_genes[1:5,] 

#### output of diff_genes[1:5,]
# Coefficient:  group2 
#              logFC   logCPM       LR        PValue           FDR
# AT1G75870 -5.605026 6.135436 864.7183 4.589976e-190 7.949839e-186
# AT4G21895 -5.414704 5.730719 843.7974 1.621963e-185 1.404620e-181
# AT1G51250 -5.123334 5.916828 817.1419 1.011939e-179 4.741866e-176
# AT5G43300 -5.182856 5.634825 816.9841 1.095119e-179 4.741866e-176
# AT2G44560 -5.244938 5.794482 799.7842 6.011357e-176 2.082334e-172

summary(dt<-decideTestsDGE(lrt.1vs2), adjust.method="BH", p.value=0.05, lfc=1)

#### output of summary

#        group2
# Down     2007
# NotSig  13731
# Up       1582

# adjust.method: character string specifying p-value adjustment method.  Possible values are ‘"none"’, ‘"BH"’, ‘"fdr"’ (equivalent to ‘"BH"’), ‘"BY"’ and ‘"holm"’.  See ‘p.adjust’ for details.

#  p.value: numeric value between 0 and 1 giving the required family-wise error rate or false discovery rate.

# lfc: numeric, minimum absolute log2-fold-change required.


DEgenes <-dim(lrt.1vs2$table)[1]


# DEgenes list


DIFF_Exp_List = topTags(lrt.1vs2, n = DEgenes)$table

DIFF_SIG <- DIFF_Exp_List [DIFF_Exp_List$PValue <= 0.05, ]

DIFF_FDR <- DIFF_Exp_List [DIFF_Exp_List$FDR <= 0.05, ]

# Keep rows with Pvalue or FDR less than or equal to .05 respectively.  In general, this can be considered as the list of Differentially Expressed Genes (DEG)

write.csv(DIFF_FDR, file="mt_wt_DEG_FDR.csv") 

#Exporting Data 

