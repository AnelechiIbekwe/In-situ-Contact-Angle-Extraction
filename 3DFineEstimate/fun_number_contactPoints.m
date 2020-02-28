function fun_number_contactPoints(ncp, cp, SearchRadius)
%This function plots the contactPoints as well as serially numbers them.

%plot search radius% [azi, elev] = meshgrid(linspace(0, pi, 30), linspace(0, 2*pi, 40));
% X = SearchRadius*sin(azi).* cos(elev);
% Y = SearchRadius*sin(azi).* sin(elev);
% Z = SearchRadius*cos(azi);
% h = mesh((X+cp(ncp, 1)), (Y+cp(ncp, 2)), (Z+cp(ncp, 3)));
% h.FaceAlpha = 0.35;
% axis equal;
% axis tight;


%plot each contactPoint
plot3(cp(ncp, 1), cp(ncp, 2), cp(ncp, 3), 'go', 'MarkerSize', 5, 'MarkerFaceColor', 'g' )  


%number each contactPoint
% tx  = text(cp(ncp, 1), cp(ncp, 2), cp(ncp, 3), num2str(ncp),'Color','r');
% set(tx, 'horizontalAlignment', 'right')
% set(tx, 'VerticalAlignment', 'top')
% tx.FontSize = 10;
% tx.FontName = 'Arial';
% tx.FontWeight = 'normal';






end