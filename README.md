# UMAP Model for Basic Metabolic Panel Results
A Production Repository for the Automated Detection of Laboratory Errors in BMP Results Using UMAP.

# Install Instructions
1) Install Docker. 
	- https://docs.docker.com/get-docker/

2) Clone git repo to local machine 
	- git clone https://github.com/nspies13/bmp_umap.git
	- If you are new to git, check [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) for how-to guides.

3) Format Input Data to match input_file.tsv
	- Each row should be a unique BMP result, without NA or non-numeric results.
	- All 8 components of the BMP should be included in their own columns with the following names: 
		- sodium
		- chloride
		- potassium_plas
		- co2_totl
		- bun
		- creatinine
		- calcium
		- glucose
	- Anion gap will be calculated as (sodium - chloride - co2_totl)
	- Extra columns for metadata will be joined to final output, but will not be used for the embedding.
	
4) Run docker command, where dir_path is the absolute path to where the Box folder is saved. Relative paths may cause errors (e.g. '/Users/nspies/Downloads/umap...' instead of 'Downloads/umap...') . 
	$ docker run -v <dir_path>:<dir_path> \
	nspies13/bmp_umap:prod Rscript <dir_path>/Code/applyUMAP.R \
	<path_to_input_data> \
	<dir_path>/Model/UMAP_bmp_results_20230208 \
	<path_for_desired_output_file>

5) If successful, a new file should have been created in the <path_for_desired_output_file> directory named "umap_output_<TIMESTAMP>.txt" containing the input bmp columns and two new columns, UMAP1 and UMAP2, containing embedding coordinates. 
