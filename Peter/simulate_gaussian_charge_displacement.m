function [gaussian_charge] = simulate_gaussian_charge_displacement(nr)


[X, Y] = meshgrid(-nr:1:nr, -nr:1:nr);

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

x0 = [1; 0; 15; 0; 15; 0; 0];

g0=twodgauss(x0,xdata);

x1 = [1; -10; 15; -10; 15; 0; 0];

g1=twodgauss(x1,xdata);

x2 = [1; -100; 15; -100; 15; 0; 0];

g2=twodgauss(x2,xdata);

[nx, ny, nz] = size(X);



gaussian_charge.map = cat(3, g0, g1, g2);
gaussian_charge.type = 0;
gaussian_charge.ave = [];
gaussian_charge.name = 'rec. topo ind. components';
gaussian_charge.r = 1:1:nx;
gaussian_charge.coord_type = 'r';
gaussian_charge.e = 1:1:3;
gaussian_charge.info = [];
gaussian_charge.ops = '';
gaussian_charge.var = 'simulation';




end