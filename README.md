# Filter&cluster_SDF_files.R

SDF (Structure Data File) is a chemical-data file that stores structural information and the metadata of the chemical compounds. The file has a wide variety of usages. This simple script is used to divide, filter, and deduplicate SDF based on its metadata (example: most of the data that come from repo like BindingDB are redundant and and may contain different species !). then, this script enables you to cluster your filtered data based on their chemical fingerprint. And finally, extract a clustered file.

## Installation

Make sure that you have R 4.0.2 or above and all the libraries!


## Usage
Download the R file on your and open in R studio.

modify every path_of_file to your directory path.

choose the paramter (in my case it was the bacterial species) you want to filter your data for is present or not (type prop$)

## Contributing
Pull requests are very welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
the tool is still under development!

Contact me directly on email : drahmedsherbini@yahoo.com


## License
Please, cite my page if this tool was useful for your work
