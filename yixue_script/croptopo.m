%14 March 2017
%crop out some dimensions and energy level
%gives out a new map set "cropped"
%Yi Xue Chong

%use stm_view_v4 to load original map/topo
%insert name of object to be cropped
original = obj_70308A00_T;

croppedtopo = original;

%crop x/y direction
%(y_pixel:y_pixel,x_pixel:x_pixel)
croppedtopo.map = original.map(19:128,:);

croppedtopo.topo1 = croppedtopo.topo1(19:128,:);

%finally can check with >> img_obj_viewer2(cropped) and also change name