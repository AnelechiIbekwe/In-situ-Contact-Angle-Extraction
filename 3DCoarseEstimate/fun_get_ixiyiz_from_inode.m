function[ix, iy, iz] = fun_get_ixiyiz_from_inode(edgeCoords, inode)
% This function obtains the x and y-coordinates of each node from the node count 

% where:
% edgeCoords = coordinates of all internal edges in the image
% iedge      = edge counts (from origin towards positive x-axis)


a  = edgeCoords(inode,:,:);
ix = a(:,1);                      % x-coord of the edge
iy = a(:,2);                      % y-coord of the edge    
iz = a(:,3);                      % z-coord of the edge


end
