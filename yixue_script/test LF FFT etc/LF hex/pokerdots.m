lattice = imread('hexdots.png');
lattice = rgb2gray(lattice);
lattice = im2double(lattice);
lattice = ones(400)-lattice;
hexlattice = mat2STM_Viewer(lattice,1,1,1);

