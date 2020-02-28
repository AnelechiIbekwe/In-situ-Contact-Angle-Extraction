function[nsy, nsx] = fun_collateNormalVectors(phase, ncp, xpointArbitraryCell)
%This function collates the normal vector components for each x-point
%it returns the average unit normal vector of the solid phase for all x-points



Ppls = [phase, '+'];
Pmin = [phase, '-'];

nsy(ncp,:) = NaN;  
nsx(ncp,:) = NaN;  


if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 1) == true    %# positive normal direction @north face
    nsy(ncp,:) = 0;
    nsx(ncp,:) = 1;
elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 1) == true
    nsy(ncp,:) = 0;
    nsx(ncp,:) = -1;
end


if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 2) == true    %# positive normal direction @south face
    nsy(ncp,:) = 0;
    nsx(ncp,:) = 1;
elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 2) == true
    nsy(ncp,:) = 0;
    nsx(ncp,:) = -1;
end


if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 3) == true    %# positive normal direction @east face
    nsy(ncp,:) = 1;
    nsx(ncp,:) = 0;
elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 3) == true
    nsy(ncp,:) = -1;
    nsx(ncp,:) = 0;
end


if (find(strcmp(Ppls, xpointArbitraryCell(ncp,:)) ) == 4) == true    %# positive normal direction @west face
    nsy(ncp,:) = 1;
    nsx(ncp,:) = 0;
elseif (find(strcmp(Pmin, xpointArbitraryCell(ncp,:)) ) == 4) == true
    nsy(ncp,:) = -1;
    nsx(ncp,:) = 0;
end






end








