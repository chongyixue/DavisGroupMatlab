% 2020-5-18 YXC
% does LF create artifact at the edge (non-equal lattice spacings)?
%

%% create lattice

nx = 200;
mat = zeros(nx,nx);

q = 20.73;
Q1x = q*cos(0);
Q1y = q*sin(0);
Q2x = q*cos(pi/2);
Q2y = q*sin(pi/2);
Q3x = q*cos(pi/3);
Q3y = q*sin(pi/3);
Q4x = q*cos(2*pi/3);
Q4y = q*sin(2*pi/3);
phi1 = 0.053;
phi2 = 0.1;

[X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,nx,nx));
squaremat = cos((X*Q1x+Y*Q1y)*2*pi/nx+phi1) + cos((X*Q2x+Y*Q2y)*2*pi/nx+phi2);
hexmat = cos((X*Q1x+Y*Q1y)*2*pi/nx+phi1)+cos((X*Q3x+Y*Q3y)*2*pi/nx+phi2)+...
    +cos((X*Q4x+Y*Q4y)*2*pi/nx);
square = mat2STM_Viewer(squaremat,1,1,1,'square');
hex = mat2STM_Viewer(hexmat,1,1,1,'hex');

img_obj_viewer_test(square)
img_obj_viewer_test(hex)

register_lattice_gui(hex,square)






