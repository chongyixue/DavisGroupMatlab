%%
bottom = zeros(131,131);
xtmp = e;
for i = 1:131
    i
    for j= 1:131;
        ytmp = squeeze(squeeze(Gcrop.map(i,j,:)));         
        bottom(i,j) = URuSi_bottom_ind(xtmp,ytmp,22,60,1);
    end
end

%%
bottom2 = bottom;


%%
bottom2 = bottom;
std_bottom = std(reshape(bottom,131*131,1));
mean_bottom = mean(mean(bottom));
[r_bot c_bot] = find(bottom <= mean_bottom - 1*std_bottom);
ind = length(c_bot);
count = 0;
for n = 1:ind        
    n
    ytmp = squeeze(squeeze(Gcrop.map(r_bot(n),c_bot(n),:)));
    bottom2(r_bot(n),c_bot(n)) = URuSi_bottom_ind(xtmp,ytmp,24,60,1);    
end
%%
img_plot2(bottom);
%%
yy = squeeze(squeeze(G.map(34,141,:)));
URuSi_bottom_ind(e,yy,25,60,1);

%%
r = 18; c = 150;
yy = squeeze(squeeze(G.map(r,c,:)));
URuSi_pos_edge(e1,yy,bottom1_ind(r,c),2);
%%
r = 197; c = 111;
yy = squeeze(squeeze(G2.map(r,c,:)));
URuSi_top_ind(e2,yy,9,30,0);
%%
peak_h = zeros(256,256);
for i = 1:256
    i
    for j = 1:256
        yy = squeeze(squeeze(G2.map(i,j,:)));
        peak_h(i,j) = yy(top2_ind(i,j));
    end
end
%%
dip_h = zeros(256,256);
for i = 1:256
    i
    for j = 1:256
        yy = squeeze(squeeze(G2.map(i,j,:)));
        dip_h(i,j) = yy(bottom2_ind(i,j));
    end
end
 img_plot2(dip_h);
 
 %%
 r = 23; c = 3;
 x = data.e*1000;
 y = squeeze(squeeze(data.map(r,c,:)));
 URuSi_neg_edge(x,y,top_ind(c,r),1);