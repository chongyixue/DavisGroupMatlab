test1 = obj_70614a00_T;
test2 = obj_70613a06_T;

%coordinates in units of A not nm
%(x,y(bottom left=0),size,rotation)
test1.coord = [1750.9,2279.0,100,0];
test2.coord = [969.4,229.1,100,0];

%put the coordinates of pixel and Amstrong in the same direction
test1.coord(2)=-test1.coord(2);
test2.coord(2)=-test2.coord(2);
%(voltage-mV,current-pA)
test1.setup = [-50,50];
test2.setup = [-50,50];

Dx = test2.coord(1)-test1.coord(1);
Dy = test2.coord(2)-test1.coord(2);

pixel1=length(test1.topo1);
pixel2=length(test2.topo1);
pix = lcm(pixel1,pixel2);
%lpp = length per pixel
lpp1 = test1.coord(3)/pix; 
lpp2 = test2.coord(3)/pix; 
lpp = min(lpp1, lpp2);
[a,b] = max([lpp1,lpp2]);

%number of pixel (check if integer)
npx = Dx/lpp;
npy = Dy/lpp;

npx = round(npx);
npy = round(npy);

Dx = npx*lpp;
Dy = npy*lpp;

test2.coord(1)=test1.coord(1)+Dx;
test2.coord(2)=test1.coord(2)+Dy;





