function [n, s, e, w, t, b] = fun_find_normal_vectors(ix, iy, iz, P)
%This function determines if a normal vector exists at the north, south,
% east, west, top and bottom faces around each edge. 
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
% ix, iy, iz = x, y, and z coordinate of each edge(or node), respectively,
% 'W'    = Wetting phase
% 'N'    = Non-wetting phase
% 'S'    = Solid phase
 




% Initialize the normal vector at each face
n = NaN; s = NaN; e = NaN; w = NaN; t = NaN; b = NaN;

if ( (ix+1 > size(P, 1)) || (iy+1 > size(P, 2)) || (iz+1 > size(P, 3)) )
    return;
end

%%%%%%%%%%%%%%%%%%%% YZ Plane (n, s, t, b)
if mod(ix, 1) ~= 0
    ix = ix + 0.5;
    
    %# NORTH FACE (YZ)
    if P(ix, iy+1, iz + 1) == 'W'
        if P(ix, iy+1, iz) == 'S'
            n = 'S+';
        elseif P(ix, iy+1, iz) == 'N'
            n = 'N+';
        end
    elseif P(ix, iy+1, iz) == 'W'
        if P(ix, iy+1, iz + 1) == 'S'
            n = 'S-';
        elseif P(ix, iy+1, iz + 1) == 'N'
            n = 'N-';
        end
    end
    
    
    %# SOUTH FACE (YZ)
    if P(ix, iy, iz+1) == 'W'
        if P(ix, iy, iz) == 'S'
            s = 'S+';
        elseif P(ix, iy, iz) == 'N'
            s = 'N+';
        end
    elseif P(ix, iy, iz) == 'W'
        if P(ix, iy, iz+1) == 'S'
            s = 'S-';
        elseif P(ix, iy, iz+1) == 'N'
            s = 'N-';
        end
    end
    
    
    
    %# TOP FACE (YZ)
    if P(ix, iy+1, iz + 1) == 'W'
        if P(ix, iy, iz+1) == 'S'
            t = 'S+';
        elseif P(ix, iy, iz+1) == 'N'
            t = 'N+';
        end
    elseif P(ix, iy, iz+1) == 'W'
        if P(ix, iy+1, iz + 1)  == 'S'
            t = 'S-';
        elseif P(ix, iy+1, iz + 1) == 'N'
            t = 'N-';
        end
    end
    
    
    %# BOTTOM FACE (YZ)
    if P(ix, iy+1, iz) == 'W'
        if P(ix, iy, iz) == 'S'
            b = 'S+';
        elseif P(ix, iy, iz) == 'N'
            b = 'N+';
        end
    elseif P(ix, iy, iz) == 'W'
        if P(ix, iy+1, iz) == 'S'
            b = 'S-';
        elseif P(ix, iy+1, iz) == 'N'
            b = 'N-';
        end
    end
end







%%%%%%%%%%%%%%%%%%%% XZ Plane (e, w, t, b)
if mod(iy, 1) ~= 0
    iy = iy + 0.5;
    
    %# EAST FACE (XZ)
    if P(ix+1, iy, iz+1) == 'W'
        if P(ix+1, iy, iz) == 'S'
            e = 'S+';
        elseif P(ix+1, iy, iz) == 'N'
            e = 'N+';
        end
    elseif P(ix+1, iy, iz) == 'W'
        if P(ix+1, iy, iz+1) == 'S'
            e = 'S-';
        elseif P(ix+1, iy, iz+1) == 'N'
            e = 'N-';
        end
    end
    
    
    %# WEST FACE (XZ)
    if P(ix, iy, iz + 1) == 'W'
        if P(ix, iy, iz) == 'S'
            w = 'S+';
        elseif P(ix, iy, iz) == 'N'
            w = 'N+';
        end
    elseif P(ix, iy, iz) == 'W'
        if P(ix, iy, iz + 1) == 'S'
            w = 'S-';
        elseif P(ix, iy, iz + 1) == 'N'
            w = 'N-';
        end
    end
    
    
    %# TOP FACE (XZ)
    if P(ix+1, iy, iz+1) == 'W'
        if P(ix, iy, iz+1) == 'S'
            t = 'S+';
        elseif P(ix, iy, iz+1) == 'N'
            t = 'N+';
        end
    elseif P(ix, iy, iz+1) == 'W'
        if P(ix+1, iy, iz+1) == 'S'
            t = 'S-';
        elseif P(ix+1, iy, iz+1) == 'N'
            t = 'N-';
        end
    end
    
    
    %# BOTTOM FACE (XZ)
    if P(ix+1, iy, iz) == 'W'
        if P(ix, iy, iz) == 'S'
            b = 'S+';
        elseif P(ix, iy, iz) == 'N'
            b = 'N+';
        end
    elseif P(ix, iy, iz) == 'W'
        if P(ix+1, iy, iz) == 'S'
            b = 'S-';
        elseif P(ix+1, iy, iz) == 'N'
            b = 'N-';
        end
    end
end








%%%%%%%%%%%%%%%%%%%% XY Plane (n, s, e, w)
if mod(iz, 1) ~= 0
    iz = iz + 0.5;
    
     %# NORTH FACE (XY)
    if P(ix+1, iy+1, iz) == 'W'
        if P(ix, iy+1, iz) == 'S'
            n = 'S+';
        elseif P(ix, iy+1, iz) == 'N'
            n = 'N+';
        end
    elseif P(ix, iy+1, iz) == 'W'
        if P(ix+1, iy+1, iz) == 'S'
            n = 'S-';
        elseif P(ix+1, iy+1, iz) == 'N'
            n = 'N-';
        end
    end
    
    
    %# SOUTH FACE (XY)
    if P(ix+1, iy, iz) == 'W'
        if P(ix, iy, iz) == 'S'
            s = 'S+';
        elseif P(ix, iy, iz) == 'N'
            s = 'N+';
        end
    elseif P(ix, iy, iz) == 'W'
        if P(ix+1, iy, iz)== 'S'
            s = 'S-';
        elseif P(ix+1, iy, iz) == 'N'
            s = 'N-';
        end
    end
    
    %# EAST FACE (XY)
    if P(ix + 1, iy + 1, iz) == 'W'
        if P(ix + 1, iy, iz) == 'S'
            e = 'S+';
        elseif P(ix + 1, iy, iz) == 'N'
            e = 'N+';
        end
    elseif P(ix + 1, iy, iz) == 'W'
        if P(ix + 1, iy + 1, iz) == 'S'
            e = 'S-';
        elseif P(ix + 1, iy + 1, iz) == 'N'
            e = 'N-';
        end
    end
    
    
    %# WEST FACE (XY)
    if P(ix, iy + 1, iz) == 'W'
        if P(ix, iy, iz) == 'S'
            w = 'S+';
        elseif P(ix, iy, iz) == 'N'
            w = 'N+';
        end
    elseif P(ix, iy, iz) == 'W'
        if P(ix, iy + 1, iz) == 'S'
            w = 'S-';
        elseif P(ix, iy + 1, iz) == 'N'
            w = 'N-';
        end
    end
end




end