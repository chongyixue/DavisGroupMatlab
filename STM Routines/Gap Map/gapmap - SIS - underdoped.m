%%
y = G.ave';
y = squeeze(squeeze(G.map(75,100,:))); y = y';
[p2,S2]= polyfit(x(80:88),y(80:88),1);
[p1,S1]= polyfit(x(66:71),y(66:71),1);
x0 = (p2(2) - p1(2))/(p1(1) - p2(1));

figure; plot(x,y); hold on; plot(x0,3:0.05:6,'k');
hold on; plot(x(50:end),polyval(p1,x(50:end)),'r'); 
hold on; plot(x(50:end),polyval(p2,x(50:end)),'g');
%%
[nr nc nz] = size(G.map);
gapmap = zeros(nr,nc);
x = G.e*1000;
count = 0;
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G.map(i,j,:))); y = y';
        [p2,S2]= polyfit(x(80:88),y(80:88),1);
        [p1,S1]= polyfit(x(65:70),y(65:70),1);
        x0 = (p2(2) - p1(2))/(p1(1) - p2(1));
        if (abs(x0) > 250 || abs(x0) < 100)
            x0 = 0;
            count = count + 1;
        end
        gapmap(i,j) = x0;
    end
end
figure; pcolor(gapmap); shading flat; colormap(Cmap.Defect1);
%% Fitting SIS UD 55K spectra with a polynomial on the -ve side
x = G.e*1000;
y = G.ave';
%y = squeeze(squeeze(G.map(70,100,:))); y = y';
[p3,S3]= polyfit(x(60:end),y(60:end),6);
figure; plot(x,y); hold on;
hold on; plot(x(50:end),polyval(p3,x(50:end)),'r'); 
%% Gap finding for SIS junction UD 55K
y2 = polyval(p3,x(60:87));
%figure; plot(x(60:87),y2);
[dy2 x2] = num_der2(2,y2,x(60:87));
x0 = x2((abs(dy2)==max(abs(dy2(5:end)))));
figure;
%hold on; plot(x0,0:0.01:1,'k');
hold on; plot(x2,abs(dy2)/max(abs(dy2)),'k')
%% Gap Map using above algorithm
[nr nc nz] = size(G.map);
x = G.e*1000;
count = 0;
gapmap3 = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G.map(i,j,:))); y = y';
        [p3,S3]= polyfit(x(60:end),y(60:end),6);
        y2 = polyval(p3,x(60:87));
        [dy2 x2] = num_der2(2,y2,x(60:87));
        x0 = x2((abs(dy2)==max(abs(dy2(5:end)))));
        gapmap3(i,j) = x0;
    end
end
figure; pcolor(gapmap3); shading flat; colormap(Cmap.Defect1);
clear nr nc nz i j 
%%
[nr nc nz] = size(G.map);
x = G.e*1000;
count = 0;
gapmap3 = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc
        y =  squeeze(squeeze(G.map(i,j,:))); y = y';
        [p3,S3]= polyfit(x(60:end),y(60:end),6);        
        y2 = polyval(p3,x(60):-1:x(87));
        [dy2 x2] = num_der2(2,y2,x(60):-1:x(87));
        x0 = x2((abs(dy2)==max(abs(dy2(15:end)))));
        gapmap3(i,j) = x0;
    end
end
figure; pcolor(gapmap3); shading flat; colormap(Cmap.Defect1);
clear nr nc nz i j 