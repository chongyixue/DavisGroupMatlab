%2018-11-14


topo0 = obj_81108A00_T;
topo8 = obj_81109A00_T;

topo0 = topo0.map(:,:,1);
topo8 = topo8.map(:,:,1);

upright = topo8;
rotated = topo0;

figure(),
imshowpair(upright,rotated,'montage')

% cpselect(rotated, upright) % brings up a window to choose points from both images
% alternatively specify the points manually 
movingPoints3(1,1) = 189; movingPoints3(1,2) = 132;
movingPoints3(2,1) = 167; movingPoints3(2,2) = 170;
movingPoints3(3,1) = 155; movingPoints3(3,2) = 3;
movingPoints3(4,1) = 38; movingPoints3(4,2) = 98;

fixedPoints3(1,1) = 190; fixedPoints3(1,2) = 93;
fixedPoints3(2,1) = 169; fixedPoints3(2,2) = 131;
fixedPoints3(3,1) = 157; fixedPoints3(3,2) = 2;
fixedPoints3(4,1) = 39; fixedPoints3(4,2) = 58;

% fitgeotrans give the transformation
tform = fitgeotrans(movingPoints3,fixedPoints3,'NonreflectiveSimilarity');

rotatedregistered = imwarp(rotated,tform,'OutputView',imref2d(size(upright)));
figure, imshowpair(upright,rotatedregistered)

