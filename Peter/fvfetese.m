function [Y,YT,YZ,map1c,map2c,topo1c,topo2c,dmap,cohmap,dimap,dtestmap, dtestmap2]...
    = fvfetese(data1,data2,a1,a2,tdata1,tdata2,bon,idata1, idata2,fen)

le = length(data1.e);

for j = 1:le
    if data1.e(j) == 0
        zlayer = j;
    end
end



load_color;
a1 = round(a1);
a2 = round(a2);

dx = a1(1) - a2(1);
dy = a1(2) - a2(2);


gs = 15;
sig =3;

if strcmp('blur',bon)==1
    new_data1 = gauss_blur_image(data1,gs,sig);
    new_data2 = gauss_blur_image(data2,gs,sig);
    new_tdata1 = gauss_blur_image(tdata1,gs,sig);
    new_tdata2 = gauss_blur_image(tdata2,gs,sig);
    new_idata1 = gauss_blur_image(idata1,gs,sig);
    new_idata2 = gauss_blur_image(idata2,gs,sig);
else
    new_data1 = data1;
    new_data2 = data2;
    new_tdata1 = tdata1;
    new_tdata2 = tdata2;
    new_idata1 = idata1;
    new_idata2 = idata2;
end

if strcmp('feenstra',fen)==1
    for i=1:length(new_data1.e)
        map1(:,:,i) = new_data1.map(:,:,i)./new_idata1.map(:,:,i);
        map2(:,:,i) = new_data2.map(:,:,i)./new_idata2.map(:,:,i);
    end
else
    map1 = new_data1.map;
    map2 = new_data2.map;
end



topo1 = new_tdata1.map;
topo2 = new_tdata2.map;
imap1 = new_idata1.map;
imap2 = new_idata2.map;

[nx, ny, ne] = size(map1);


% map1c = zeros(nx,ny,ne);
% map2c = zeros(nx,ny,ne);
% topo1c = zeros(nx,ny);
% topo2c = zeros(nx,ny);
% imap1c = zeros(nx,ny,ne);
% imap2c = zeros(nx,ny,ne);

map1c = [];
map2c = [];
topo1c = [];
topo2c = [];
imap1c = [];
imap2c = [];

if dx < 0
%     map1c(1-dx:end,:,:) = map1(1:end+dx,:,:);
%     map2c(1-dx:end,:,:) = map2(1-dx:end,:,:);
%     topo1c(1-dx:end,:,:) = topo1(1:end+dx,:,:);
%     topo2c(1-dx:end,:,:) = topo2(1-dx:end,:,:);
%     imap1c(1-dx:end,:,:) = imap1(1:end+dx,:,:);
%     imap2c(1-dx:end,:,:) = imap2(1-dx:end,:,:);
    
    map1c = map1(1:end+dx,:,:);
    map2c = map2(1-dx:end,:,:);
    topo1c = topo1(1:end+dx,:,:);
    topo2c = topo2(1-dx:end,:,:);
    imap1c = imap1(1:end+dx,:,:);
    imap2c = imap2(1-dx:end,:,:);
end
if dx > 0
%     map1c(1:end-dx,:,:) = map1(1+dx:end,:,:);
%     map2c(1:end-dx,:,:) = map2(1:end-dx,:,:);
%     topo1c(1:end-dx,:,:) = topo1(1+dx:end,:,:);
%     topo2c(1:end-dx,:,:) = topo2(1:end-dx,:,:);
%     imap1c(1:end-dx,:,:) = imap1(1+dx:end,:,:);
%     imap2c(1:end-dx,:,:) = imap2(1:end-dx,:,:);
    
    map1c = map1(1+dx:end,:,:);
    map2c = map2(1:end-dx,:,:);
    topo1c = topo1(1+dx:end,:,:);
    topo2c = topo2(1:end-dx,:,:);
    imap1c = imap1(1+dx:end,:,:);
    imap2c = imap2(1:end-dx,:,:);
end
if dy < 0 
%     map1c(:,1-dy:end,:) = map1c(:,1:end+dy,:);
%     map2c(:,1-dy:end,:) = map2c(:,1-dy:end,:);
%     topo1c(:,1-dy:end,:) = topo1c(:,1:end+dy,:);
%     topo2c(:,1-dy:end,:) = topo2c(:,1-dy:end,:);
%     imap1c(:,1-dy:end,:) = imap1c(:,1:end+dy,:);
%     imap2c(:,1-dy:end,:) = imap2c(:,1-dy:end,:);

    map1c = map1c(:,1:end+dy,:);
    map2c = map2c(:,1-dy:end,:);
    topo1c = topo1c(:,1:end+dy,:);
    topo2c = topo2c(:,1-dy:end,:);
    imap1c = imap1c(:,1:end+dy,:);
    imap2c = imap2c(:,1-dy:end,:);
