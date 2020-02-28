function [ln,s,lFit,depVar,XptsAll] = fun_fitPlaneMinDist(cp, xpoints, avg)
%This function fits a plane through the contactpoint and all x-points



% Obtain x,y,z coordinates of the sets of xpoints
xPts = xpoints(:,1);
yPts = xpoints(:,2);
zPts = xpoints(:,3);

% Initialize ln and s
ln     = [NaN NaN NaN];
s      = [NaN];
lFit   = [NaN NaN NaN];
depVar = [];
XptsAll  = [NaN NaN NaN];

if length(xPts) < 2
    return;
end

% YZ plane (n,s,t,b)
if mod(cp(1), 1) ~= 0
    
    % compute the estimated direction of the plane, based on average normal vector
    alpha = atan2(-avg(:,2), avg(:,3));
      
    % rotate the coordinate system so that xp is collinear with estimated fit line
    calpha = cos(alpha);
    salpha = sin(alpha);
    
    xPtsRot = xPts;
    yPtsRot = yPts * calpha + zPts * salpha;
    zPtsRot = zPts * calpha - yPts * salpha;
    
    if ( all(isfinite(xPtsRot)) & all(isfinite(yPtsRot)) & all(isfinite(zPtsRot)) )
        [sf,gof,opt] = fit([xPtsRot,yPtsRot],zPtsRot, 'poly11');
        ap = sf.p10;
        bp = sf.p01;
        cp = sf.p00;
    else
        return;
    end
    
    if (alpha < -0.75 * pi || (alpha >= -0.25 * pi  && alpha < 0.25*pi) || alpha >= 0.75 * pi)
        % predominantly z(x,y)
        depVar = 'z';
        a = -ap / (bp*salpha - calpha);
        b = -(bp*calpha + salpha) / (bp*salpha - calpha);
        c = -cp / (bp*salpha - calpha);
        
        % compute normal vectors for the fitted plane
        dx = a;
        dy = b;
        dz = -1;    
    else
        % predominantly y(x,z)
        depVar = 'y';
        a = -ap / (bp*calpha + salpha);
        b = -(bp*salpha - calpha) / (bp*calpha + salpha);
        c = -cp / (bp*calpha + salpha);
        
        % compute normal vectors for the fitted plane
        dx = a;
        dy = -1;
        dz = b;
    end
    
      
    
    
% XZ plane (e,w,t,b)
elseif mod(cp(2), 1) ~= 0
    % compute the estimated direction of the plane, based on average normal vector
    alpha = atan2(-avg(:,1), avg(:,3));
      
    % rotate the coordinate system so that xp is collinear with estimated fit line
    calpha = cos(alpha);
    salpha = sin(alpha);
    
    xPtsRot = xPts * calpha - zPts * salpha;
    yPtsRot = yPts;
    zPtsRot = zPts * calpha + xPts * salpha;
    
    if ( all(isfinite(yPtsRot)) & all(isfinite(zPtsRot)) & all(isfinite(xPtsRot)) )
        [sf,gof,opt] = fit([yPtsRot,zPtsRot],xPtsRot, 'poly11');
        ap = sf.p10;
        bp = sf.p01;
        cp = sf.p00;
    else
        return
    end
    
    if (alpha < -0.75 * pi || (alpha >= -0.25 * pi  && alpha < 0.25*pi) || alpha >= 0.75 * pi)
        % predominantly x(y,z)
        depVar = 'x';
        a = -ap / (bp*salpha - calpha);
        b = -(bp*calpha + salpha) / (bp*salpha - calpha);
        c = -cp / (bp*salpha - calpha);
        
        % compute normal vectors for the fitted plane
        dx = -1;
        dy = a;
        dz = b;
    else
        % predominantly z(y,x)
        depVar = 'z';
        a = -ap / (bp*calpha + salpha);
        b = -(bp*salpha - calpha) / (bp*calpha + salpha);
        c = -cp / (bp*calpha + salpha);
        
        % compute normal vectors for the fitted plane
        dx = b;
        dy = a;
        dz = -1;
    end
    
      
    
% XY plane (n,s,e,w,)
elseif mod(cp(3), 1) ~= 0
    % compute the estimated direction of the plane, based on average normal vector
    alpha = atan2(-avg(:,1), avg(:,2));
      
    % rotate the coordinate system so that xp is collinear with estimated fit line
    calpha = cos(alpha);
    salpha = sin(alpha);
    
    xPtsRot = xPts * calpha + yPts * salpha;
    yPtsRot = yPts * calpha - xPts * salpha;
    zPtsRot = zPts;
    
    if ( all(isfinite(zPtsRot)) & all(isfinite(xPtsRot)) & all(isfinite(yPtsRot)) )
        [sf,gof,opt] = fit([zPtsRot,xPtsRot],yPtsRot, 'poly11');
        ap = sf.p10;
        bp = sf.p01;
        cp = sf.p00;
    else
        return
    end
    
    if (alpha < -0.75 * pi || (alpha >= -0.25 * pi  && alpha < 0.25*pi) || alpha >= 0.75 * pi)
        % predominantly y(z,x)
        depVar = 'y';
        a = -ap / (bp*salpha - calpha);
        b = -(bp*calpha + salpha) / (bp*salpha - calpha);
        c = -cp / (bp*salpha - calpha);
        
        % compute normal vectors for the fitted plane
        dx = b;
        dy = -1;
        dz = a;
        
    else
        % predominantly x(z,y)
        depVar = 'x';
        a = -ap / (bp*calpha + salpha);
        b = -(bp*salpha - calpha) / (bp*calpha + salpha);
        c = -cp / (bp*calpha + salpha);
        
        % compute normal vectors for the fitted plane
        dx = -1;
        dy = b;
        dz = a;
    end
end


% Obtain error estimate from the fitted plane
XptsAll = [xPtsRot, yPtsRot, zPtsRot];
lFit    = [a,b,c];
s       = gof.rmse;

% obtain the correct WS normal vector which points into the wetting phase
nw   = [dx, dy, dz];
[ln] = fun_confirm_normalDir(nw, avg);



end
