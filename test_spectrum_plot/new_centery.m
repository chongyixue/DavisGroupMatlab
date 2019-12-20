function y = new_centery(centerpixx,centerpixy,rotation,x0,y0,sizenm,pixel)

%function returns new coordinate (for topopsm)
%21 june 2017
%yixuechong

size = sizenm*10;%in A
angle = rotation*pi/180;%radians

%put in pixel number of new center
pixelx = centerpixx;
pixely = centerpixy;
 
%vector distance in pixel from center
pixx = pixelx-pixel/2;
pixy = pixel/2-pixely;

x=pixx/pixel*size;
y=pixy/pixel*size;

xnew = x*cos(angle)-y*sin(angle);
ynew = x*sin(angle)+y*cos(angle);

x=xnew+x0;
y=ynew+y0;





end

