function spontaneouschangeable(data,tdata)

map = data.map;

tmap = tdata.map;

map = map(1:143,7:end,:);

tmap = tmap(1:143,7:end,:);

figure, img_plot4(map(:,:,33));

figure, img_plot5(tmap(:,:,1));


zerolayer = 33;

[nx, ny, nz] = size(map);

dirtmap = zeros(nx,ny,1);
freemap = zeros(nx,ny,1);

specdirt = zeros(nz,1);
specfree = zeros(nz,1);

for i=1:nx
    for j=1:ny
        if map(i,j,zerolayer) > 4;
            dirtmap(i,j,1) = 1;
            freemap(i,j,1) = 0;
            specdirt = specdirt + squeeze(map(i,j,:));
        else
            dirtmap(i,j,1) = 0;
            freemap(i,j,1) = 1;
            specfree = specfree + squeeze(map(i,j,:));
        end
    end
end
            

figure, img_plot5(dirtmap)
figure, img_plot5(freemap)

specdirt = specdirt/sum(sum(dirtmap));
specfree = specfree/sum(sum(freemap));


figure, plot(data.e,specdirt,'ko',data.e,specfree,'r+','Linewidth',2);
legend('Average affected zero bias','Average free area')



test = 1;




end