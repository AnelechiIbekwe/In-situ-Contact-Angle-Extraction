function [avg_ns,avg_nn,nws,nwn,errS,errN] = fun_SearchContactPoints(ncp,cp,nsa,nna,Zxpoints,Zxpointn,edgeCoords,contactPoints,R2)
     

%<-- Initialize normal vectors from plane-fitting
 nws  = [NaN NaN NaN];
 nwn  = [NaN NaN NaN];
 errS = NaN;
 errN = NaN;

%<-- Transpose zxpoints to make it same size as nsa
Zxpoints = Zxpoints';
Zxpointn = Zxpointn';

%<-- Initialize the closecpIdx (i.e. Indices of all found contactPoint neighbours)
closecpIdx = [];


% Obtain the coordinates of the current contactpoint
[ix, iy, iz] = fun_get_ixiyiz_from_inode(edgeCoords, contactPoints(ncp));


%%%%%%%%%%%%%%%%%%% Track contactPoint neighbours (FORWARD)
%<-- FInd all connected contactpoints that are forward of the current contactPoint
[Idxf, Radiuscp, ixf, iyf, izf] = track_cpforward(ncp, cp, ix, iy, iz);

%<-- Collate the indices of neighbouring contactpoints
closecpIdx = [closecpIdx; [Idxf]];

while Radiuscp(ncp,:) < R2
    %find the closest vertices to current cp and then exit at the end of the search
    [Idxf, Radiuscp, ixf, iyf, izf] = track_cpforward(ncp, cp, ixf, iyf, izf);
    
    %stop loop if no neighbouring contactpoint is found 
    if (isempty(Idxf))
        break;
    end
    
    %collate the indices of neighbouring contactpoints
    closecpIdx = [closecpIdx; [Idxf]];
end


%%%%%%%%%%%%%%%%%%% Track contactPoint neighbours (BACKWARD)
%<-- FInd all connected contactpoints that are backward of the current contactPoint
[Idxb, Radiuscp, ixb, iyb, izb] = track_cpbackward(ncp, cp, ix, iy, iz);

%<-- Collate the indices of neighbouring contactpoints
closecpIdx = [closecpIdx; [Idxb]];

while Radiuscp(ncp,:) < R2
    %find the closest vertices to cp and then exit at the end of the search
    [Idxb, Radiuscp, ixb, iyb, izb] = track_cpbackward(ncp, cp, ixb, iyb, izb);
    
    %stop loop if no neighbouring contactpoint is found
    if (isempty(Idxb))
        break;
    end
    
    %collate the indices of neighbouring contactpoints
    closecpIdx = [closecpIdx; [Idxb]];
end



%<-- Compute average normal vectors for each surface
[avg_ns, avg_nn] = obtain_AvgNormalVectors(ncp, nsa, nna, closecpIdx);

%<-- Collate X-point coordinates for both WS and WN surfaces
[xs,ys,zs, xn,yn,zn] = xpointcoords_collation(ncp, closecpIdx, nsa, nna, Zxpoints, Zxpointn);

%<-- Obtain matrix of WS and WN X-point coordinates required to fit planes
XPs = [xs,ys,zs];
XPn = [xn,yn,zn];

%<-- Fit planes (Unconstrained) thru the X-points of each cp and those of its found neighbours
if ( isempty(XPs) | isempty(XPn) )
    return;

elseif all(isfinite(XPs))
    [nws,errS, ~, ~, ~] = fun_fitPlaneMinDist(cp(ncp,:), XPs, avg_ns);
    [nwn,errN, ~, ~, ~] = fun_fitPlaneMinDist(cp(ncp,:), XPn, avg_nn);
    
end


%<-- Empty the closecpIdx storage to avoid adding them up to the next iteration
closecpIdx = [];


end

