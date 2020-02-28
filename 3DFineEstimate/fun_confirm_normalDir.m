function [normVec] = fun_confirm_normalDir(nw, avg)
%This function confirms the direction of the normal vector of the fitted
%WS and WN surfaces by comparing each component with that obtained from the
%average normal vector

dx = nw(1);
dy = nw(2);
dz = nw(3);


if ( sign(dx) == sign(avg(1)) ) && ( sign(dy) == sign(avg(2)) ) && ( sign(dz) ~= sign(avg(3)) )
    dz = -1 * dz;       
elseif ( sign(dx) == sign(avg(1)) ) && ( sign(dy) ~= sign(avg(2)) ) && ( sign(dz) == sign(avg(3)) )
    dy = -1*dy;  
elseif ( sign(dx) ~= sign(avg(1)) ) && ( sign(dy) == sign(avg(2)) ) && ( sign(dz) == sign(avg(3)) )
    dx = -1*dx;
elseif ( sign(dx) ~= sign(avg(1)) ) && ( sign(dy) ~= sign(avg(2)) ) && ( sign(dz) == sign(avg(3)) )
    dx = -1*dx;
    dy = -1*dy;
elseif ( sign(dx) ~= sign(avg(1)) ) && ( sign(dy) == sign(avg(2)) ) && ( sign(dz) ~= sign(avg(3)) )
    dx = -1*dx;
    dz = -1*dz; 
elseif ( sign(dx) == sign(avg(1)) ) && ( sign(dy) ~= sign(avg(2)) ) && ( sign(dz) ~= sign(avg(3)) )
    dy = -1*dy;
    dz = -1*dz; 
elseif  ( sign(dx) ~= sign(avg(1)) ) && ( sign(dy) ~= sign(avg(2)) ) && ( sign(dz) ~= sign(avg(3)) )
    dx = -1*dx;
    dy = -1*dy;
    dz = -1*dz;     
end


% Correct normal vectors of the surface
normVec = [dx, dy, dz];


end