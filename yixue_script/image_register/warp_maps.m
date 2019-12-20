% 2018-11-14
% given warping parameter transform the maps
% movingPoints and fixedPoints are 4 points from moving and fixed maps
% resp., eg
% movingPoints3(1,1) = 189; movingPoints3(1,2) = 132;
% movingPoints3(2,1) = 167; movingPoints3(2,2) = 170;
% movingPoints3(3,1) = 155; movingPoints3(3,2) = 3;
% movingPoints3(4,1) = 38; movingPoints3(4,2) = 98;
% 
% fixedPoints3(1,1) = 190; fixedPoints3(1,2) = 93;
% fixedPoints3(2,1) = 169; fixedPoints3(2,2) = 131;
% fixedPoints3(3,1) = 157; fixedPoints3(3,2) = 2;
% fixedPoints3(4,1) = 39; fixedPoints3(4,2) = 58;

function newmap = warp_maps(moving_map,fixed_map,movingPoints,fixedPoints)


tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');

layers = size(moving_map.map,3);

for n = 1:layers
    moving_map.map(:,:,n) =  imwarp(moving_map.map(:,:,n),tform,'OutputView',imref2d(size(fixed_map(:,:,1))));
end
moving_map.name = strcat(moving_map.name ,"registered");
img_obj_viewer_test(moving_map)

newmap = moving_map;

end

