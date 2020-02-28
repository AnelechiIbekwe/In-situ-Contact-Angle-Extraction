function [Allvectors, xpointArbitraryCell, inode_in, nsy, nsx, Radius] = fun_findNextnode(phase, ncp, gridCoords, cp, inode_in, nx, xpointArbitraryCell, Allvectors)
% This function computes the new nodes from previous ones.
%
% It also stores the new results in the storage cell "xpointArbitraryCell" but
% replaces the previous face that has a WS, WN or NS vector with NaN.



Ppls = [phase, '+'];
Pmin = [phase, '-'];


nsx = [NaN];
nsy = [NaN];
Radius(ncp,:) = [NaN];

if isempty(find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) )) == true  
    return;
end

%# an X-point lies on the north face (index == 1) 
if ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 1 ) == true  
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsy, nsx]                 = fun_collateNormalVectors(phase, ncp, xpointArbitraryCell);
    
    % Find the node at the northern end of the face which contains the X-point
    inode_in(ncp,:) =  inode_in(ncp,:) - nx;
    
    if inode_in(ncp,:) <= 0
        return
    end
    
    % extract the n, s, e, w faces at that node from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    % store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW southern face of the new node)
    a(2) = {NaN};
    xpointArbitraryCell(ncp,:) = a;
    
    % Obtain a new Allvectors that also replaces (with a NaN) the southern face for the current node  
    Allvectors(inode_in(ncp),:) = a;
    

    
%# an X-point lies on the south face  (index == 2)   
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 2 ) == true  
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsy, nsx]                 = fun_collateNormalVectors(phase, ncp, xpointArbitraryCell);
     
    % Find the node at the southern end of the face which contains the X-point
    inode_in(ncp,:) = inode_in(ncp,:) + nx;
    
    if inode_in(ncp,:) <= 0
        return
    end
    
    % extract the n, s, e, w faces at that node from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    % store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW northern face of the new node)
    a(1) = {NaN};
    xpointArbitraryCell(ncp,:) = a;
    
    % Obtain a new Allvectors that also replaces (with a NaN) the northern face for the current node 
    Allvectors(inode_in(ncp),:) = a;
    

%# an X-point lies on the east face (index == 3)       
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 3 ) == true       
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsy, nsx]                 = fun_collateNormalVectors(phase, ncp, xpointArbitraryCell);
    
    % Find the node at the eastern end of the face which contains the X-point
    inode_in(ncp,:)  = inode_in(ncp,:) + 1;
    
    if inode_in(ncp,:) <= 0
        return
    end
    
    %  extract the n, s, e, w faces at that node from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    % store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW western face of the new node)
    a(4) = {NaN};
    xpointArbitraryCell(ncp,:) = a;
    
    % Obtain a new Allvectors that also replaces (with a NaN) the western face for the current node 
    Allvectors(inode_in(ncp),:) = a;
    
    
%# an X-point lies on the west face  (index == 4)    
elseif ( find( strcmp(Ppls, Allvectors(inode_in(ncp),:)) | strcmp(Pmin, Allvectors(inode_in(ncp),:)) ) == 4 ) == true
    
    % get the normal vectors at inode_in
    xpointArbitraryCell(ncp,:) = Allvectors(inode_in(ncp),:);
    [nsy, nsx]                 = fun_collateNormalVectors(phase, ncp, xpointArbitraryCell);
    
    % Find the node at the western end of the face which contains the X-point
    inode_in(ncp,:)  = inode_in(ncp,:) - 1;
    
    if inode_in(ncp,:) <= 0
        return
    end
    
    % extract the n, s, e, w faces at that node from Allvectors
    a = Allvectors(inode_in(ncp),:);
    
    % store the new results (while replacing the existing 'S+' or 'S-' vector at the NOW eastern face of the new node)
    a(3) = {NaN};
    xpointArbitraryCell(ncp,:) = a;
    
    % Obtain a new Allvectors that also replaces (with a NaN) the eastern face for the current node
    Allvectors(inode_in(ncp),:) = a;
end




%%%%%% compute the distance between current inode_S and contactPointNodes
[ixnode, iynode] = fun_get_ixiy_from_inode(gridCoords, inode_in);  %# firstly obtain the coordinates of the current node

%# Then find the distance
Radius(ncp,:) = sqrt( (cp(ncp, 1) - ixnode(ncp)).^2 + (cp(ncp, 2) - iynode(ncp)).^2 );


end
