#@uthor: Ahmed Elsherbini - 26-08-2020
#mail:drahmedsherbini@yahoo.com
#update: 25/10/2020
#install your packages
#####################################################################################
#first part - filter and deduplicate your sdf based on metadata (example:organisms)
install.packages("cinf", repos="http://R-Forge.R-project.org")
install.packages("conmolfields", repos="http://R-Forge.R-project.org")
install.packages("rlist",repos="http://R-Forge.R-project.org")
#####################################################################################

#load your libraries

library(conmolfields)
library("cinf")
library(rlist)
library(gplots) 
library(rlist)

# let's us read our files 
#put here your downladed
setwd("path to you dir")
#read your data
mdb = read_sdf("path to your file.sdf")

#make an empty list 

ECOLI_MIX = list()
STAPH_MIX = list()

#here to loop over the main SDF file, then filter it according to a certain chosen parameter (= organism, s.aureus &eE.coli) 
#here also, I use Unique() to remove any duplicates

for (x in mdb) { 
  if (x$props$`Target Source Organism According to Curator or DataSource` == "Escherichia coli")
    ECOLI_MIX = unique(c(ECOLI_MIX,list(x)))
  
  else if (x$props$`Target Source Organism According to Curator or DataSource` == "Staphylococcus aureus") 
    STAPH_MIX = unique(c(STAPH_MIX,list(x)))
}


#export the data into sdf file
write_sdf(ECOLI_MIX,"example_1.sdf")
write_sdf(STAPH_MIX,"example_2.sdf")

###################################################################################################################### 
#Second-part- cluster your sdf based on chemical fingerprint.
#to install package ("rsvg") in Ubunto 20.04 #in your linux terminal type $ sudo apt-get install -y librsvg2-dev (do not use cran repo)
BiocManager::install("ChemmineR")
BiocManager::install("fmcsR")
#install your libriaries
library("ChemmineR") # Loads the 
library("fmcsR")
library("gplots")

#you need to reread the data with sdfset 
sdfset = read.SDFset("/media/ahmed/CC69-620B/0_downloads/dr.tamer_FQ_/new_project/sepated_sdf/staph_gyra_30.sdf")
#d = sapply(cid(sdfset), function(x) fmcsBatch(sdfset[x], sdfset, au=0, bu=0, matching.mode="aromatic")[,"Overlap_Coefficient"])
#hc = hclust(as.dist(1-d), method="complete")
#plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE)

apset = sdf2ap(sdfset)
fpset = desc2fp(apset)

#
dummy = cmp.cluster(db=apset, cutoff=0, save.distances="distmat.rda", quiet=TRUE) 
load("distmat.rda") 

#fingerptting/heirchal clusterng/bulid a heatmap
simMA = sapply(cid(fpset), function(x) fpSim(fpset[x], fpset, sorted=FALSE))
hc = hclust(as.dist(1-simMA), method="single") 
plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE)
pdf("nameofyourplot.pdf") 
heatmap.2(1-distmat, Rowv=as.dendrogram(hc), Colv=as.dendrogram(hc), 
          col=colorpanel(40, "darkblue", "yellow", "white"), 
          density.info="none", trace="none") #white similar-blue dissmilar
dev.off()
#open the pdf file and copy the numbers and paste it in a list
#to convert a column to comma separated list use (https://convert.town/column-to-comma-separated-list) 
###############################################################################################################
#third part- subset your sdf based on id/headers
               
mdb = read_sdf("path_to your.sdf")
#here for example I want to extract the 12th and 3rd and the 134th compound from my sdf file or the comma seperated list from the above chunck
list = list(12,3,134)
subset = list()
for (x in list){
  subset = unique(c(subset,mdb[x]))
}
write_sdf(subset,"subset.sdf")
###################################################################################################################
#the fourth part to print ID list of your sdf files                
id_list = list()

for (x in mdb){
  id_list= c(id_list,list(x$props$`BindingDB Ligand Name`))
}
print(id_list)

