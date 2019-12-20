function  ftc = fese_normalized_linecuts(acdata, bcdata, pos1, pos2, pos3, pos4, avg_px)




acdata.e = fliplr(acdata.e);

acdata.map = flip(acdata.map, 3);

zlb = find(bcdata.e == 0);
zla = find(acdata.e == 0);

cdata = bcdata;

cdata.map = cat(3, bcdata.map(:, :, 1:zlb),acdata.map(:, :, zla+1:end));
cdata.e = [bcdata.e(1:zlb), acdata.e(zla+1:end)];

% img_obj_viewer2(cdata);

cdata = polyn_subtract(cdata,0);

ftc = fourier_transform2d_vb(cdata,'sine','amplitude','ft');

ftc.r = ftc.r / (2*pi/2.687);

ftc = symmetrize_image(ftc,'vh');

% img_obj_viewer2(ftc)

[nx, ny, nz] = size(ftc.map);
% 
% pos1 = round([1,nx/2+1]);
% pos2 = round([nx,nx/2+1]);

% avg_px = 5;

lcut1 = line_cut_v3(ftc,pos1,pos2,avg_px);

% pos3 = round([nx/2+1, 1]);
% pos4 = round([nx/2+1, nx]);

% avg_px = 5;

lcut2 = line_cut_v3(ftc,pos3,pos4,avg_px);


test = 1;

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
xlabel('q_x [2\pi/a_{Fe}]','FontSize',16);
ylabel('E [eV]','FontSize', 16);

figure, imagesc(lcut2.r,lcut2.e,cut2')
set(gca,'YDir','normal')   
set(gca, 'FontSize', 16);
xlabel('q_y [2\pi/a_{Fe}]','FontSize',16);
ylabel('E [eV]','FontSize', 16);



end