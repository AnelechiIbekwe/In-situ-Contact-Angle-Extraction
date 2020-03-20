# In-situ-Contact-Angle-Extraction
Automatic extraction of *in situ* contact angles from 2D and 3D pore space images

### Summary
This document presents MATLAB scripts and the accompanying instructions for running automatic extractions of in situ contact angles from segmented pore-space images of immiscible fluid pairs in porous media and 2D slices of them. The code performs the identification of contact points between the fluid/fluid/solid phases, an initial Coarse – and a final (Fine) estimate of contact angle distribution.

### Installation
You should have at least MATLAB  2015a installed on your computer.

## Usage
### Input file format
1. Input data are segmented pore space images. A stack of slices forms the 3D data set. 

2. The segmented: non-wetting (oil or gas), wetting (brine), and solid (rock) phases should have pixel values of 0, 1, and 2, or 1, 2, and 3, respectively. 

3. Example files comprising a stack of 2D images (basins000.tif to basins014.tif) are shown in the folders: 2DCoarseAndFineEstimate, 3DCoarseEstimate, and 3DFineEstimate. Air, Water, and Solid phases are respectively shown as grey, pink, and blue. 

### Running the 2D algorithm for both Coarse and Fine estimates
1. You can choose to run the code for only a single 2D slice - in which case you will need to run the **Compute2D.m** file, or for a stack of 2D slices – in which case you will need to run the **Run2DStack.m** file from the folder: 2DCoarseAndFineEstimate. 

2. If you wish to run a stack of 2D slices, then you must specify the number of slices ***“n”*** under the **Run2DStack.m file**. In addition, you will have to specify the orientation of the images by uncommenting the appropriate line of code under the **fun_Run2DStack.m** file. In some cases, you may also wish to reduce the size of each 2D image by specifying the x and y pixel ranges of the variable ***“b”*** under the **fun_Run2DStack.m** file.

3. To run either a single 2D slice, or a stack of slices, you will need to specify values for the variables: **compType** (**0** = coarse estimate, **1** = Fine estimate), **maxErr**, **dg** (in microns), and **Res** (in microns). **maxErr** is the maximum allowable fitting error (for the Fine estimate only). The default value = 2; the user can choose to increase this value. However, the lower the value, the lesser the fitting error, hence the better the confidence in the result. **dg** is the mean diameter of the grains, while **Res** is the spatial resolution of the image.

### Running the 3D algorithm for Coarse estimate
1. Specify the mean grain diameter **dg** (in microns), and the image resolution, **Res** (in microns). Then run the **Compute3DCoarse.m** file from the folder: 3DCoarseEstimate

2. The code runs the entire 3D volume of the input image. However, in some cases you may wish to run a subvolume of the 3D image by specifying the x, y and z minimum and maximum voxel values of the variable ***“I”*** under the **fun_Read2DStack.m** file. In cases where you choose to for instance reduce the x and y voxel value, but not the z value, then the minimum and maximum z values should be specified as ***“NaN”***. Please remember, as appropriate, to comment or uncomment the line of code with volume reduction under the **fun_Read2DStack.m** file.

### Running the 3D algorithm for the Fine estimate
1. Specify the **maxErr** (as described under the 2D algorithm), the mean grain diameter **dg** (in microns), and the image resolution, **Res** (in microns). Then run the **Compute3DFine.m** file from the folder: 3DFineEstimate

2. The code runs the entire 3D volume of the input image. However, in some cases you may wish to run a subvolume of the 3D image by specifying the x, y and z minimum and maximum voxel values of the variable ***“I”*** under the **fun_Read2DStack.m** file. In cases where you choose to for instance reduce the x and y voxel value, but not the z value, then the minimum and maximum z values should be specified as ***“NaN”***. Please remember, as appropriate, to comment or uncomment the line of code with volume reduction under the **fun_Read2DStack.m** file.

## Citation
If you use our code for your research, please cite the following relevant literature:
The developed algorithm for in-situ contact angle extraction
```
@article{https://doi.org/10.1016/j.cageo.2020.104425, 
author         = {Ibekwe, A., Pokrajac, D., and Tanino, Y.},
title          = {Automated extraction of in situ contact angles from micro-computed tomography images of porous media},
journal        = {Computers & Geosciences},
volume         = {137},
number         = {104425},
pages          = {1--12},
keywords       = {Contact angle, Wettability, Micro-CT, Tomography, multiphase flow, Pore scale imaging},
```
The actual code
```
@software{ibekwe_a_2020_3709319,
  author       = {Ibekwe, A., Pokrajac, D., and Tanino, Y.},
  title        = {MATLAB script for extracting in situ contact angles from 2D and 3D images},
  month        = mar,
  year         = 2020,
  publisher    = {Zenodo},
  version      = {v1.0.0},
  doi          = {10.5281/zenodo.3709319},
  url          = {https://doi.org/10.5281/zenodo.3709319}
}
```
