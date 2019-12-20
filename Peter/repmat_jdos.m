function RM = repmat_jdos(M)

[nx, ny] = size(M);

RM(1:nx-1,1:ny-1) = M(1:nx-1, 1:ny-1);
RM(1:nx-1,ny:2*ny-1) = M(1:nx-1, 1:ny);
RM(1:nx-1,2*ny:3*ny-2) = M(1:nx-1, 2:ny);

RM(nx:2*nx-1,1:ny-1) = M(1:nx, 1:ny-1);
RM(nx:2*nx-1,ny:2*ny-1) = M(1:nx, 1:ny);
RM(nx:2*nx-1,2*ny:3*ny-2) = M(1:nx, 2:ny);

RM(2*nx:3*nx-2, 1:ny-1) = M(2:nx, 1:ny-1);
RM(2*nx:3*nx-2, ny:2*ny-1) = M(2:nx, 1:ny);
RM(2*nx:3*nx-2, 2*ny:3*ny-2) = M(2:nx, 2:ny);

% figure, imagesc(RM)
% 
% RM2 = repmat(M, 3);
% 
% figure, imagesc(RM2)
% 
% test =1;











end