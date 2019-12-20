%2018-11-14

upright = checkerboard(40);
rotated = imrotate(upright,30);
% upright = FOV_8;
% rotated = FOV_0;

figure(),
imshowpair(upright,rotated,'montage')

cpselect(rotated, upright) % brings up a window to choose points from both images

movingPoints4
fixedPoints4

tform = fitgeotrans(movingPoints4,fixedPoints4,'NonreflectiveSimilarity');

rotatedregistered = imwarp(rotated,tform,'OutputView',imref2d(size(upright)));
figure
imshowpair(upright,rotatedregistered)

