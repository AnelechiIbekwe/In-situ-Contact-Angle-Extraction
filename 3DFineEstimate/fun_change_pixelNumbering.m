function [P] = fun_change_pixelNumbering(P)
% This function changes pixel labels such that: 
% 2 is assigned as 3 (Solid phase), 
% 0 is assigned as 2 (Wetting phase),
% 1 remains as it is (Non-wetting phase)
% 
%
% Where: 'N' = Non-wetting phase, 'W' = Wetting phase, and 'S' = Solid phase
 
for ii = 1:numel(P)
    if P(ii) == 2       % Solid phase
        P(ii) = 3; 
    elseif P(ii) == 0   % Wetting phase
        P(ii) = 2;
    end
     
 end



end