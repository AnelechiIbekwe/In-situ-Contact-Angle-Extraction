function [contactPoints, cp, Allvectors] = fun_findcontactpoints(Allvectors, edgeCoords)


%<-- Invalidate nodes w/o NaNs(i.e. nodes that contains only S and N normal vectors)
%as well as nodes with multiple faces 
for inode = 1: size(Allvectors, 1)
    [Allvectors] = fun_invalidate_nodes(inode, Allvectors);
end

%<-- Determine the contactpoint nodes (or locations)
contactPoints = find(( any(strcmp('S+', Allvectors),2) | any(strcmp('S-', Allvectors),2)) & (any(strcmp('N+', Allvectors),2) | any(strcmp('N-', Allvectors),2)));

%find the coordinates of the contactpoints
cp = edgeCoords(contactPoints,:);
end