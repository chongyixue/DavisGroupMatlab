%14 March 2017
%crop out some dimensions and energy level
%gives out a new map set "cropped"
%Yi Xue Chong

%use stm_view_v4 to load original map/topo
%insert name of object to be cropped
original = obj_70308a00_G;

cropped = original;

%crop x/y direction
%(y_pixel:y_pixel,x_pixel:x_pixel)
cropped.map = original.map(:,:,:);

%next crop energy levels change third range in map
cropped.map = cropped.map(:,:,21:81);
cropped.e   = cropped.e(21:81);

%finally can check with >> img_obj_viewer2(cropped) and also change name