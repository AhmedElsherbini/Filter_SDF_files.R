# filter_SDF_FILE.R
SDF Structure Data File is a chemical-data file that stores structural information and the metadata of the chemical compounds. The file has a wide variety of usages. This simple script is used to divide, filter, and deduplicate SDF based on its metadata. I hope it helps!
To use it, make sure you have installed the required pacakages (conmolfields, cinf ,and rlist).
#Download the file 
modify path_of_file to your path
#you have to see if the paramter you want to filter your data for is present or not # type prop$
#then using ChemmineR package I will enable you from cluster your SDF based on their Chmebel fingerprint you can plot dendogram or heatmap of your SDF data
