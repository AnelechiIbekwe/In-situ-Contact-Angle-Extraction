function fun_number_contactPoints(ncp, cp, SearchRadius)
%This function plots the contactPoints as well as serially numbers them.

%Plot search radius
% X       = cp(ncp, 1);
% Y       = cp(ncp, 2);
% centers = [X, Y];
% radii   = SearchRadius;
% viscircles(centers,radii, 'linewidth', 1);
% axis equal


%plot each contactPoint
plot(cp(ncp, 1), cp(ncp, 2), 'go', 'MarkerSize', 5, 'MarkerFaceColor', 'g' )  


%number each contactPoint
tx  = text(cp(ncp, 1), cp(ncp, 2), num2str(ncp),'Color','b');
set(tx, 'horizontalAlignment', 'right')
set(tx, 'VerticalAlignment', 'top')
tx.FontSize = 12;
tx.FontName = 'Arial';
tx.FontWeight = 'bold';







end