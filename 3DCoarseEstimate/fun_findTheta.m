function theta = fun_findTheta(ns, nn, SMALL)

arg = dot(ns, nn) / norm(ns) / norm(nn);

if arg > 1.0 - SMALL && arg < 1.0 + SMALL
   theta = 180.0;
elseif arg > -1.0 - SMALL && arg < -1.0 + SMALL
   theta = 0.0;
else
   theta = 180.0 - acos(arg) * 180 / pi;
end

end


