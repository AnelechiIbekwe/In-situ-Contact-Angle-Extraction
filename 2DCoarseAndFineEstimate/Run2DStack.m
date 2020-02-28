clc; clear; close all;

dbstop if error

tic

minR             = 1.5;
SMALL            = 1e-10;
plotFigure       = 0;
plotSearchradius = 0;

%%%%%%%%%%%%%%%%%%%%%%%%% Specify the input parameters
%specify number of slices
n = 15;

for i = 1:n
    slice(i) = i;
end

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


%<-- Pre-allocate storage for contact angles (CA)
ThetaNorm    = cell(numel(slice), 1);
ThetaModel   = cell(numel(slice), 1); 
cp           = cell(numel(slice), 1); 

%%%%%%%%%%%%%%%%%%%%%%%%% Compute CA for different slices
for kk = 1: numel(slice)
    
    [ThetaNorm{kk,:}, ThetaModel{kk,:}, cp{kk,:}] =  fun_Run2DStack(slice(kk),compType,R1,minR,maxErr,SMALL,plotFigure,plotSearchradius);
    
end

data        = sort(vertcat(ThetaNorm{:}));
ThetaNormAv = nanmean(data);
ThetaNormSt = nanstd(data);

data         = sort(vertcat(ThetaModel{:}));
ThetaModelAv = nanmean(data);
ThetaModelSt = nanstd(data);


save('2D stack.mat', 'SearchRadius', 'cp', 'ThetaNorm', 'ThetaNormAv', 'ThetaNormSt', 'ThetaModel', 'ThetaModelAv', 'ThetaModelSt') 



toc

