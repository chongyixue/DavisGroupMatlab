testmap = obj_80831a00_G;
testmap.map(:,:,1) = 0;

testmap.map(80,101,1)=1;
testmap.map(120,101,1)=1;

img_obj_viewer_yxc(testmap);
