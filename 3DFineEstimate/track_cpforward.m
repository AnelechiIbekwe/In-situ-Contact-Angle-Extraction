function [Idxf, Radiuscp, ix, iy, iz] = track_cpforward(ncp, cp, ix, iy, iz)
%This function finds closest contact point(s) from the current one.
%The computation is done for the forward locations
%
% idxf = index of the contactpoint neighbours



% Obtain the coordinates of the current contactpoint
%[ix, iy, iz] = fun_get_ixiyiz_from_inode(edgeCoords, contactPoints(ncp));


%%%%%%%%%%%%% decide what plane lies the current contactpoint
% ContactPoint on the YZ plane
if mod(ix, 1) ~= 0
    %find the closest vertex (forward)
    ix = ix + 0.5;
       
    %test for the location of the closest contactPoint (radius == 1) by adding the
    % corresponding displacement vectors to "ifvertex"
    fNorth = [ix, iy+0.5, iz];
    fSouth = [ix, iy-0.5, iz];
    fEast  = [ix+0.5, iy, iz];
    fTop   = [ix, iy, iz+0.5];
    fBottom= [ix, iy, iz-0.5];
            
    %compare the above 5 possible locations to all contactpoints to see if any is close
    Idxf = find(ismember(cp, vertcat(fNorth, fSouth, fEast, fTop, fBottom), 'rows'));

    %move to the next closest vertex (forward)
    ix = ix+ 0.5;
          
    
% ContactPoint on the XZ plane   
elseif mod(iy, 1) ~= 0
    %find the closest vertex (forward)
    iy = iy + 0.5;
       
    %test for the location of the closest contactPoint (radius == 1) by adding the
    % corresponding displacement vectors to "ifvertex"
    fNorth = [ix, iy+0.5, iz];
    fEast  = [ix+0.5, iy, iz];
    fWest  = [ix-0.5, iy, iz];   
    fTop   = [ix, iy, iz+0.5];
    fBottom= [ix, iy, iz-0.5];
     
    %compare the above 5 possible locations to all contactpoints to see if any is close
    Idxf = find(ismember(cp, vertcat(fNorth, fEast, fWest, fTop, fBottom), 'rows'));
  
    %move to the next closest vertex (forward)
    iy= iy + 0.5;
            
    
% ContactPoint on the XY plane    
elseif mod(iz, 1) ~= 0
    %find the closest vertex (forward)
    iz = iz + 0.5;
       
    %test for the location of the closest contactPoint (radius == 1) by adding the
    % corresponding displacement vectors to "ifvertex"
    fNorth = [ix, iy+0.5, iz];
    fSouth = [ix, iy-0.5, iz];    
    fEast  = [ix+0.5, iy, iz];
    fWest  = [ix-0.5, iy, iz];   
    fTop   = [ix, iy, iz+0.5];
        
    %compare the above 5 possible locations to all contactpoints to see if any is close
    Idxf = find(ismember(cp, vertcat(fNorth, fSouth, fEast, fWest, fTop), 'rows'));
  
    %move to the next closest vertex (forward)
    iz = iz + 0.5;
end


% Compute the distance btw current cp and the location of current vertex
Radiuscp(ncp,:) = sqrt( (cp(ncp, 1) - ix).^2 + (cp(ncp, 2) - iy).^2 + (cp(ncp, 3) - iz).^2 );



end


