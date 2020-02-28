clc; clear; close all;

dbstop if error

tic

minR             = 1.5;
SMALL            = 1e-10;
plotFigure       = 0;
plotSearchradius = 0;

%%%%%%%%%%%%%%%%%%%%%%%%% Specify input parameters
%read in image
Name = 'basins000';
P   = imread([Name, '.tif']);

%specify maximum fitting error
maxErr           = 2;

%specify mean grain diameter (in microns)
dg = 966.5; 

%specify resolution (in microns)
Res = 10; 

%specify computation type (coarse estimate = 0 or fine estimate = 1)
compType      = 1;

%obtain searchRadius
R1 = fun_obtainSearchRadiusR1(dg, Res, compType);

nR = length(R1);
nCpoints     = zeros(nR, 1);
ThetaNormAv  = zeros(nR, 1);
ThetaModelAv = zeros(nR, 1);
ThetaNormSt  = zeros(nR, 1);
ThetaModelSt = zeros(nR, 1);


for iR = 1 : nR
    [ThetaNorm,ThetaModel] = fun_computeCA(P,compType,R1,minR,maxErr,SMALL,plotFigure,plotSearchradius);
                                           
     nCpoints(iR) = sum(isfinite(ThetaModel));
   
    ThetaNormAv(iR)  = nanmean(ThetaNorm);
    ThetaModelAv(iR) = nanmean(ThetaModel);
    ThetaNormSt(iR)  = nanstd(ThetaNorm);
    ThetaModelSt(iR) = nanstd(ThetaModel);
   
end

save(Name, 'nCpoints', 'ThetaNorm', 'ThetaNormAv', 'ThetaNormSt', 'ThetaModel', 'ThetaModelAv', 'ThetaModelSt');





toc