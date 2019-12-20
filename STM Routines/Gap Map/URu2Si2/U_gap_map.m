function gap_map = U_gap_map(G_data)
[nr nc nz] = size(G_data.map);
pt1 = 54; pt2 = 69;
%nr = 10; nc = 10;
load_color;
x = G_data.e*1000;
gap_map = zeros(nr, nc);
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G_data.map(i,j,:))); y = y';   
        %y = G_data.ave; y = y'
        [p,S]= polyfit(x(pt1:pt2),y(pt1:pt2),6);
        y2 = polyval(p,x(pt1:pt2));
        [dy2 x2] = num_der2(2,y2,x(pt1:pt2));
             
        %y2 = polyval(p,x(19):0.1:x(31));        
        %[dy2 x2] = num_der2(2,y2,x(19):0.1:x(31));        
        x0 = x2((abs(dy2)==max(abs(dy2))));
        gap_map(i,j) = x0;
        %figure; plot(x,y); hold on; plot(x(pt1:pt2),y2,'r'); hold on; plot(x2,dy2,'g');
        
    end
end
figure; pcolor(gap_map); shading flat; colormap(Cmap.Defect1);
end