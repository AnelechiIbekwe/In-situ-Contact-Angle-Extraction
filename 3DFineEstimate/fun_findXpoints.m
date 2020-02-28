function [ns, xpoint] = fun_findXpoints(phase, ncp, edgeCoords, cp, inode_in, nx, ny,contactPoints, R1finePix, minR, Allvectors)




%initialize temporary cell arrays to store the interface
xpointArbitraryCell = cell(numel(contactPoints), 6);
%initialize normal vectors for the interface
ns = [];
%initialize Xpoints for the WS interfacew
xpoint    = [];
  


%<-- find the next Node from the previous
[Allvectors, xpointArbitraryCell, inode_in, nsx, nsy, nsz, Radius] = fun_findNextnode(phase, ncp, edgeCoords,cp, inode_in, nx, ny, xpointArbitraryCell, Allvectors);
      
if ( isnan(Radius(ncp,:)) | isnan(nsx(ncp,:)) | isnan(nsy(ncp,:) | isnan(nsz(ncp,:))) )
    return;
end

%collate XPoints coordinates for the interface
[old_ix, old_iy, old_iz]             = fun_get_ixiyiz_from_inode(edgeCoords, contactPoints(ncp));
[current_ix, current_iy, current_iz] = fun_get_ixiyiz_from_inode(edgeCoords, inode_in(ncp));
xpoint                               = [xpoint; (old_ix + current_ix)/2, (old_iy + current_iy)/2, (old_iz + current_iz)/2];
old_ix                               = current_ix;
old_iy                               = current_iy;
old_iz                               = current_iz;

%If no face is found at the next node then move to the next iteration
if ( (isempty(nsx) & isempty(nsy) & isempty(nsz)) | (isnan(nsx) & isnan(nsy) & isnan(nsz)) )
    return;
end

%collate normal vectors for the interface
ns = [ns; [nsx(ncp), nsy(ncp), nsz(ncp)]];

%find all nodes within the specified search radius of the contactpoint
while Radius(ncp,:) < R1finePix
    
    %find the next node and then exit at the end of the search
    [Allvectors, xpointArbitraryCell, inode_in, nsx, nsy, nsz, Radius] = fun_findNextnode(phase, ncp, edgeCoords,cp, inode_in, nx, ny, xpointArbitraryCell, Allvectors);
    
    %break loopif no face is found at the next node
    if ( (isempty(nsx) & isempty(nsy) & isempty(nsz)) | (isnan(nsx) & isnan(nsy) & isnan(nsz)) )
        ns = [NaN NaN NaN];
        break;
    end
    
    %collate normal vectors for the interface
    ns = [ns; [nsx(ncp), nsy(ncp), nsz(ncp)]];
    
    %collate XPoints coordinates for the interface
    if inode_in(ncp) < 0 
        return;
    end
    [current_ix, current_iy, current_iz] = fun_get_ixiyiz_from_inode(edgeCoords, inode_in(ncp));
    xpoint                               = [xpoint; (old_ix + current_ix)/2, (old_iy + current_iy)/2, (old_iz + current_iz)/2];
    old_ix                               = current_ix;
    old_iy                               = current_iy;
    old_iz                               = current_iz;
end


%Check if the last row of xpoints has exceeded the SearchRadius
if sqrt( (cp(ncp, 1) - xpoint(end,1)).^2 + (cp(ncp, 2) - xpoint(end,2)).^2 + (cp(ncp, 3) - xpoint(end,3)).^2 ) > R1finePix
    xpoint(end,:) = [];    %exclude the last row of xpointn from the stored xpointn
    ns(end,:)     = [];    %exclude the last row of nn from the stored nn
elseif Radius(ncp,:) < minR  % exclude all if the final radus is < 1.5 pixel because these point are from the same W pixel
    xpoint    = [NaN NaN NaN];
    ns        = [NaN NaN NaN];
end


%empty inode_in for the next iteration
inode_in = [];


end