# UMAP Model for Basic Metabolic Panel Results

A Production Repository for the Automated Detection of Laboratory Errors in BMP Results Using UMAP.

*Written and maintained by Nick Spies, MD*.

--- 

# Install Instructions

### 1) Install Docker. 
[Install Instructions](https://docs.docker.com/get-docker/).


### 2) Clone git repo to local machine 
```
git clone https://github.com/nspies13/bmp_umap.git
```
- If you are new to git, check [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) for how-to guides.


### 3) Replace /Data/input_file.tsv with your desired input data. 
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


### 4) Run docker command, where <dir_path> is the absolute path to where the repository is cloned. 
```	
 docker run -v <dir_path>/bmp_umap:/bmp_umap nspies13/bmp_umap:prod Rscript /bmp_umap/Code/applyUMAP.R
```

### 5) If successful, a new file should have been created in <dir_path>.
- The file should be named 'umap_output_<TIMESTAMP>.txt' 
- It contains the input BMP columns and two new columns, UMAP1 and UMAP2, containing embedding coordinates. 
