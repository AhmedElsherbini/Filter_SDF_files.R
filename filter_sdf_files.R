#@uthor: Ahmed Elsherbini - 26-08-2020
#mail:drahmedsherbini@yahoo.com

#install your packages

install.packages("cinf", repos="http://R-Forge.R-project.org")
install.packages("conmolfields", repos="http://R-Forge.R-project.org")
install.packages("rlist")


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
write_sdf(ECOLI_MIX,"ECOLI_MIX_460.sdf")
write_sdf(STAPH_MIX,"STAPH_gyrB_209.sdf")

