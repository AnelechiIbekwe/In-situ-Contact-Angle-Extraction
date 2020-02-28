function [P] = fun_change_pixel_labels(P)
% This function changes pixel labels from numeric (0,1,2,3, 0r 4) to characters
% (N, W, S)

% such that: 0, 1, 2, 3, or 4 are phases labelled from the segmented image
% Where:
% 'N' = Non-wetting phase
% 'W' = Wetting phase, and
% 'S' = Solid phase


% POSSIBLE CASES
%ind==2, we have input image segmented as: 0 1 2    (min=0, max=2)
%ind==3, we have input image segmented as: 0 1 2 3  (min=0, max=3)
%ind==4, we have input image segmented as: 1 2 3    (min=1, max=3)
%ind==5, we have input image segmented as: 1 2 3 4  (min=1, max=4)
%ind==6, we have input image segmented as: 2 3 4    (min=2, max=4)

ind2 = min(P(1:end));
ind1 = max(P(1:end));
ind  = ind1 + ind2;

for ii = 1:numel(P)
    switch ind % we have 3 segmented phases labelled as 0,1,2
        case 2
            if P(ii) == 0
                P(ii) = 'N';
            elseif P(ii) == 1
                P(ii) = 'W';
            elseif P(ii) == 2
                P(ii) = 'S';
            end
        case 3  % we have 4 segmented phases labelled as 0,1,2,3
            if P(ii) == 1
                P(ii) = 'N';
            elseif P(ii) == 2
                P(ii) = 'W';
            elseif P(ii) == 3
                P(ii) = 'S';
            end
        case 4  % we have 3 segmented phases labelled as 1,2,3
            if P(ii) == 1
                P(ii) = 'N';
            elseif P(ii) == 2
                P(ii) = 'W';
            elseif P(ii) == 3
                P(ii) = 'S';
            end
        case 5  % we have 4 segmented phases labelled as 1,2,3,4
            if P(ii) == 2
                P(ii) = 'N';
            elseif P(ii) == 3
                P(ii) = 'W';
            elseif P(ii) == 4
                P(ii) = 'S';
            end
        case 6 % we have 3 segmented phases labelled as 2,3,4
            if P(ii) == 2
                P(ii) = 'N';
            elseif P(ii) == 3
                P(ii) = 'W';
            elseif P(ii) == 4
                P(ii) = 'S';
            end
    end
    
end

end