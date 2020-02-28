function n = fun_WSnormal(Lfit, dep, navg)


a = Lfit(1);
b = Lfit(2);

switch dep
    case 'y'   % fitted line y(x) 
        Gws   = [0, b];
        Hws   = [-b/a, 0];
        VecWS = Hws - Gws;
        
        % compute the WS normal vector
        nw    = [-VecWS(2),   VecWS(1)];
        
    case 'x'   % fitted line x(y)
        Gws   = [0, -b/a];
        Hws   = [b, 0];
        VecWS = Hws - Gws;
        
        % compute the WS normal vector
        nw    = [-VecWS(2),   VecWS(1)];

    otherwise
        nw   = [NaN NaN];
        'Error in compute_n_to_line'
end




% obtain the correct WS normal vector which points into the wetting phase 
n = fun_confirmNormalDirection(nw, navg);

end