avg_gap1 = 0;
count = 0
for i = 1:length(r)
    if (c(i) <=125 && r(i) <= 125)
        count = count + 1;
        avg_gap1 = avg_gap1 + gap_tot(c(i),r(i));
    end
end
avg_gap1 = avg_gap1/count
%%
topo = row_subt(T.map);
%%
[c r] = find(topo <= -0.035);
img_plot(topo); hold on;
plot(r,c, 'rx');
img_plot(egap_1,Cmap.Defect1); hold on; plot(r,c,'mx');
img_plot(dH,Cmap.Defect1); hold on; plot(r,c,'mx');
%%
count = 0
avg_gap1 = 0;
avg_height1 = 0;
for i = 1:length(r)
    %if (c(i) <=125 && r(i) <= 125)
        count = count + 1;
        avg_gap1 = avg_gap1 + egap_1(r(i),c(i));
        avg_height1 = avg_height1 + dH(r(i),c(i));
    %end
end
avg_gap1 = avg_gap1/count
avg_height1 = avg_height1/count
%%
st_pt = 1;
end_pt = 29;
x = G.e(st_pt:end_pt)*1000;
y = squeeze(squeeze(G.map(256,12,st_pt:end_pt)));

%%
res = 0.001;
xfine = x(st_pt):res:x(end_pt);
%y = G_data.ave; y = y';        
[p,S]= polyfit(x(st_pt:end_pt),y(st_pt:end_pt)',20);                   
y2 = polyval(p,xfine);                            
x0 = xfine(y2 == max(y2(1:end)));                               
figure; plot(x,y); hold on; plot(xfine,y2,'g'); hold on; plot([x0 x0],get(gca,'ylim'),'g'); %xlim([-5 2])
%%       

x00 = findpeaks(xtest,ytest,0.0066,28,1,3);
figure; plot(xtest,ytest);
 hold on; plot([x00(1,2),x00(1,2)],get(gca,'ylim'),'r');
y = ytest; x = xtest;
%%
ind = 530;
ytest = squeeze(squeeze(G.map(r(ind),c(ind),:)));
xtest = G.e*1000;
figure; plot(xtest,ytest);
hold on; plot([gap_map2(r(ind),c(ind)) gap_map2(r(ind),c(ind))] ,get(gca,'ylim'));
%%
res = 0.001;
xfinetest = xtest(st_pt):res:xtest(end_pt);
%y = G_data.ave; y = y';        
[p,S]= polyfit(xtest(st_pt:end_pt),ytest(st_pt:end_pt)',20);                   
y2test = polyval(p,xfine);                            
x0test = xfinetest(y2test == max(y2test(600:end-500)));                               
figure; plot(xtest,ytest); hold on; plot(xfinetest,y2test,'g'); hold on; plot([x0test x0test],get(gca,'ylim'),'g'); %xlim([-5 2])
%% 
x = G.e*1000; y = squeeze(squeeze(G.map(62,111,:)));
figure; plot(x,y);
%%
x = G.e(19:36)*1000; y = squeeze(squeeze(G.map(62,111,19:36))); 
figure; plot(x,y)
figure; plot(x, max(y) - y);
 y = max(y) - y;
%% find bottom of the gap
b1 = 19; b2= 36;
xb = G.e(b1:b2)*1000;
[nr nc nz] = size(G.map);
bottom = zeros(nr,nc);
for i = 1:nr
    i
    for j = 1:nc
         yb = squeeze(squeeze(G.map(i,j,b1:b2)));
         tmp = xb(yb == min(yb));
         bottom(i,j) = tmp(1);                  
    end
end
img_plot2(bottom,Cmap.Defect1,'gap minimum: iter 1');
clear i j tmp yb xb nr nc nz b1 b2;
%% find bottom of the gap 2
b1 = 19; b2= 36;
xtmp = G.e(b1:b2)*1000;
[nr nc nz] = size(G.map);
bottom2 = bottom;
std_bottom = std(reshape(bottom,nr*nc,1));
mean_bottom = mean(mean(bottom));
[r_bot c_bot] = find(bottom <= mean_bottom - 2*std_bottom);
ind = length(c_bot);
count_inter2 = 0;
for n = 1:ind        
    n
    ytmp = squeeze(squeeze(G.map(r_bot(n),c_bot(n),b1:b2)));
    new_peak = findpeaks(xtmp,max(ytmp) - ytmp, 0.014,1,1,3);
    if new_peak(1,2) ~= bottom(r_bot(n),c_bot(n))
        count_inter2 = count_inter2 +1;
    end
    bottom2(r_bot(n),c_bot(n)) = new_peak(1,2);
end
img_plot2(bottom2,Cmap.Defect1,'gap minimum: inter 2');
clear new_peak ind mean_bottom std_bottom xtmp ytmp n nr nc nz b1 b2
%%
b1 = 19; b2= 36;
xb = G.e(b1:b2)*1000;
yb = squeeze(squeeze(G.map(187,132,b1:b2)));
x00 = findpeaks(xb,max(yb) - yb, 0.014,1,1,3);
figure; plot(xb,yb); figure; plot(xb,max(yb) - yb);
x = xb; y = max(yb) - yb;
%% find points at which have gap values that are very high
mean_bottom2 = mean(mean(bottom2)); std_bottom2 = std(reshape(bottom2,256*256,1));
[r_bot_u c_bot_u] = find(bottom2 >= mean_bottom2 + 3.5*std_bottom2);
img_plot2(bottom2,Cmap.Defect1,'bottom2 + errs'); 
hold on; plot(c_bot_u,r_bot_u,'mx');
%%
n = 70;
b1 = 19; b2= 36;
xb = G.e(b1:b2)*1000;
yb = squeeze(squeeze(G.map(r_bot_u(n),c_bot_u(n),b1:b2)));
x00 = findpeaks(xb,max(yb) - yb, 0.014,1,1,3);
figure; plot(xb,yb); figure; plot(xb,max(yb) - yb);
x = xb; y = max(yb) - yb;
%%
b1 = 19; b2= 36;
xtmp = G.e(b1:b2)*1000;
bottom2_a = bottom2;
std_bottom2 = std(reshape(bottom2,256*256,1));
mean_bottom2 = mean(mean(bottom2));
[r_bot_u c_bot_u] = find(bottom2 >= mean_bottom2 + 3.5*std_bottom2);
ind = length(c_bot_u);
count = 0;
for n = 1:ind        
    n
    ytmp = squeeze(squeeze(G.map(r_bot_u(n),c_bot_u(n),b1:b2)));
    %figure; plot(xtmp,ytmp);
    new_peak = findpeaks(xtmp,max(ytmp) - ytmp, 0.014,1,1,3);
    if new_peak(end,2) ~= bottom2(r_bot(n),c_bot(n))
        count = count +1;
    end
    bottom2_a(r_bot_u(n),c_bot_u(n)) = new_peak(end,2);
end
img_plot2(bottom2,Cmap.Defect1,'bottom2');
img_plot2(bottom2 - bottom2_a,Cmap.Defect1,'bottom2 - bottom2_a');
%% test out findpeak
st_pt = 1;
end_pt = find(G.e*1000 == bottom(256,12));
x = G.e(st_pt:end_pt)*1000;
y = squeeze(squeeze(G.map(256,12,st_pt:end_pt)));
x00 = findpeaks(x,y,0.01,28,1,3);
pk = x00(end,2);
%%
pk = zeros(256,256);
st_pt = 1;
for i = 1:256
    i
    for j= 1:256
        end_pt = find(G.e*1000 == bottom(i,j));
        x = G.e(st_pt:end_pt)*1000;
        y = squeeze(squeeze(G.map(i,j,st_pt:end_pt)));
        x00 = findpeaks(x,y,0.01,28,1,3);
        pk(i,j) = x00(end,2);
    end
end
img_plot(pk,Cmap.Defect1);