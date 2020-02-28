function [avg_norm, xpoint] = fun_findXpoints(phase, ncp, gridCoords, cp, inode_in, nx, contactPoints, R1finePix, minR, Allvectors)




%initialize temporary cell arrays to store the interface
xpointArbitraryCell = cell(numel(contactPoints), 4);
%initialize normal vectors for the interface
ns = [];
%initialize Xpoints for the WS interfacew
xpoint    = [NaN NaN];
avg_norm  = [NaN NaN];


%<-- find the next Node from the previous
[Allvectors, xpointArbitraryCell, inode_in, nsy, nsx, Radius] = fun_findNextnode(phase, ncp, gridCoords,cp, inode_in, nx, xpointArbitraryCell, Allvectors);

if ( isnan(Radius(ncp,:)) | isnan(nsy(ncp,:)) | isnan(nsx(ncp,:)) )
    return;
end


%collate XPoints coordinates for the interface
[old_ix, old_iy]         = fun_get_ixiy_from_inode(gridCoords,contactPoints(ncp));
[current_ix, current_iy] = fun_get_ixiy_from_inode(gridCoords, inode_in(ncp));
xpoint                   = [(old_ix + current_ix)/2 (old_iy + current_iy)/2];
old_ix                   = current_ix;
old_iy                   = current_iy;

%If no face is found at the next node then move to the next iteration
if ( (isempty(nsy) & isempty(nsx)) | (isnan(nsy) & isnan(nsx)) )
    return;
end

%collate normal vectors for the interface
ns = [ns; [nsx(ncp), nsy(ncp)]];

%find all nodes within the specified search radius of the contactpoint
while Radius(ncp,:) < R1finePix
    
    %find the next node and then exit at the end of the search
    [Allvectors, xpointArbitraryCell, inode_in, nsy, nsx, Radius] = fun_findNextnode(phase, ncp, gridCoords,cp, inode_in, nx, xpointArbitraryCell, Allvectors);
    
    %break loopif no face is found at the next node
    if ( (isempty(nsy) & isempty(nsx)) | (isnan(nsy) & isnan(nsx)) )
        ns = [NaN NaN];
        break;
    end
    
    %collate normal vectors for the interface
    ns = [ns; [nsx(ncp), nsy(ncp)]];
    
    %collate XPoints coordinates for the interface
    [current_ix, current_iy] = fun_get_ixiy_from_inode(gridCoords, inode_in(ncp));
    xpoint                   = [xpoint; (old_ix + current_ix)/2 (old_iy + current_iy)/2];
    old_ix                   = current_ix;
    old_iy                   = current_iy;
end


%Check if the last row of xpoints has exceeded the SearchRadius
if sqrt( (cp(ncp, 1) - xpoint(end,1)).^2 + (cp(ncp, 2) - xpoint(end,2)).^2 ) > R1finePix
    xpoint(end,:) = [];    %exclude the last row of xpointn from the stored xpointn
    ns(end,:)     = [];    %exclude the last row of nn from the stored nn
elseif Radius(ncp,:) < minR  % exclude all if the final radus is < 1.5 pixel because these point are from the same W pixel
   return;
end

%compute average normal vectors
if all(isfinite(ns))
    avg_norm = [mean(ns(:,1)), mean(ns(:,2))];
end

%empty inode_in for the next iteration
inode_in = [];


end