function sedmap = diracpointmapzerofield(data,es,ee)


map = data.map(:,:,es:ee);
[nx,ny,nz] = size(map);
en = data.e(es:ee);
le = length(en);
sedmap = zeros(nx,ny,1);

for i=1:nx
    for j=1:ny
        spec = squeeze(map(i,j,:));
%         ien = linspace(en(1),en(le),le*10);
%         spec = interp1(en,spec,ien,'pchip');
        smspec = sgolayfilt(spec,3,7);
%         figure, plot(en,spec,'k+-',en,smspec,'ro-','LineWidth',2);
%         figure, plot(ien,spec,'k+-',ien,smspec,'ro-','LineWidth',2);
        [C,I] = min(smspec);
        sedmap(i,j,1) = en(I);
%         sedmap(i,j,1) = ien(I);
        
    end
end

figure; img_plot4(sedmap);
test=1;


end