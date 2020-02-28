function [Allvectors, xpointArbitraryCell, inode_in, nsx, nsy, nsz, Radius] = fun_findNextnode(phase, ncp, edgeCoords, cp, inode_in, nx, ny, xpointArbitraryCell, Allvectors)
% This function computes the new nodes from previous ones.
%
% It also stores the new results in the storage cell "xpointArbitraryCell" but
% replaces the previous face that has a WS, WN or NS vector with NaN.


Ppls = [phase, '+'];
Pmin = [phase, '-'];

nsx = [NaN];
nsy = [NaN];
nsz = [NaN];
Radius(ncp,:) = [NaN];


if isempty(find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) )) == true  
    return;
end


%# an X-point lies on the north face (index == 1)
if ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 1 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, inode_in, edgeCoords, xpointArbitraryCell);
    
    % Plot the normal vectors
    %fun_plot_quiver_SPhase(ncp, ix, iy, iz, nsx, nsy, nsz, xpointArbitraryCell);
    
    %%%%%%%%%%%%%%% test for the location of inode_in
    % YZ plane (n,s,t,b)
    if mod(ix, 1) ~= 0
        %find the next node
        inode_in(ncp,:) =  inode_in(ncp,:) + (2*nx - 1);
        
        if inode_in(ncp,:) < 0 
            return  
        end
        
        %extract the all faces at that node from Allvectors
        a = Allvectors(inode_in(ncp),:);
        
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW southern face of the new edge
        % replace also the east(3) and west(4) faces)
        a([2, 3, 4]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
        
        % XY plane (n, s, e, w)
    elseif mod(iz, 1) ~= 0
        %find the next node
        inode_in(ncp,:) =  inode_in(ncp,:) + nx;
        
        if inode_in(ncp,:) < 0 
            return  
        end
        
        %extract the all faces at that node from Allvectors
        a = Allvectors(inode_in(ncp),:);
        
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW southern face of the new edge
        % replace also the top(5) and bottom(6) faces)
        a([2, 5, 6]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
    end
    
    
    %# an X-point lies on the south face  (index == 2)
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 2 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, inode_in, edgeCoords, xpointArbitraryCell);
    
    % Plot the normal vectors
    %fun_plot_quiver_SPhase(ncp, ix, iy, iz, nsx, nsy, nsz,  xpointArbitraryCell);
    
    %%%%%%%%%%%%%% test for the location of inode_in
    % YZ plane (n,s,t,b)
    if mod(ix, 1) ~= 0
        %find the next node
        inode_in(ncp,:) =  inode_in(ncp,:) - (2*nx - 1);
        
        if inode_in(ncp,:) < 0 
            return  
        end
        
        %extract the all faces at that node from Allvectors
        a = Allvectors(inode_in(ncp),:);
        
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW southern face of the new edge
        % replace also the east(3) and west(4) faces)
        a([1, 3, 4]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
        
        % XY plane (n, s, e, w)
    elseif mod(iz, 1) ~= 0
        %find the next node
        inode_in(ncp,:) =  inode_in(ncp,:) - nx;
        
        if inode_in(ncp,:) < 0 
            return  
        end
        
        %extract the all faces at that node from Allvectors
        a = Allvectors(inode_in(ncp),:);
        
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW northern face of the new edge
        % replace also the top(5) and bottom(6) faces)
        a([1, 5, 6]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
    end
    
    
    %# an X-point lies on the east face (index == 3)
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 3 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, inode_in, edgeCoords, xpointArbitraryCell);
    
    % Plot the normal vectors
    %fun_plot_quiver_SPhase(ncp, ix, iy, iz, nsx, nsy, nsz,  xpointArbitraryCell);
    
    % find the next node
    inode_in(ncp,:) =  inode_in(ncp,:) + 1;
    
    if inode_in(ncp,:) < 0 
        return  
    end
    
    % extract the all faces at that node from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    %%%%%%%%%%%%% test for the location of inode_in
    % XZ plane (e, w, t, b)
    if mod(iy, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW western face of the new edge
        % replace also the north(1) and south(2) faces)
        a([1, 2, 4]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
        
        % XY plane (n, s, e, w)
    elseif mod(iz, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW western face of the new edge
        % replace also the top(5) and bottom(6) faces)
        a([4, 5, 6]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of  xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
    end
    
    
    %# an X-point lies on the west face  (index == 4)
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 4 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, inode_in, edgeCoords, xpointArbitraryCell);
    
    % Plot the normal vectors
    %fun_plot_quiver_SPhase(ncp, ix, iy, iz, nsx, nsy, nsz,  xpointArbitraryCell);
    
    % find the next node
    inode_in(ncp,:) =  inode_in(ncp,:) - 1;
    
    if inode_in(ncp,:) < 0 
        return  
    end
    
    % extract the all faces at that edge from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    %%%%%%%%%%%%%% test for the location of inode_in
    % XZ plane (e, w, t, b)
    if mod(iy, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW eastern face of the new edge
        % replace also the north(1) and south(2) faces)
        a([1, 2, 3]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
        
        % XY plane (n, s, e, w)
    elseif mod(iz, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW eastern face of the new edge
        % replace also the top(5) and bottom(6) faces)
        a([3, 5, 6]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of  xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
    end
    
    
    %# an X-point lies on the top face  (index == 5)
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 5 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, inode_in, edgeCoords, xpointArbitraryCell);
    
    % Plot the normal vectors
    %fun_plot_quiver_SPhase(ncp, ix, iy, iz, nsx, nsy, nsz,  xpointArbitraryCell);
    
    % find the next node
    inode_in(ncp,:)  = inode_in(ncp,:) + ( ny*(2*nx - 1) - nx + (nx*ny) );
    
    if inode_in(ncp,:) < 0 
        return  
    end
    
    % extract the all faces at that node from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    
    %%%%%%%%%%%%%%% test for the location of inode_S
    % YZ plane (n, s, t, b)
    if mod(ix, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW bottom face of the new edge
        % replace also the east(3) and west(4) faces)
        a([3, 4, 6]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
        
        % XZ plane (e, w, t, b)
    elseif mod(iy, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW bottom face of the new edge
        % replace also the north(1) and south(2) faces)
        a([1, 2, 6]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of  xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
    end
    
    
    
    %# an X-point lies on the bottom face  (index == 6)
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 6 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsx,nsy,nsz,ix,iy,iz] = fun_collateNormalVectors(phase, ncp, inode_in, edgeCoords, xpointArbitraryCell);
    
    % Plot the normal vectors
    %fun_plot_quiver_SPhase(ncp, ix, iy, iz, nsx, nsy, nsz,  xpointArbitraryCell);
    
    % find the next node
    inode_in(ncp,:)  = inode_in(ncp,:) - ( ny*(2*nx - 1) - nx + (nx*ny) );
    
    if inode_in(ncp,:) < 0 
        return  
    end
    
    % extract the all faces at that edge from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    %%%%%%%%%%%%%% test for the location of inode_in
    % YZ plane (n, s, t, b)
    if mod(ix, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW top face of the new edge
        % replace also the east(3) and west(4) faces)
        a([3, 4, 5]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of  xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
        
        % XZ plane (e, w, t, b)
    elseif mod(iy, 1) ~= 0
        %store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW top face of the new edge
        % replace also the north(1) and south(2) faces)
        a([1, 2, 5]) = {NaN};
        xpointArbitraryCell(ncp,:) = a;
        
        %obtain a new Allvectors as a counterpart of  xpointArbitraryCell above
        Allvectors(inode_in(ncp),:) = a;
    end
end




%%%%%%%%% compute the distance between current inode_in and contactPoint
[ixnode, iynode, iznode] = fun_get_ixiyiz_from_inode(edgeCoords, inode_in);  %firstly obtain the coordinates of the current edge

% Then find the distance
Radius(ncp,:) = sqrt( (cp(ncp, 1) - ixnode(ncp)).^2 + (cp(ncp, 2) - iynode(ncp)).^2 + (cp(ncp, 3) - iznode(ncp)).^2 );


end


