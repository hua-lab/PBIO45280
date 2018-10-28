	species<-c(1,2,3,4,5,6,7,8,9,10)
	gene_number<-c(21000,23000,33000,35000,45000,55000,65000,66000,67000,68000)

# <- gives the values on the right to the variable on the left.  Different to Perl, R does not have declared types of variables, such as string, array, and hash in Perl.  It gets the variables assigned by <- and can be changed dynamically.  
	ls()
# Similar to the UNIX ls command, ls() lists all the variables currently available in the workspace.
	plot(gene_number ~ species, pch=16)
# You will see a two-dimensional graph popped up on screen in your local X-Windows in PC or XQuartz in MAC are active.  If not, re install them in your local computer.  pch is a plotting character.  pch=16 tells the plot to print out a solid black dot.  If you want to know more detail about any R codes, you can type ? followed by the code in the terminal.  For example, type the code shown below to see what happens.
	?pch
#Type q to exit the help page in R.
# Now you may wonder how you will get the graph for your publication.  You will use a new function to print out the graph into a graphic file.  I always use PDF because it is editable in Adobe Illustrator, the best graphic editing software I like.
	pdf('gene_number_across_10_species.pdf',family='Times',height=10,width=10)
	plot(gene_number ~ species, pch=16)
	dev.off()

# dev.off() means close the device (graphic).  Now, you do not see any new input in your X-Windows or XQuartz.  Why? Because the file has been printed into a PDF file, named 'gene_number_across_10_species.pdf', in the same folder where you entered R.  Type the following code to get where you are in R.
	getwd()
3. Quit R by typing the command below
	q()
