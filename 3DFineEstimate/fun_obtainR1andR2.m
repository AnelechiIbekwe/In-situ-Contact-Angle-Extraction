function [R1, R2] = fun_obtainR1andR2(dg, Res)
%This function computes the SearchRadius R1 and R2 for the fine estimate 
%from the mean grain diamater and image resolution


% compute the nominal resolution
NRes = dg/Res;

% estimate the SearchRadius R1
R1   = 6.8418*exp(0.0009*NRes) - 5.8942*exp(-0.0148*NRes);

% estimate the SearchRadius R2
R2   = 0.08141*NRes + 3.4782;


end



