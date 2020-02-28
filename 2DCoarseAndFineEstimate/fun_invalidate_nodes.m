function[Allvectors] = fun_invalidate_nodes(inode, Allvectors)
%This function Invalidate nodes w/o NaNs(i.e. nodes that contains only S and N normal vectors) 
% as well as nodes with multiple faces (i.e. nodes that contains only S and N normal vectors)



%Invalidate nodes with multiple faces 
if (sum(strcmp('S+', Allvectors(inode,:))) + sum(strcmp('S-', Allvectors(inode,:)))) == 4 || (sum(strcmp('N+', Allvectors(inode,:))) + sum(strcmp('N-', Allvectors(inode,:)))) == 4   
    Allvectors(inode, :) = {NaN};   %invalidate all faces at that node with NaNs
end


%Invalidate nodes w/o NaNs 
if (sum(strcmp('S+', Allvectors(inode,:))) + sum(strcmp('S-', Allvectors(inode,:)))) == 2 && (sum(strcmp('N+', Allvectors(inode,:))) + sum(strcmp('N-', Allvectors(inode,:))))== 2    
    Allvectors(inode, :) = {NaN};   %invalidate 'S' or 'N' vectors at that node with NaNs    
end
    

end
