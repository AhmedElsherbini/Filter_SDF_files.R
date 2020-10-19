#@uthor: Ahmed Elsherbini - 26-08-2020
#mail:drahmedsherbini@yahoo.com
#please cite my page if you used this script

#install your packages

install.packages("cinf", repos="http://R-Forge.R-project.org")
install.packages("conmolfields", repos="http://R-Forge.R-project.org")
install.packages("rlist",repos="http://R-Forge.R-project.org")
install.packages("gplots",repos="http://R-Forge.R-project.org")


#load your libraries

library(conmolfields)
library("cinf")
library(rlist)

# let's us read our files 
#put here your downladed
mdb = read_sdf("YOUR_PATH_TO_THE_FILE/Your_mixed_file.sdf")

#make two empty list for the two separte categeori you want to divide your files to, if you have 3 categories , make a three empty list
#make the names of the empty as you like #here I made it upon the organism
ECOLI_MIX = list()
STAPH_MIX = list()

#here to loop over the main SDF file, then filter it according to a certain chosen parameter (= organism) 
# if you want another paramter just type after prop$ and see which paramter you want to divide you data for. 
#here also, I use Unique() to remove any duplicates

for (x in mdb) { 
  if (x$props$`Target Source Organism According to Curator or DataSource` == "Escherichia coli")
    ECOLI_MIX = unique(c(ECOLI_MIX,list(x)))
  
  else if (x$props$`Target Source Organism According to Curator or DataSource` == "Staphylococcus aureus") 
    STAPH_MIX = unique(c(STAPH_MIX,list(x)))
}


#export the data into two sdf files one for ecoli and and one for staph
#change the name as you like
write_sdf(ECOLI_MIX,"filtered_file_for_staph.sdf") 
write_sdf(STAPH_MIX,"filtered_file_for_ecoli.sdf")



#lets cluster our filtered SDF to see how much they are similar
#there was a probelm in installing ChemmineR and FmcsR due to a bug in rvsg package
#to install package ("rsvg") in Ubunto 18.04 or 20.04 do not use CRAN repo but, in your linux terminal type $ sudo apt-get install -y librsvg2-dev
#install the packages now without any hassle now
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ChemmineR")
BiocManager::install("fmcsR")
sdfset <- read.SDFset("your_Path/file.sdf") #change the path accprding 
apset <- sdf2ap(sdfset) #we need to convert sdf to atom pair dataset
fpset <- desc2fp(apset) #we need to convert ato,

#creat the distanse between your compunds and save it is .rda file
dummy <- cmp.cluster(db=apset, cutoff=0, save.distances="distmat.rda", quiet=TRUE) #lets make the 
load("distmat.rda") 

#plot your dendogram
simMA <- sapply(cid(fpset), function(x) fpSim(fpset[x], fpset, sorted=FALSE))
hc <- hclust(as.dist(1-simMA), method="single") 
plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE) 

#plot your heatmap (more clear than the dendogram)
heatmap.2(1-distmat, Rowv=as.dendrogram(hc), Colv=as.dendrogram(hc), 
          col=colorpanel(40, "darkblue", "yellow", "white"), 
          density.info="none", trace="none") 
