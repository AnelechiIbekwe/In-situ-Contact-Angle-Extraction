function [P] = fun_change_to_numeric(P)
% This function changes pixel labels from logical to numeric
% such that: 0 is assigned as 2 (wetting phase), 1 is assigned as 1
% (non-wetting phase)

% Where: 
% 'N' = Non-wetting phase, 
% 'W' = Wetting phase, and 
% 'S' = Solid phase
 

for ii = 1:numel(P)
    if P(ii) == 0
        P(ii) = 2;
    end
     
 end



end