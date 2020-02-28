function R1 = fun_obtainR1(dg, Res)
%This function computes the SearchRadius R1, for the coarse estimate 
%from the mean grain diamater and image resolution


% compute the nominal resolution
NRes    = dg/Res;

% estimate the SearchRadius R1
R1      = -1.8E-05*(NRes^2) + 0.0264*NRes + 2.5488;


end