% 2019-4-26 YXC visualize domain wall
% directly from MFM image
% save as png then import to matlab 

img = im2double(rgb2gray(cdata));
stm1 = mat2STM_Viewer(img,0,0,0);

stm = stm1;

[nx,ny] = size(stm.map);

total = nx*ny;
count = and(stm.map>0.4,stm.map<0.6);
count2 = sum(sum(count));
prob = count2/total

stmm = stm;
stmm.map = count;
img_obj_viewer_yxc(stmm)