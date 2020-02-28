function [X, Y, Z, C] = fun_build_voxels_xyz(roiMask)
  maskSize = size(roiMask);

  % Create the ROI surface patches pointing toward -x:
  index = find(diff(padarray(roiMask, [1 0 0], 'pre'), 1, 1) > 0);
  [X1, Y1, Z1, C1] = make_patches([-1 -1 -1 -1], [1 1 -1 -1], [-1 1 1 -1]);

  % Create the ROI surface patches pointing toward +x:
  index = find(diff(padarray(roiMask, [1 0 0], 'post'), 1, 1) < 0);
  [X2, Y2, Z2, C2] = make_patches([1 1 1 1], [-1 -1 1 1], [-1 1 1 -1]);

  % Create the ROI surface patches pointing toward -y:
  index = find(diff(padarray(roiMask, [0 1 0], 'pre'), 1, 2) > 0);
  [X3, Y3, Z3, C3] = make_patches([-1 -1 1 1], [-1 -1 -1 -1], [-1 1 1 -1]);

  % Create the ROI surface patches pointing toward +y:
  index = find(diff(padarray(roiMask, [0 1 0], 'post'), 1, 2) < 0);
  [X4, Y4, Z4, C4] = make_patches([1 1 -1 -1], [1 1 1 1], [-1 1 1 -1]);

  % Create the ROI surface patches pointing toward -z:
  index = find(diff(padarray(roiMask, [0 0 1], 'pre'), 1, 3) > 0);
  [X5, Y5, Z5, C5] = make_patches([1 1 -1 -1], [-1 1 1 -1], [-1 -1 -1 -1]);

  % Create the ROI surface patches pointing toward +z:
  index = find(diff(padarray(roiMask, [0 0 1], 'post'), 1, 3) < 0);
  [X6, Y6, Z6, C6] = make_patches([-1 -1 1 1], [-1 1 1 -1], [1 1 1 1]);

  % Collect patch data:
  X = [X1 X2 X3 X4 X5 X6];
  Y = [Y1 Y2 Y3 Y4 Y5 Y6];
  Z = [Z1 Z2 Z3 Z4 Z5 Z6];
  C = [C1 C2 C3 C4 C5 C6];

  function [Xp, Yp, Zp, Cp] = make_patches(Xo, Yo, Zo)
    [Xp, Yp, Zp] = ind2sub(maskSize, index);
    Xp = bsxfun(@plus, Xp, Xo./2).';
    Yp = bsxfun(@plus, Yp, Yo./2).';
    Zp = bsxfun(@plus, Zp, Zo./2).';
    Cp = index(:).';
  end
end