function [edgeCoords,xGrid,yGrid,zGrid] = fun_getEdgeCoords(nx, ny, nz)



% Obtain full output grids from the grid vectors (i.e. 1:imageSizeX and 1:imageSizeY)
[xGrid, yGrid, zGrid] = ndgrid(1:0.5:nx, 1:0.5:ny, 1:0.5:nz);

% Obtain coordinates of all vertices, faces, and edges
allCoords = [xGrid(:), yGrid(:), zGrid(:)];

% Obtain only the Edge coords by removing all integers from "allcords"
edgeCoords = allCoords;
edgeCoords((sum(mod(allCoords,1)~=0, 2))~=1, :) = [];

% Re-mesh the 3D grid using voxel size = 1
[xGrid, yGrid, zGrid] = ndgrid(1:nx, 1:ny, 1:nz);





end