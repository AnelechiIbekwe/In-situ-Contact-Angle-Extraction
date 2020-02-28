function R1 = fun_obtainSearchRadiusR1(dg, Res, compType)
%This function computes the SearchRadius R1, for both the coarse and fine estimate 
%from the mean grain diamater and image resolution


% compute the nominal resolution
    NRes    = dg/Res;

    %coarse estimate
if compType == 0    
    R1      = -1.8E-05*(NRes^2) + 0.0264*NRes + 2.5488;
    
    %fine estimate
elseif compType == 1 
    R1      = 6.8418*exp(0.0009*NRes) - 5.8942*exp(-0.0148*NRes);
end


end