function [ThetaNorm, cp] = fun_computeCA(P,SearchRadius,minR,SMALL,plotSurfaces,plotSearchradius)



%<-- Change pixel labels to letter notations
[P] = fun_change_pixel_labels(P);


%<-- Plot the image
if plotSurfaces
    Pimage       = P;
    [Pimage]     = fun_reLabelImage(Pimage);
    [X, Y, Z, C] = fun_build_voxels_xyz(Pimage > 0);
    rgbData = reshape([1 0 0; 1 1 0], [2 1 3]);
    %rgbData = reshape([0 0 0; 1 1 1], [2 1 3]);    %for black & white
    hSurface = patch(X, Y, Z, rgbData(Pimage(C), :, :), ...
        'AmbientStrength', 0.5, ...
        'BackFaceLighting', 'unlit', ...
        'EdgeColor', 'none', ...
        'FaceLighting', 'flat');

    %colormap([1 0 0; 1 1 0]);
    %hSurface.FaceAlpha = 0.35;
    axis equal;
    axis tight;
    view(45, 45);
    grid on;
    xlabel('X [voxels]');
    ylabel('Y [voxels]');
    zlabel('Z [voxels]');
    light('Position', get(gca, 'CameraPosition'), 'Style', 'local');
    zoom on;
    box on;
    hold on;
end


%<-- Obtain the image size
[nx, ny, nz] = size(P);

%<-- Obtain full output grids as well as the coordinates of the edges
[edgeCoords, ~, ~, ~] = fun_getEdgeCoords(nx, ny, nz);


%%%%%%%%%%%%%%%% Compute the normal vectors around each node
%<-- Create a cell array to store your normal vectors
Allvectors = cell(size(edgeCoords, 1), 6);
for inode = 1: size(edgeCoords, 1)
    
    % determine the x, y, z coordinates of each edge
    [ix, iy, iz] = fun_get_ixiyiz_from_inode(edgeCoords, inode);
    
    % compute normal vectors at each face around each edge
    [n, s, e, w, t, b] = fun_find_normal_vectors(ix, iy, iz, P);
    
    % assign the vector at each face to a location in the storage cell
    Allvectors{inode, 1} = n;
    Allvectors{inode, 2} = s;
    Allvectors{inode, 3} = e;
    Allvectors{inode, 4} = w;
    Allvectors{inode, 5} = t;
    Allvectors{inode, 6} = b;
end

%<-- Find contactpoints
[contactPoints, cp, Allvectors] = fun_findcontactpoints(Allvectors, edgeCoords);

%<-- Pre-allocate storage for contact angles (CA)
ThetaNorm  = NaN(numel(contactPoints), 1);  
ThetaModel = NaN(numel(contactPoints), 1);  

%initialize inode_S and N to contactPointNodes
inode_in  = contactPoints;

%initialize the coordinates of x-point for the solid and non-wetting phases
xpoints = [];   avg_ns = [];
xpointn = [];   avg_nn = [];

%preallocate storage for normal vector comps. collated within R1
nsa = cell(numel(contactPoints), 1);
nna = cell(numel(contactPoints), 1);


%<-- Find all normal vectors and all X-point coordinates within R1
for ncp = 1:numel(contactPoints)
    
    %<-- Plot the search radius
    if plotSearchradius
        fun_number_contactPoints(ncp, cp, SearchRadius)
    end
    
    %<-- Find all X-points for WS ans WN interphases
    [avg_ns, ~] = fun_findXpoints('S', ncp, edgeCoords, cp, inode_in, nx, ny,contactPoints, SearchRadius,  minR,Allvectors);
    [avg_nn, ~] = fun_findXpoints('N', ncp, edgeCoords, cp, inode_in, nx, ny,contactPoints, SearchRadius,  minR,Allvectors);
                             
    %<-- Compute contact angles based on normal vectors
    ThetaNorm(ncp,:)  = fun_findTheta(avg_ns, avg_nn, SMALL);
     
end






end