end
if dy > 0
%     map1c(:,1:end-dy,:) = map1c(:,1+dy:end,:);
%     map2c(:,1:end-dy,:) = map2c(:,1:end-dy,:);
%     topo1c(:,1:end-dy,:) = topo1c(:,1+dy:end,:);
%     topo2c(:,1:end-dy,:) = topo2c(:,1:end-dy,:);
%     imap1c(:,1:end-dy,:) = imap1c(:,1+dy:end,:);
%     imap2c(:,1:end-dy,:) = imap2c(:,1:end-dy,:);

    map1c = map1c(:,1+dy:end,:);
    map2c = map2c(:,1:end-dy,:);
    topo1c = topo1c(:,1+dy:end,:);
    topo2c = topo2c(:,1:end-dy,:);
    imap1c = imap1c(:,1+dy:end,:);
    imap2c = imap2c(:,1:end-dy,:);
end

img_plot3(topo1c);
img_plot3(topo2c);

[nx, ny, ne] = size(map1c);

Y = zeros(nx, ny);
YZ = zeros(nx, ny);
YT = zeros(nx, ny);
cohmap = zeros(nx,ny,3);
dmap = zeros(nx,ny,ne);
dimap = zeros(nx,ny,ne);
nmap1 = zeros(nx,ny,ne);
nmap2 = zeros(nx,ny,ne);

for i=1:nx
    for j=1:ny
%         Y(i,j) = sum(abs( map1c(i,j,zlayer-1:zlayer+1) - map2c(i,j,zlayer-1:zlayer+1) ));
%         YZ(i,j) = sum(abs(map1c(i,j,zlayer-1:zlayer+1)- map2c(i,j,zlayer-1:zlayer+1))./...
%             (abs(map1c(i,j,zlayer-1:zlayer+1))+abs(map2c(i,j,zlayer-1:zlayer+1))));
        Y(i,j) = sum(sqrt( abs( map1c(i,j,:).^2 - map2c(i,j,:).^2 )));
        YZ(i,j) = sum(abs( map1c(i,j,:) - map2c(i,j,:) ));
        YT(i,j) = sum(abs(topo1c(i,j,:)-topo2c(i,j,:)));
        spec1(1:ne)=map1c(i,j,:);
%         spec1 = spec1 / max(spec1);
        spec2(1:ne)=map2c(i,j,:);
%         spec2 = spec2 /max(spec2);
        nmap1(i,j,:) = spec1;
        nmap2(i,j,:) = spec2;
%         spec = spec/max(spec);
%         cohmap(i,j,1) = (sum(spec(6:8))/3 + sum(spec(14:16))/3)/2 - sum(spec(10:12))/3; 
%         cohmap(i,j,2) = sum(spec(6:8))/3; 
%         cohmap(i,j,3) = sum(spec(14:16))/3; 
        dmap(i,j,:) = abs(map1c(i,j,:) - map2c(i,j,:));
        dimap(i,j,:) = abs(imap1c(i,j,:) - imap2c(i,j,:));
    end
end

% for i=1:ne
% %     img_plot2(dmap(:,:,i));
% %     title('LDOS');
% %     img_plot2(dimap(:,:,i));
% %     title('I');
%     dmap(:,:,i) = dmap(:,:,i) / mean(mean(dmap(:,:,i)));
% end

for i=1:floor(ne/2)
    testmap1(:,:,i) = nmap1(:,:,zlayer) - nmap1(:,:,zlayer+i);
    testmap2(:,:,i) = nmap2(:,:,zlayer) - nmap2(:,:,zlayer+i);
    dtestmap(:,:,i) = testmap1(:,:,i) - testmap2(:,:,i);
    testmap3(:,:,i) = nmap1(:,:,zlayer) - nmap1(:,:,zlayer-i);
    testmap4(:,:,i) = nmap2(:,:,zlayer) - nmap2(:,:,zlayer-i);
    dtestmap2(:,:,i) = testmap3(:,:,i) - testmap4(:,:,i);
end


img_plot3(topo1c)
img_plot3(topo2c)
% figure, img_plot4(cohmap(:,:,1))
% title('CohMap_1');
% figure, img_plot4(cohmap(:,:,2))
% title('CohMap_2_neg');
% figure, img_plot4(cohmap(:,:,3))
% title('CohMap_3_pos');
figure, img_plot4(Y)
title('Y');
figure, img_plot4(YZ)
title('YZ');
figure, img_plot4(YT)
title('YT');

end
        