function dosfromspectralfunction(data,dataxz,datayz)

en = data.e;

map = data.map;

mapxz = dataxz.map;

mapyz = datayz.map;

for i=1:length(en)
    dos(i) = sum(sum(map(:,:,i)));
    dosxz(i) = sum(sum(mapxz(:,:,i)));
    dosyz(i) = sum(sum(mapyz(:,:,i)));

end

% dos = dos/max(dos);
% dosxz = dosxz/max(dosxz);
% dosyz = dosyz/max(dosyz);

figure, plot(en, dos,'-k.')
figure, plot(en, dosxz,'-ro',en,dosyz,'-bs')

end