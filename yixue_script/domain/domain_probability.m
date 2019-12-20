% 2019-4-26 YXC calculate prob of hitting domain
% make a trace of boundary in ppt, thicken line to FOV size
% save as png then import to matlab 
% do img = im2double(rgb2gray(cdata));
% stm1 = mat2STM_Viewer(img,0,0,0)

stm = stm1;

[nx,ny] = size(stm.map);

total = nx*ny;
count = stm.map<0.5;
count2 = sum(sum(count));
prob = count2/total

stmm = stm;
stmm.map = count;
img_obj_viewer_yxc(stmm)