function[ix, iy] = fun_get_ixiy_from_inode(gridCoords, inode)
% This function obtains the x and y-coordinates of each node from the node count 

% where:
% edgeCoords = coordinates of all internal edges in the image
% iedge      = edge counts (from origin towards positive x-axis)


ix = NaN;
iy = NaN;

if inode <= 0
    return
end

a  = gridCoords(inode,:,:);
ix = a(:,1);                      % x-coord of the edge
iy = a(:,2);                      % y-coord of the edge    

end
