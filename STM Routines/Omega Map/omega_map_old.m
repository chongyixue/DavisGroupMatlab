function [omap gmap] = omega_map_old(fdata,clmap)
[sx sy sz] = size(fdata.map);
gmap = zeros(sx,sy); 
omap = zeros(sx,sy);
mx = 131;
mn = 50;
x = fdata.e(mn:mx);
for i = 1:sx
    for j=1:sy
        y1 = squeeze(squeeze(fdata.map(i,j,mn:mx)));        
        [p1,S1] = polyfit(x',y1,4);
        f1 = polyval(p1,x,S1);
        diff1 = diff(f1,1);
        ind1 = find(diff1 == max(diff1));
        if x(ind1) > 0.15
            [i j]
        end
        
        
        y2 = squeeze(squeeze(fdata.map(i,j,:)));        
        [p2,S2] = polyfit(fdata.e',y2,21);
        f2 = polyval(p2,fdata.e,S2);
        ind2 = find(f2 == max(f2));        
        
        gmap(i,j) = fdata.e(ind2);
        omap(i,j) = fdata.e(ind1 + mn -1);
    end
end
omap = omap - gmap;
figure; pcolor(omap); shading flat; colormap(clmap)
figure; pcolor(gmap); shading flat; colormap(clmap);
end
