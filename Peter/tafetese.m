function [Y,YZ,cohmap,dmap,dimap,YT,nidx,nidy,ytm]=tafetese(tdata1,tdata2,a1,a2,isize,data1,data2,cdata1,cdata2)

le = length(data1.e);

for j = 1:le
    if data1.e(j) == 0
        zlayer = j;
    end
end



load_color;

dx = a1(1) - a2(1);
dy = a1(2) - a2(2);


topo1 = tdata1.map;
topo2 = tdata2.map;
itopo1 = imresize(topo1, [isize isize], 'bicubic');
itopo2 = imresize(topo2, [isize isize], 'bicubic');

range = tdata1.info.xdist / (size(topo1,1)+1);
irange = tdata1.info.xdist / (isize+1);

idx = round(dx*range/irange);
idy = round(dy*range/irange);

% [nx, ny] = size(topo1);
[inx, iny] = size(itopo1);


% topo1c = zeros(nx,ny);
% topo2c = zeros(nx,ny);
itopo1c = zeros(inx,iny);
itopo2c = zeros(inx,iny);

ll = 5;
icx = round((2*round(ll/irange)+1)/2);
icy = round((2*round(ll/irange)+1)/2);
cms = 2*round(ll/irange)+1;
cm = circlematrix(cms,round(ll/irange),...
    icx,icy);
cm = double(cm);
figure, imagesc(cm), axis image

tc =1;
for i=1:cms
    for j=1:cms
        if cm(i,j) ==1;
            nidx(tc) = idx + i - icx;
            nidy(tc) = idy + j - icy;
            tc = tc+1;
        end
    end
end

tc = tc-1;


tic

for k=1:tc
    if nidx(k) < 0
        itopo1c(1-nidx(k):end,:,:) = itopo1(1:end+nidx(k),:,:);
        itopo2c(1-nidx(k):end,:,:) = itopo2(1-nidx(k):end,:,:);
    end
    if nidx(k) > 0
        itopo1c(1:end-nidx(k),:,:) = itopo1(1+nidx(k):end,:,:);
        itopo2c(1:end-nidx(k),:,:) = itopo2(1:end-nidx(k),:,:);
    end
    if nidy(k) < 0 
        itopo1c(:,1-nidy(k):end,:) = itopo1c(:,1:end+nidy(k),:);
        itopo2c(:,1-nidy(k):end,:) = itopo2c(:,1-nidy(k):end,:);
    end
    if nidy(k) > 0
        itopo1c(:,1:end-nidy(k),:) = itopo1c(:,1+nidy(k):end,:);
        itopo2c(:,1:end-nidy(k),:) = itopo2c(:,1:end-nidy(k),:);
    end

    for i=1:inx
        for j=1:iny
            YT(i,j,k) = sum(abs(itopo1c(i,j,:)-itopo2c(i,j,:)));
            
        end
    end
%     figure, img_plot4(YT(:,:,k))
    ytm(k) = sum(sum(YT(:,:,k)));
    test = 1;
    toc
end

[mi, mind] = min(ytm);
figure, img_plot4(YT(:,:,mind))
toc

%%
map1 = data1.map;
map2 = data2.map;
cmap1 = cdata1.map;
cmap2 = cdata2.map;

[nx, ny, ne] = size(map1);

imap1 = zeros(isize,isize,ne);
imap2 = zeros(isize,isize,ne);
icmap1 = zeros(isize,isize,ne);
icmap2 = zeros(isize,isize,ne);

for i=1:ne
    imap1(:,:,i) = imresize(map1(:,:,i), [isize isize], 'bicubic');
    imap2(:,:,i) = imresize(map2(:,:,i), [isize isize], 'bicubic');
    icmap1(:,:,i) = imresize(cmap1(:,:,i), [isize isize], 'bicubic');
    icmap2(:,:,i) = imresize(cmap2(:,:,i), [isize isize], 'bicubic');
end

