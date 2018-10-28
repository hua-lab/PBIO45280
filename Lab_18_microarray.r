library(GEOquery)		
#Like Perl, R uses this format to call a Comprehensive R Archive Network (CRAN) package module	

gse <- getGEO("GSE5632",GSEMatrix=FALSE)
# Download the dataset, GSE5632, and save the data in variable, gse

names(GSMList(gse))
# List the samples saved in this series of expression data

# Step 5.  Make a data matrix
probesets <- Table(GPLList(gse)[[1]])$ID
data.matrix<-do.call('cbind',
 		lapply(GSMList(gse),
 			function(x) {tab <- Table(x)
 				mymatch <- match(probesets,tab$ID_REF)								
				 return(tab$VALUE[mymatch])
 					}
 			)
 		)

data.matrix <- apply(data.matrix, 2, function(x) {as.numeric ( as.character(x) ) } )

data.matrix <- log2(data.matrix)
rownames(data.matrix) <- probesets
colnames(data.matrix) <- names(GSMList(gse))

# You may get frustrated from so many commands.  However, as an effective learner in molecular biology, you may just take this as a recipe to retrieve expression data from a gse dataset.  If you forget how to do this in the future, you can always come back to find this recipe here ☺.  You may completely understand the trick of this recipe someday in the future if you keep using the tools you learned today. 

# Step 6.  Heatmap.2
# Many of you may have seen many colorful heatmap graphs in many publications.  Some of you may wonder how these graphs are made.  Here, we will first retrieve a small dataset (the first 50 rows, i.e., loci) from the data matrix obtained in Step 5.  We will then apply Heatmap.2 in an R package, gplots, to cluster the dataset based on the expression level and print out a color-coded data matrix into a PDF file.

library(gplots)	

# call the R package

dataset<- data.matrix[1:50,] 
	
# Retrieve the dataset
	
exp_range<-quantile(dataset, probs = c(30,60)/100)
lowest_exp<-min(dataset)
max_exp<-max(dataset)

# We split the expression data into three blocks, lowest to 30 percentile, 30 percentile to 60 percentile, and 60 percentile to the highest expression 

	my_palette<-colorRampPalette(c("blue","yellow","red"))(n=29)
	col_breaks=c(seq(lowest_exp, exp_range[[1]],length=10),
			seq(exp_range[[1]]+0.01,exp_range[[2]],length=10),
			seq(exp_range[[2]]+0.01,max_exp,length=10))

# We assigned three colors, "blue","yellow","red", to the three blocks of expression data and the color is gradually transited from one to the other according to the expression level.

	pdf("color-coded data matrix.pdf",family="Times",height=10,width=10)

	par(mar=c(2.75,2.75,0.5,0.5),mgp=c(1.7,.7,0))
		
	heatmap.2(dataset, 
		col=my_palette, 
		breaks=col_breaks,
		keysize=2, 
		trace=("none"),
		margins=c(3,5), 
		density.info=c("none")
			)

	dev.off()
