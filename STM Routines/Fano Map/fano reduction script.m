G_rdc = G;
[nr nc nz] = size(G.map);
%p1 = 11; p2 = 75; p3 = 107; p4 = 151; % 090727
%p1 = 3; p2 = 19; p3 = 28; p4 = 39; %090714
%p1 = 1; p2 = 63; p3 = 97; p4 = 141; %090722
p1 = 1; p2 = 68; p3 = 96; p4 = 161;
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
y2 = p.a*((x2 - p.e)/p.g + p.q).^2./(1 + ((x2 - p.e)/p.g).^2) + p.b*x2 + p.c;
figure; plot(x2,G.ave-y2'+ p.c + p.b*x2');
figure; plot(x2,G.ave-y2')
%% fit the whole map using average spectra fit parameters
tic; fano_map2(G_rdc.map,G_rdc.e'*1000,[p.a p.b p.c p.e p.g p.q],''); toc;
%% construct the pure fano map
G_fano = fano_recon(G,fano.a,fano.b,fano.c,fano.e,fano.g,fano.q);
%% construct the subtraction map
[nr nc nz] = size(G.map);
map1 = zeros(nr,nc,nz);
map2 = zeros(nr,nc,nz);
for i = 1:nz
    map1(:,:,i) = G.map(:,:,i) - G_fano.map(:,:,i) + fano.c(:,:) + fano.b(:,:)*G.e(i)*1000;
    map2(:,:,i) = G.map(:,:,i) - G_fano.map(:,:,i) + fano.c(:,:);
end
G_subt1 = G; G_subt2 = G;
G_subt1.map = map1; G_subt2.map = map2;
G_subt1.ave = squeeze(squeeze(sum(sum(G_subt1.map)/nr/nc)));
G_subt2.ave = squeeze(squeeze(sum(sum(G_subt2.map)/nr/nc)));
clear nr nc nz map

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