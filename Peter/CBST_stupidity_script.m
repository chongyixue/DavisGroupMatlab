function [nmgmap, CP4] = CBST_stupidity_script(data, mgmap, acc)


[nx, ny, nz] = size(mgmap);


[sig1, sig2, x] = CBST_AC_fitting(data, acc);

[X,Y]=meshgrid(1:1:max(size(mgmap(:,:,1),2)),1:1:max(size(mgmap(:,:,1),1)));

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

x(1) = 1;
x(3) = 6;
x(5) = 6;
x(6) = 0;
x(2) = 50;
x(4) = 50;

F = twodgauss(x,xdata) / (2*pi*x(1)*x(3)*x(5));

figure, imagesc(F)
figure, imagesc(mgmap)


%%
[nx, ny, nz] = size(mgmap);

padimmg = zeros(2*nx, 2*ny);


if mod(nx,2) == 0
    padimmg = zeros(2*nx, 2*ny);
    padimmg(nx-nx/2+1 : nx+nx/2, ny-ny/2+1 : ny+ny/2) = mgmap; 
else
    padimmg = zeros(2*nx-1, 2*ny-1);
    padimmg(floor(nx/2)+1 - floor(nx/2) : floor(nx/2)+1 + floor(nx/2),...
        floor(ny/2)+1 - floor(ny/2) : floor(ny/2)+1 + floor(ny/2)) = ...
        mgmap;
end


padimgau = zeros(2*nx, 2*ny);


if mod(nx,2) == 0
    padimgau = zeros(2*nx, 2*ny);
    padimgau(nx-nx/2+1 : nx+nx/2, ny-ny/2+1 : ny+ny/2) = F; 
else
    padimgau = zeros(2*nx-1, 2*ny-1);
    padimgau(floor(nx/2)+1 - floor(nx/2) : floor(nx/2)+1 + floor(nx/2),...
        floor(ny/2)+1 - floor(ny/2) : floor(ny/2)+1 + floor(ny/2)) = ...
        F;
end



onemap = ones(nx, ny);

padimones = zeros(2*nx, 2*ny);


if mod(nx,2) == 0
    padimones = zeros(2*nx, 2*ny);
    padimones(nx-nx/2+1 : nx+nx/2, ny-ny/2+1 : ny+ny/2) = onemap; 
else
    padimones = zeros(2*nx-1, 2*ny-1);
    padimones(floor(nx/2)+1 - floor(nx/2) : floor(nx/2)+1 + floor(nx/2),...
        floor(ny/2)+1 - floor(ny/2) : floor(ny/2)+1 + floor(ny/2)) = ...
        onemap;
end


figure, imagesc(padimmg)
figure, imagesc(padimgau)
figure, imagesc(padimones)
%%

C = conv2(mgmap,F,'same');

figure, imagesc(C);

newmassgap = mgmap - C;

figure, imagesc(newmassgap)

%%

CP1 = conv2(padimmg,padimgau,'same');
CP2 = conv2(padimones,padimgau,'same');


CP3 = CP1./CP2;
figure, imagesc(CP3)

CP4 = CP3(nx-nx/2+1 : nx+nx/2, ny-ny/2+1 : ny+ny/2);

nmgmap = mgmap - CP4 + mean(mean(CP4));

figure, imagesc(CP4)
figure, imagesc(nmgmap)

end