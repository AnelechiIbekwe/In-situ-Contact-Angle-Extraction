function [nw] = fun_confirmNormalDirection(nw, avg_n)
%This function confirms the direction of the normal vector of the fitted
%surface by comparing each component with that obtained from the average normal vector model




if ( sign(nw(1)) == sign(avg_n(1)) ) && ( sign(nw(2)) == sign(avg_n(2)) )
    nw(1) = nw(1);
    nw(2) = nw(2);
elseif ( sign(nw(1)) == sign(avg_n(1)) ) && ( sign(nw(2)) ~= sign(avg_n(2)) )
    nw(1) = nw(1);
    nw(2) = -1 * nw(2);
elseif ( sign(nw(1)) ~= sign(avg_n(1)) ) && ( sign(nw(2)) == sign(avg_n(2)) )
    nw(1) = -1 * nw(1);
    nw(2) = nw(2);
elseif ( sign(nw(1)) ~= sign(avg_n(1)) ) && ( sign(nw(2)) ~= sign(avg_n(2)) )
    nw(1) = -1 * nw(1);
    nw(2) = -1 * nw(2);
end


%// Correct normal vectors of the surface:
nw = [nw(1), nw(2)];

end