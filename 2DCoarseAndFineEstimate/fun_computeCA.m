function [ThetaNorm, ThetaModel,cp] = fun_computeCA(P,compType,SearchRadius,minR,maxErr,SMALL,plotFigure,plotSearchradius)

%<-- Plot the image
if plotFigure
    RI = imref2d(size(P),[1 size(P, 2)],[1 size(P, 1)]);
    figure, imshow(P, RI, [], 'InitialMagnification','fit')
    grid on;
    hold on;
end

%<-- Change pixel labels to letter notations
[P] = fun_change_pixel_labels(P);

%<-- Obtain the image size
[ny, nx] = size(P);


%<-- Obtain full output mesh from grid vectors (1:ny and 1:nx)
[yGrids, xGrids] = meshgrid(1:ny, 1:nx);
gridCoords       = [xGrids(:), yGrids(:)];        %node coordinates



%%%%%%%%%%%%%%%% Compute the normal vectors around each node
%<-- Create a cell array to store your normal vectors
Allvectors = cell(ny*nx, 4);

for inode = 1:ny*nx;
    %Determine the x and y-coords of each node
    [ix, iy] = fun_get_ixiy_from_inode(gridCoords, inode);
    
    %Compute normal vectors at each face around each node
    [n, s, e, w] = fun_find_normal_vectors(iy, ix, P);
    
    %Assign the vector at each face to a location in the storage cell
    Allvectors{inode,1} = n;
    Allvectors{inode,2} = s;
    Allvectors{inode,3} = e;
    Allvectors{inode,4} = w;
end

%<-- Find contactpoints
[contactPoints, cp, Allvectors] = fun_findcontactpoints(Allvectors, gridCoords);

%<-- Pre-allocate storage for contact angles (CA)
ThetaNorm  = NaN(numel(contactPoints), 1);  %CA due to average normal vector
ThetaModel = NaN(numel(contactPoints), 1);  %CA due to curve fitting

%initialize inode_S and N to contactPointNodes
inode_in  = contactPoints;

%initialize the coordinates of x-point for the solid and non-wetting phases
xpoints = [];
xpointn = [];

%<-- Compute contact angles
for ncp = 1 : numel(contactPoints)
    
    %<-- Plot the search radius
    if plotSearchradius
       fun_number_contactPoints(ncp, cp, SearchRadius)
    end
    
    %<-- Find all X-points for WS ans WN interphases
    [avg_ns, xpoints] = fun_findXpoints('S', ncp, gridCoords, cp, inode_in, nx, contactPoints, SearchRadius,  minR,Allvectors);
    [avg_nn, xpointn] = fun_findXpoints('N', ncp, gridCoords, cp, inode_in, nx, contactPoints, SearchRadius,  minR,Allvectors);
       
    %<-- Fit line|curve through the collated WS|WN Xpoints 
    [~, ~, errS, nws] = fun_fitLine(cp(ncp,:), xpoints, avg_ns);
    [~, ~, errN, nwn] = fun_fitLine(cp(ncp,:), xpointn, avg_nn);
    
    %<-- Compute contact angles based on normal vectors & Line fitting
    if compType == 0
        ThetaNorm(ncp,:)  = fun_findTheta(avg_ns, avg_nn, SMALL);
    
    elseif compType ==1
        if errS < maxErr && errN < maxErr    % for acceptable quality of fitting
            ThetaModel(ncp,:) = fun_findTheta(nws, nwn, SMALL);
        end
    end
    
    
end


end