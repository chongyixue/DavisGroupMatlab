
%script gives coordinates of new center to be typed into toposm 
%21 June 2017
%Yi Xue Chong

test = obj_70613a03_T;
%[x,y,size in nm,rotation angle]
test.coord=[969.4,229.1,30,0];

%put in pixel number of new center
pixelx = 0;
pixely = 1024;

[x,y]=new_center(pixelx,pixely,test.coord(4),test.coord(1),test.coord(2),test.coord(3),length(test.map))


