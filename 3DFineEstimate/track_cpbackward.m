function [Idxb, Radiuscp, ix, iy, iz] = track_cpbackward(ncp, cp, ix, iy, iz)
%This function finds closest contact points from the current one.
%The computation is done for the backward locations
%
% idxb = index of the contactpoint neighbours



% Obtain the coordinates of the current contactpoint
%[ix, iy, iz] = fun_get_ixiyiz_from_inode(edgeCoords, contactPoints(ncp));


%%%%%%%%%%%%% decide what plane lies the current contactpoint
% ContactPoint on the YZ plane
if mod(ix, 1) ~= 0
    %find the closest vertex (backward)
    ix = ix - 0.5;
    
    %test for the location of the closest contactPoint (backward)
    bNorth = [ix, iy+0.5, iz];
    bSouth = [ix, iy-0.5, iz];
    bWest  = [ix-0.5, iy, iz];
    bTop   = [ix, iy, iz+0.5];
    bBottom= [ix, iy, iz-0.5];
    
    %compare the above 5 possible locations to all contactpoints to see if any is close
    Idxb = find(ismember(cp, vertcat(bNorth, bSouth, bWest, bTop, bBottom), 'rows'));
    
    %move to the next closest vertex (backward)
    ix = ix - 0.5;
    
      
% ContactPoint on the XZ plane
elseif mod(iy, 1) ~= 0
    %find the closest vertex (backward)
    iy = iy - 0.5;
    
    %test for the location of the closest contactPoint (backward)
    bSouth = [ix, iy-0.5, iz];
    bEast  = [ix+0.5, iy, iz];
    bWest  = [ix-0.5, iy, iz];
    bTop   = [ix, iy, iz+0.5];
    bBottom= [ix, iy, iz-0.5];
    
    %compare the above 5 possible locations to all contactpoints to see if any is close
    Idxb = find(ismember(cp, vertcat(bSouth, bEast, bWest, bTop, bBottom), 'rows'));
    
    %move to the next closest vertex (backward)
    iy = iy - 0.5;
    
    
% ContactPoint on the XY plane
elseif mod(iz, 1) ~= 0
    %find the closest vertex (backward)
    iz = iz - 0.5;
    
    %test for the location of the closest contactPoint (backward)
    bNorth = [ix, iy+0.5, iz];
    bSouth = [ix, iy-0.5, iz];
    bEast  = [ix+0.5, iy, iz];
    bWest  = [ix-0.5, iy, iz];
    bBottom= [ix, iy, iz-0.5];
    
    %compare the above 5 possible locations to all contactpoints to see if any is close
    Idxb = find(ismember(cp, vertcat(bNorth, bSouth, bEast, bWest, bBottom), 'rows'));
    
    %move to the next closest vertex (backward)
    iz = iz - 0.5;
end


% Compute the distance btw current cp and the location of current vertex
Radiuscp(ncp,:) = sqrt( (cp(ncp, 1) - ix).^2 + (cp(ncp, 2) - iy).^2 + (cp(ncp, 3) - iz).^2 );



end


