function [ThetaNorm, ThetaModel,cp] = fun_Run2DStack(slice,compType,SearchRadius,minR,maxErr,SMALL,plotFigure,plotSearchradius)


% Read in 2D stack
a = dir('*.tif');   

for ii = 1: numel(a)
    %Read in each 2D slice
    b  = imread(a(ii).name);   
    %b  = b(195:345, 195:345); % specify the x and y pixel ranges.
    
    %Store 2D stack as a 3D image
    I(:,:,ii) = b;
end

% Create 2D slices from the 3D volume
P = I(:,:,slice);                   % XY slice
%P = permute(I(slice,:,:),[2 3 1]); % XZ slice
%P = permute(I(:,slice,:),[1 3 2]); % YZ slice

nR = length(SearchRadius);

for iR = 1 : nR
     [ThetaNorm, ThetaModel,cp] = fun_computeCA(P,compType,SearchRadius,minR,maxErr,SMALL,plotFigure,plotSearchradius);
end


end