%%
[inx, iny] = size(imap1);

imap1c = zeros(inx,inx,ne);
imap2c = zeros(inx,inx,ne);
icmap1c = zeros(inx,inx,ne);
icmap2c = zeros(inx,inx,ne);

    if nidx(mind) < 0
        imap1c(1-nidx(mind):end,:,:) = imap1(1:end+nidx(mind),:,:);
        imap2c(1-nidx(mind):end,:,:) = imap2(1-nidx(mind):end,:,:);
        icmap1c(1-nidx(mind):end,:,:) = icmap1(1:end+nidx(mind),:,:);
        icmap2c(1-nidx(mind):end,:,:) = icmap2(1-nidx(mind):end,:,:);
    end
    if nidx(mind) > 0
        imap1c(1:end-nidx(mind),:,:) = imap1(1+nidx(mind):end,:,:);
        imap2c(1:end-nidx(mind),:,:) = imap2(1:end-nidx(mind),:,:);
        icmap1c(1:end-nidx(mind),:,:) = icmap1(1+nidx(mind):end,:,:);
        icmap2c(1:end-nidx(mind),:,:) = icmap2(1:end-nidx(mind),:,:);
    end
    if nidy(mind) < 0 
        imap1c(:,1-nidy(mind):end,:) = imap1c(:,1:end+nidy(mind),:);
        imap2c(:,1-nidy(mind):end,:) = imap2c(:,1-nidy(mind):end,:);
        icmap1c(:,1-nidy(mind):end,:) = icmap1c(:,1:end+nidy(mind),:);
        icmap2c(:,1-nidy(mind):end,:) = icmap2c(:,1-nidy(mind):end,:);
    end
    if nidy(mind) > 0
        imap1c(:,1:end-nidy(mind),:) = imap1c(:,1+nidy(mind):end,:);
        imap2c(:,1:end-nidy(mind),:) = imap2c(:,1:end-nidy(mind),:);
        icmap1c(:,1:end-nidy(mind),:) = icmap1c(:,1+nidy(mind):end,:);
        icmap2c(:,1:end-nidy(mind),:) = icmap2c(:,1:end-nidy(mind),:);
    end
    
%%    

Y = zeros(inx, inx);
YZ = zeros(inx, inx);
YT = zeros(inx, inx);
cohmap = zeros(inx,inx,3);
dmap = zeros(inx,inx,ne);
dimap = zeros(inx,inx,ne);

for i=1:inx
    for j=1:inx
        Y(i,j) = sum(abs( imap1c(i,j,zlayer-1:zlayer+1) - imap2c(i,j,zlayer-1:zlayer+1) ));
        YZ(i,j) = sum(abs(imap1c(i,j,zlayer-1:zlayer+1)- imap2c(i,j,zlayer-1:zlayer+1))./(abs(imap1c(i,j,zlayer-1:zlayer+1))+abs(imap2c(i,j,zlayer-1:zlayer+1))));
%         YZ(i,j) = sum(sqrt( abs( map1c(i,j,:).^2 - map2c(i,j,:).^2 )));
%         YZ(i,j) = sum(abs( map1c(i,j,11) - map2c(i,j,11) ));
        YT(i,j) = sum(abs(itopo1c(i,j,:)-itopo2c(i,j,:)));
        spec(1:ne)=imap1c(i,j,:);
%         spec = spec/max(spec);
%         cohmap(i,j,1) = (sum(spec(6:8))/3 + sum(spec(14:16))/3)/2 - sum(spec(10:12))/3; 
%         cohmap(i,j,2) = sum(spec(6:8))/3; 
%         cohmap(i,j,3) = sum(spec(14:16))/3; 
        dmap(i,j,:) = abs(imap1c(i,j,:) - imap2c(i,j,:));
        dimap(i,j,:) = abs(icmap1c(i,j,:) - icmap2c(i,j,:));
    end
end

img_plot3(itopo1c)
img_plot3(itopo2c)
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
        