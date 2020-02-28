function [lFit,depVar,eRR,ln] = fun_fitLine(cp, xpoints, avg_n)
%This function fits a line through  the WS X-points



xcp = cp(1);
ycp = cp(2);

xxp = xpoints(:,1)';
yxp = xpoints(:,2)';

xPts = [xcp, xxp];
yPts = [ycp, yxp];

% Initialize variables
lFit   = [NaN NaN];
depVar = [];
eRR    = [NaN];
ln     = [NaN NaN];

% compute the estimated direction of the fit line, based on average normal vector
alpha = atan2(-avg_n(:,1), avg_n(:,2));

% rotate the coordinate system so that xp is collinear with estimated fit line
calpha = cos(alpha);
salpha = sin(alpha);

xPtsRot = xPts * calpha + yPts * salpha;
yPtsRot = yPts * calpha - xPts * salpha;

if length(xpoints)<3
    return;
end

if ( all(isfinite(xPtsRot)) & all(isfinite(yPtsRot)) )
    [sf,gof,opt] = fit(xPtsRot', yPtsRot', 'poly1');
    ap = sf.p1;
    bp = sf.p2;
else
    return;
end


if (alpha < -0.75 * pi || (alpha >= -0.25 * pi  && alpha < 0.25*pi) || alpha >= 0.75 * pi)
    % predominantly y(x)
    depVar = 'y';
    a = (salpha + ap * calpha) / (calpha - ap * salpha);
    b = bp / (calpha - ap * salpha);
    
else
    % predominantly x(y)
    depVar = 'x';
    a = (calpha - ap * salpha) / (salpha + ap * calpha);
    b = - bp / (salpha + ap * calpha);
end

% Obtain error estimate from the fitted plane
lFit = [a, b];
eRR  = gof.rmse;

ln = fun_WSnormal(lFit, depVar, avg_n);

end
