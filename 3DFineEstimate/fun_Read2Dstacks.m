function [P] = fun_Read2Dstacks(a)




for ii = 1: numel(a)
    % read in each 2D stack
    b  = imread(a(ii).name);
    
    % store image stack as a 3D image
    I(:,:,ii) = b;
end

%<-- Extract subvolume of the image
I = subvolume(I,[195,345, 195,345, NaN,NaN]); %extract y,x,z near the center of the image

%<-- Change from image coordinates to cartesian coordinates
P = flipud(double(I));



end