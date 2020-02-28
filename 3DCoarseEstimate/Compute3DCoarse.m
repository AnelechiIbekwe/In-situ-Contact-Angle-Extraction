clc; clear; close all;

dbstop if error

tic

minR             = 1.5;
SMALL            = 1e-10;
plotSurfaces     = 0;
plotSearchradius = 0;


%%%%%%%%%%%%%%%%%%%%%%%%% Specify input parameters
%specify mean grain diameter (in microns)
dg = 966.5; 

%specify resolution (in microns)
Res = 10; 

%obtain searchRadius
R1 = fun_obtainR1(dg, Res);

%%%%%%%%%%%%%%%%%%%%%%%%% Read in Segmented image (2D slices)
a   = dir('*.tif');
[P] = fun_Read2Dstacks(a);

nR = length(R1);
nCpoints     = zeros(nR, 1);
ThetaNormAv  = zeros(nR, 1);
ThetaNormSt  = zeros(nR, 1);

for iR = 1 : nR
     [ThetaNorm, cp] = fun_computeCA(P, R1(iR), minR, SMALL, plotSurfaces, plotSearchradius); 
     
     nCpoints(iR)    = sum(isfinite(ThetaNorm));
     ThetaNormAv(iR) = nanmean(ThetaNorm);
    ThetaNormSt(iR)  = nanstd(ThetaNorm);
       
end

save('3D Coarse-estimate.mat', 'SearchRadius', 'nCpoints', 'cp', 'ThetaNorm', 'ThetaNormAv', 'ThetaNormSt');



toc