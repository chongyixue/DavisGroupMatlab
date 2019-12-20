G_rdc = G;
[nr nc nz] = size(G.map);
%p1 = 11; p2 = 75; p3 = 107; p4 = 151; % 090727
%p1 = 3; p2 = 19; p3 = 28; p4 = 39; %090714
%p1 = 1; p2 = 63; p3 = 97; p4 = 141; %090722
p1 = 1; p2 = 69; p3 = 84; p4 = 151;
G_rdc.e = [G.e(p1:p2) G.e(p3:p4)];
for i =p1:p2
    map(:,:,i-p1+1) = G.map(:,:,i);
end;
for i =p3:p4
    map(:,:,i-p3+p2-p1+2) = G.map(:,:,i);
end;
G_rdc.map = map;
G_rdc.ave = squeeze(squeeze(sum(sum(G_rdc.map)/nr/nc)));
clear nr nc nz p* map
%% fano fit of average spectra
[p g] = fano_fit3(G_rdc.e'*1000,G_rdc.ave);
%% average subraction
x2 = G.e*1000;
y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2.^2 + p.c*x2 ;
%figure; plot(x2,G.ave-y2'+ p.c + p.b*x2');
figure; plot(x2,G.ave-y2')
%% fit the whole map using average spectra fit parameters
tic; fano_map2(G_rdc.map,G_rdc.e'*1000,coeffvalues(p),''); toc;
%% construct the pure fano map
G_fano = fano_recon2(G,fano.a,fano.b,fano.c,fano.d,fano.e,fano.g,fano.q);
%% construct the subtraction map
[nr nc nz] = size(G.map);
map = zeros(nr,nc,nz);

for i = 1:nz
    map(:,:,i) = G.map(:,:,i) - G_fano.map(:,:,i) + fano.d(:,:);
end
G_subt = G;
G_subt.map = map;
G_subt.ave = squeeze(squeeze(sum(sum(G_subt.map)/nr/nc)));

clear nr nc nz map
%% Construct Division Map
[nr nc nz] = size(G.map);

G_div = G;
for k = 1:nz
    G_div.map(:,:,k) = G_div.map(:,:,k)./G_fano.map(:,:,k);
end
G_div.ave = squeeze(squeeze(mean(mean(G_div.map))));
clear nr nc nz k;
%% Division Map II
[nr nc nz] = size(G.map);
G_div2 = G;
for k = 1:nz
    G_div2.map(:,:,k) = G_div2.map(:,:,k)./G_fano.ave(k);
end
G_div2.ave = squeeze(squeeze(mean(mean(G_div2.map))));
clear nr nc nz k;
%% Fit gap in Division map to Gaussian
[nr nc nz] = size(G_subt.map);
fano_gap.a = zeros(nr,nc);
fano_gap.b = zeros(nr,nc);
fano_gap.c = zeros(nr,nc);
fano.gap.d = zeros(nr,nc);
fano.gap.e = zeros(nr,nc);
p1 = 1; p2 = nz;
x = G_subt.e(p1:p2); x = x*1000;
%nr = 2; nc = 2;
for i = 1:nr
    i
    for j = 1:nc
        y = squeeze(squeeze(G_subt.map(i,j,p1:p2)));
        [pgap ggap] = fit_Gaussian1D(x,y);
        fano_gap.a(i,j) = pgap.a;
        fano_gap.b(i,j) = pgap.b;
        fano_gap.c(i,j) = pgap.c;
        fano_gap.d(i,j) = pgap.d;
        fano_gap.e(i,j) = pgap.e;               
    end
end
clear nr nc nz pgap ggap i j x y;
%%

figure; plot(e2K,spect2K/max(spect2K));
hold on; plot(e10K,spect10K/max(spect10K) + 0.15);
hold on; plot(e18K,spect18K/max(spect18K) + .3);
%%
figure;plot(e2K,spect2K_subt1/max(spect10K_subt1));
hold on;plot(e10K,spect10K_subt1/max(spect10K_subt1)+0.12);
hold on;plot(e18K,spect18K_subt1/max(spect18K_subt1)+0.3);
%%
figure;plot(e2K,spect2K_subt2/max(spect10K_subt2));
hold on;plot(e10K,spect10K_subt2/max(spect10K_subt2)+0.12);
hold on;plot(e18K,spect18K_subt2/max(spect18K_subt2)+0.3);