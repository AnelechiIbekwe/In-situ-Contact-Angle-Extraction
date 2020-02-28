function[nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, iedge_in, edgeCoords, xpointArbitraryCell)
%This function collates the normal vector components for each x-point
%it returns the unit normal vector of the solid phase for all x-points


Ppls = [phase, '+'];
Pmin = [phase, '-'];

% initialize the vectors
nsx(ncp,:) = NaN;  
nsy(ncp,:) = NaN;  
nsz(ncp,:) = NaN;  


% Obtain the x,y,z coordinates of the current node 
[ix, iy, iz] = fun_get_ixiyiz_from_inode(edgeCoords, iedge_in(ncp));


% YZ Plane
if mod(ix, 1) ~= 0
    %# normal direction @north face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 1) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 1;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 1) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = -1;
    end
    
    %# normal direction @south face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 2) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 1;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 2) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = -1;
    end
    
    %# normal direction @top face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 5) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 1;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 5) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = -1;
        nsz(ncp,:) = 0;
    end
    
    %# normal direction @bottom face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 6) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 1;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 6) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = -1;
        nsz(ncp,:) = 0;
    end
end






% XZ Plane
if mod(iy, 1) ~= 0
    %# normal direction @east face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 3) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 1;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 3) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = -1;
    end
    
    %# normal direction @west face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 4) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 1;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 4) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = -1;
    end
    
    %# normal direction @top face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 5) == true 
        nsx(ncp,:) = 1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 5) == true 
        nsx(ncp,:) = -1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    end
    
    %# normal direction @bottom face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 6) == true 
        nsx(ncp,:) = 1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 6) == true 
        nsx(ncp,:) = -1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    end
end






% XY Plane
if mod(iz, 1) ~= 0
    %# normal direction @north face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 1) == true 
        nsx(ncp,:) = 1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 1) == true 
        nsx(ncp,:) = -1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    end
    
    %# normal direction @south face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 2) == true 
        nsx(ncp,:) = 1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 2) == true 
        nsx(ncp,:) = -1;
        nsy(ncp,:) = 0;
        nsz(ncp,:) = 0;
    end
    
    %# normal direction @east face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 3) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 1;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 3) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = -1;
        nsz(ncp,:) = 0;
    end
    
    %# normal direction @west face
    if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 4) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = 1;
        nsz(ncp,:) = 0;
    elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 4) == true 
        nsx(ncp,:) = 0;
        nsy(ncp,:) = -1;
        nsz(ncp,:) = 0;
    end
end




end

