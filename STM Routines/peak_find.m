[nr nc nz] = size(G2recon.map);
maxp2 = zeros(nr,nc);

for i = 1:nr
    for j=1:nc
        spect =  squeeze(squeeze(G2recon.map(i,j,:)));
        maxp2(i,j) = G2recon.e(find(spect == max(spect)));
    end
end
%%
[nr nc nz] = size(G2.map);
maxp = zeros(nr,nc);
for i = 1:nr
    for j = 1:nc
        p_poly = polyfit(G2.e',squeeze(squeeze(G2.map(i,j,:))),12);
        y = polyval(p_poly,G2.e(1:end));
        maxp(i,j) = G2.e(find(y == max(y)));
        %figure; plot(G2.e',y);
        %hold on;
        %plot (G2.e',squeeze(squeeze(G2.map(i,j,:))),'r');
    end
end
%y = zeros(30,1);
% for i = 1:30
%     y(i) = polyval(G2.e(i),p_poly);
% end
% figure; plot(G2.e,y)

%%
y = zeros(1,61);
for i=1:61
    layer = G.map(:,:,i);
    corc = corrcoef(maxp,layer);
    y(i) = (corc(1,2));
end
figure; plot(G.e*1000,y);
    