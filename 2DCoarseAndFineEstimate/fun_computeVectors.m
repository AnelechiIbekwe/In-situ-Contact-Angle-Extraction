function [nws, nwn] = fun_computeVectors(ncp, LfitS, LfitN, avg_ns, avg_nn)

% Compute WS & WN vector
Gws = [0, LfitS(ncp, 2)]; Hws   = [-(LfitS(ncp, 2)/LfitS(ncp, 1)), 0];
VectorWS = Hws - Gws;

Gwn = [0, LfitN(ncp, 2)]; Hwn   = [-(LfitN(ncp, 2)/LfitN(ncp, 1)), 0];
VectorWN = Hwn - Gwn;

% Compute the WS & WN normal vectors 
nws  = [-VectorWS(2),   VectorWS(1)];
nwn  = [-VectorWN(2),   VectorWN(1)];


% Obtain the correct wetting phase direction for both lines by comparing
%with average normal vectors from avg_ns and avg_nn
[nws, nwn] = fun_confirmNormalDirection(nws, nwn, avg_ns, avg_nn);



end