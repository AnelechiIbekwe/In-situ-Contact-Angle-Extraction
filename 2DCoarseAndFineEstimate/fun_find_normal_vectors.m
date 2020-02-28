function [n, s, e, w] = fun_find_normal_vectors(iy, ix, P)
%This function determines if a normal vector exists at the north, south,
%east and western faces around each node. 
%
%
% If a normal vector exists at any of these faces; 
% the function determines if it is an 'N+', 'N-', 'S+', or an 'S-' normal vector
%
% Where '+/-' is for positive or negative x or y-direction, and 
% 'N' or 'S' tells if it is a normal vector resulting from a Non-wetting or Solid interface.
%
%
% Note: 
% P      = input image
% ix, iy = x and y coordinate of each node, respectively,
% 'W'    = Wetting phase
% 'N'    = Non-wetting phase
% 'S'    = Solid phase
 




% Initialize the normal vector at each face
n = NaN; s = NaN; e = NaN; w = NaN;


if ( (iy+1 > size(P, 1)) || (ix+1 > size(P, 2)) )
    return;
end

%# NORTH FACE
if P(iy, ix + 1) == 'W'
    if P(iy, ix) == 'S'
        n = 'S+';
    elseif P(iy, ix) == 'N'
        n = 'N+';
    end
elseif P(iy, ix) == 'W'
    if P(iy, ix + 1) == 'S'
        n = 'S-';
    elseif P(iy, ix + 1) == 'N'
        n = 'N-';
    end
end


%# SOUTH FACE
if P(iy + 1, ix + 1) == 'W'
    if P(iy + 1, ix) == 'S'
        s = 'S+';
    elseif P(iy + 1, ix) == 'N'
        s = 'N+';
    end
elseif P(iy + 1, ix) == 'W'
    if P(iy + 1, ix + 1) == 'S'
        s = 'S-';
    elseif P(iy + 1, ix + 1) == 'N'
        s = 'N-';
    end
end


%# EAST FACE
if P(iy + 1, ix + 1) == 'W'
    if P(iy, ix + 1) == 'S'
        e = 'S+';
    elseif P(iy, ix + 1) == 'N'
        e = 'N+';
    end
elseif P(iy, ix + 1) == 'W'
    if P(iy + 1, ix + 1) == 'S'
        e = 'S-';
    elseif P(iy + 1, ix + 1) == 'N'
        e = 'N-';
    end
end


%# WEST FACE
if P(iy + 1, ix) == 'W'
    if P(iy, ix) == 'S'
        w = 'S+';
    elseif P(iy, ix) == 'N'
        w = 'N+';
    end
elseif P(iy, ix) == 'W'
    if P(iy + 1, ix) == 'S'
        w = 'S-';
    elseif P(iy + 1, ix) == 'N'
        w = 'N-';
    end
end





end