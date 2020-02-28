clc; clear; close all;

dbstop if error

tic

minR             = 1.5;
SMALL            = 1e-10;
plotSurfaces     = 0;
plotSearchradius = 0;


%%%%%%%%%%%%%%%%%%%%%%%%% Specify input parameters
%specify maximum fitting error
maxErr           = 2;

%specify mean grain diameter (in microns)
dg = 966.5; 

%specify resolution (in microns)
Res = 10; 

%obtain searchRadius R1 and R2
[R1, R2] = fun_obtainR1andR2(dg, Res);

%%%%%%%%%%%%%%%%%%%%%%%%% Read in Segmented image (2D slices)
a   = dir('*.tif');
[P] = fun_Read2Dstacks(a);

nR = length(R1);
nCpoints     = zeros(nR, 1);
ThetaModelAv = zeros(nR, 1);
ThetaModelSt = zeros(nR, 1);

for iR = 1 : nR
     [ThetaModel, cp] = fun_computeCA(P, R1(iR), R2, minR, maxErr, SMALL, plotSurfaces, plotSearchradius); 
                                          
     nCpoints(iR)    = sum(isfinite(ThetaModel));  
     ThetaModelAv(iR)= nanmean(ThetaModel);
     ThetaModelSt(iR)= nanstd(ThetaModel);
       
end

save('3D Fine estimate.mat', 'R1', 'R2', 'nCpoints', 'cp', 'ThetaModel', 'ThetaModelAv', 'ThetaModelSt');



toc