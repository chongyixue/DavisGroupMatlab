function new_data = jdos_linecuts(data,cx, cy)





data.map = data.map(cx(1):cx(2), cy(1):cy(2),:);

[nx, ny, nz] = size(data.map);

data.r = linspace(-1, 1, nx);

new_data = data;

[dum, ex] = min (abs(data.r - 0.15) ) ;
sx = round (nx/2+1 - (ex-nx/2+1) );

new_data.map = new_data.map(sx:ex, sx:ex, :);

pos1 = round([sx,nx/2+1]);
pos2 = round([ex,nx/2+1]);

avg_px = 5;

lcut1 = line_cut_v3(data,pos1,pos2,avg_px);

pos1 = round([nx/2+1, sx]);
pos2 = round([nx/2+1, ex]);

avg_px = 5;

lcut2 = line_cut_v3(data,pos1,pos2,avg_px);


test=1;

close all;

cut1 = lcut1.cut;

cut2 = lcut2.cut;

[lx, ly] = size(cut1);

for i=1:ly
    dum1 = max(cut1(:,i));
    cut1(:,i) = cut1(:,i)/dum1;
end

for i=1:ly
    dum1 = max(cut2(:,i));
    cut2(:,i) = cut2(:,i)/dum1;
end

figure, imagesc(lcut1.r,lcut1.e,cut1')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q_y [2\pi/a_{Fe}]','FontSize',16);
ylabel('E [eV]','FontSize', 16);

figure, imagesc(lcut2.r,lcut2.e,cut2')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q_x [2\pi/a_{Fe}]','FontSize',16);
ylabel('E [eV]','FontSize', 16);

end