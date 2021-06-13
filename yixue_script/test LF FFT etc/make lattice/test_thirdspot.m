% 2020-4-8 YXC

Brag = 7;

k1x = Brag;
k1y = 0;
k2x = Brag*cos(pi/3);
k2y = Brag*sin(pi/3);
k3x = -k2x;
k3y = k2y;

topo3 = simulate_lattice_with_k(k1x,k1y,k2x,k2y,k3x,k3y);
topo2 = simulate_lattice_with_k(k1x,k1y,k2x,k2y);


k4x = Brag*cos(2*pi/3+0.1);
k4y = Brag*sin(2*pi/3+0.1);

topo3bad = simulate_lattice_with_k(k1x,k1y,k2x,k2y,k4x,k4y)