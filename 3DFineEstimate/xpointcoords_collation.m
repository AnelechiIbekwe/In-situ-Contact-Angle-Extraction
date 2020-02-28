function [xs,ys,zs, xn,yn,zn] = xpointcoords_collation(ncp, closecpIdx, nsa, nna, Zxpoints, Zxpointn)
%This function collates the X-points coordinates of each WS and WN surfaces
%as well as plots the quivers for both WS and WN planes of each contactpoint and its neighbours (closecpIdx)
%
% x,y,and z = coordinates of points required to fit the plane for each contactpoint



%Initialize x,y,z for both WS and WN surfaces
xs = []; ys = []; zs = [];
xn = []; yn = []; zn = [];


for ii = 1: numel(closecpIdx)
%// extract the coordinates of x,y,z (from Zxpoints & Zxpointn) for the found closecpIdx
if ( isempty(nsa{closecpIdx(ii),:}) | isempty(nna{closecpIdx(ii),:}) | (closecpIdx(ii) == 0) | (closecpIdx(ii) == []) )
    return;
else
xs = [xs; [Zxpoints{closecpIdx(ii),:}(:,1)]];
ys = [ys; [Zxpoints{closecpIdx(ii),:}(:,2)]];
zs = [zs; [Zxpoints{closecpIdx(ii),:}(:,3)]];

xn = [xn; [Zxpointn{closecpIdx(ii),:}(:,1)]];
yn = [yn; [Zxpointn{closecpIdx(ii),:}(:,2)]];
zn = [zn; [Zxpointn{closecpIdx(ii),:}(:,3)]];


% Plot normal vectors for the contactpoint neighbours (all found closecpIdx)
% quiver3(Zxpoints{closecpIdx(ii),:}(:,1), Zxpoints{closecpIdx(ii),:}(:,2), Zxpoints{closecpIdx(ii),:}(:,3),...
%     nsa{closecpIdx(ii),:}(:,1), nsa{closecpIdx(ii),:}(:,2), nsa{closecpIdx(ii),:}(:,3), 0, 'color','b', 'MaxHeadSize',1, 'linewidth',1)
 
% quiver3(Zxpointn{closecpIdx(ii),:}(:,1), Zxpointn{closecpIdx(ii),:}(:,2), Zxpointn{closecpIdx(ii),:}(:,3),...
%     nna{closecpIdx(ii),:}(:,1), nna{closecpIdx(ii),:}(:,2), nna{closecpIdx(ii),:}(:,3), 0, 'color','r', 'MaxHeadSize',1, 'linewidth',1)

end


% Plot normal vectors for the current contactpoint
% quiver3(Zxpoints{ncp,:}(:,1), Zxpoints{ncp,:}(:,2), Zxpoints{ncp,:}(:,3),...
%     nsa{ncp,:}(:,1), nsa{ncp,:}(:,2), nsa{ncp,:}(:,3), 0, 'color','b', 'MaxHeadSize',1, 'linewidth',1)
 
% quiver3(Zxpointn{ncp,:}(:,1), Zxpointn{ncp,:}(:,2), Zxpointn{ncp,:}(:,3),...
%     nna{ncp,:}(:,1), nna{ncp,:}(:,2), nna{ncp,:}(:,3), 0, 'color','r', 'MaxHeadSize',1, 'linewidth',1)


% Obtain final coordinates of x,y,z for each WS and WN planes
xs = [Zxpoints{ncp}(:,1); xs];  xn = [Zxpointn{ncp}(:,1); xn];
ys = [Zxpoints{ncp}(:,2); ys];  yn = [Zxpointn{ncp}(:,2); yn];
zs = [Zxpoints{ncp}(:,3); zs];  zn = [Zxpointn{ncp}(:,3); zn];


end
