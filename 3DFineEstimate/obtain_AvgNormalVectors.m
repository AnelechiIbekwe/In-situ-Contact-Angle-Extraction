function [avg_ns, avg_nn] = obtain_AvgNormalVectors(ncp, nsa, nna, closecpIdx)
%This function obtains the sum of each normal vector components (of both WS and WN surfaces) 
%of all found contactpoints neighbours.
%
%It then computes the average normal vector of each WS and WN surfaces.




% Initialize storage for sum of each normal vector comp.
getsumS = [NaN NaN NaN];   
getsumN = [NaN NaN NaN];  

% Compute sum of each normal vector component of CP neighbours
for ii = 1: numel(closecpIdx)
    %Check if no CP neighbour is found OR no normal vector exists at any CP neighbour
    if ( isempty(nsa{closecpIdx(ii),:}) | isempty(nna{closecpIdx(ii),:}) | (closecpIdx(ii) == []) | (closecpIdx(ii) == 0) )
        avg_ns = [NaN NaN NaN]; avg_nn = [NaN NaN NaN];
        return;
    else
        %For each Interface, obtain the sum (component-by-component) of all normal vectors found at each CP neighbour
        getsumS(ii,:) = [sum(nsa{closecpIdx(ii),:}(:,1)), sum(nsa{closecpIdx(ii),:}(:,2)), sum(nsa{closecpIdx(ii),:}(:,3))];
        getsumN(ii,:) = [sum(nna{closecpIdx(ii),:}(:,1)), sum(nna{closecpIdx(ii),:}(:,2)), sum(nna{closecpIdx(ii,:)}(:,3))]; 
    end
end


% Compute Average normal vectors (by adding the comps. of the above to those of the current contactPoint)
if ( isempty(nsa{ncp,:}) | isempty(nna{ncp,:}) )
    avg_ns = [NaN NaN NaN]; avg_nn = [NaN NaN NaN];
    return;
elseif ( isfinite(getsumS) & isfinite(getsumN) )
    avg_ns = [sum(nsa{ncp,:}(:,1))+sum(getsumS(:,1)), sum(nsa{ncp,:}(:,2))+sum(getsumS(:,2)), sum(nsa{ncp,:}(:,3))+sum(getsumS(:,3))]/( size(nsa{ncp,:},1) + size(getsumS,1) );
    avg_nn = [sum(nna{ncp,:}(:,1))+sum(getsumN(:,1)), sum(nna{ncp,:}(:,2))+sum(getsumN(:,2)), sum(nna{ncp,:}(:,3))+sum(getsumN(:,3))]/( size(nna{ncp,:},1) + size(getsumN,1) );
else
    avg_ns = [NaN NaN NaN]; avg_nn = [NaN NaN NaN];
end






end


 


