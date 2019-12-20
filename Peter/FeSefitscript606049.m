
en1 = obj_60604A00_G_FT_sym_avg3.e * 1000;
map1 = obj_60604A00_G_FT_sym_avg3.map;
q1 = obj_60604A00_G_FT_sym_avg3.r;

en1a = (obj_60609a00_G_FT_sym_avg3.e) * 1000;
map1a = obj_60609a00_G_FT_sym_avg3.map;

mapc = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)), 16 );
mapc(:,:,1:11) = map1(:,:,1:11);
mapc(:,:,12:16) = map1a(:,:,2:6);
enc = [en1, en1a(2:6)];

[X,Y]=meshgrid(1:1:max(size(map1(:,:,1),2)),1:1:max(size(map1(:,:,1),1)));

xdata(:,:,1)=X;
xdata(:,:,2)=Y;

ffmap = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );
bsmap = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );

for i=1:16
    [x3,resnorm,residual]=complete_fit_2d_gaussian_FeSe_BQPI(mapc(141:160, 144:157 ,i));

    x3(2) = x3(2)+144-1;
    x3(4) = x3(4)+141-1;

    finalfit3=twodgauss_xy_rigid(x3,xdata);
    ffmap(:,:,i) = finalfit3;
    bsmap(:,:,i) = mapc(:,:,i) - ffmap(:,:,i);
    bsmap(:,:,i) = bsmap(:,:,i) + abs( min( min( bsmap(:,:,i) ) ) );
    close all;
end

% -0.1 and 0 meV no BQPI, fits produce nans which conflict with the color
% scale
ffmap(:,:,15) = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );
ffmap(:,:,16) = zeros( max(size(map1(:,:,1),2)), max(size(map1(:,:,1),2)) );

bsmap(:,:,15) = obj_60609a00_G_FT_sym_avg3.map(:,:,5);
bsmap(:,:,16) = obj_60609a00_G_FT_sym_avg3.map(:,:,6);


obj_606049A00 = obj_60604A00_G_FT_sym_avg3;
obj_606049A00.map = mapc;
obj_606049A00.e = enc/1000;

obj_606049A00_BGF = obj_60604A00_G_FT_sym_avg3;
obj_606049A00_BGF.map = ffmap;
obj_606049A00_BGF.e = enc/1000;

obj_606049A00_BGS = obj_60604A00_G_FT_sym_avg3;
obj_606049A00_BGS.map = bsmap;
obj_606049A00_BGS.e = enc/1000;

mapcr = mapc;
mapcr(:,:,1:11) = obj_60604A00_G_FT.map(:,:,1:11);
mapcr(:,:,12:16) = obj_60609a00_G_FT.map(:,:,2:6);
obj_606049A00_raw = obj_60604A00_G_FT;
obj_606049A00_raw.e = enc/1000;
obj_606049A00_raw.map = mapcr;

%%

cut_q3a = line_cut_v4(obj_606049A00,[155, 150],[195, 150],0);
cut_q3b = line_cut_v4(obj_606049A00,[155, 151],[195, 151],0);
cut_q3c = line_cut_v4(obj_606049A00,[155, 149],[195, 149],0);
cut_q3d = line_cut_v4(obj_606049A00,[155, 152],[195, 152],0);


cut_q3 = cut_q3a;

cut_q3.cut = (cut_q3a.cut + cut_q3b.cut + cut_q3c.cut + cut_q3d.cut) / 4;

figure, hold on
for i=1:1:13
    plot(cut_q3.r,cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.25,'.-', 'LineWidth', 2);
end
hold off
% 
cut_q1a = line_cut_v4(obj_606049A00,[150, 150],[150, 130],0);
cut_q1b = line_cut_v4(obj_606049A00,[151, 150],[151, 130],0);
cut_q1c = line_cut_v4(obj_606049A00,[149, 150],[149, 130],0);
cut_q1d = line_cut_v4(obj_606049A00,[152, 150],[152, 130],0);

cut_q1 = cut_q1a;
cut_q1.cut = (cut_q1a.cut + cut_q1b.cut + cut_q1c.cut + cut_q1d.cut) / 4;

figure, hold on
% for i=5:1:15
for i=1:1:13
    plot(cut_q1.r,cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.2,'.-', 'LineWidth', 2);
end
hold off


