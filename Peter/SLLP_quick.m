function SLLP_quick(data,layers)


map = data.map;
ev = data.e*1000;
ev = ev(layers(1):layers(2));
[nx,ny,nz] = size(map);
sllmap = zeros(nx,ny,1);

for i=1:nx
    for j=1:ny
        spec = squeeze(map(i,j,layers(1):layers(2)));
%         smspec = sgolayfilt(spec,3,7);
%         figure, plot(ev,spec,'k+-',ev,smspec,'ro-','LineWidth',2);
        [dum0,maxid] = max(spec);
        sllmap(i,j,1) = ev(maxid);
        
    end
end

figure, img_plot4(sllmap);

end