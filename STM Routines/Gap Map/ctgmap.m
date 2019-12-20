%%
format long;
nbin= 30;
[g_map_bin binval] = bin_map(g_map,nbin,defect);
figure;
ctval =[];
ctval_stat = nan(1,2,nbin);
for i=1:nbin
    tmp = (g_map_bin == binval(i));
    ctval =  ctmap(tmp);
    ctval_stat(1,1,i) = mean(ctval); ctval_stat(1,2,i) = std(ctval);
    errorbar(binval(i),mean(abs(ctval)),std(ctval),'.');
    hold on    
end 
%%
figure; 
c = squeeze(squeeze(abs(ctval_stat(1,1,1:14))));
plot((abs(binval(1:14))),(c'),'r.');
p = polyfit((abs(binval(1:14))),(c'),1);
hold on;
plot((abs(binval(1:14))),p(1)*(abs(binval(1:14))) + p(2));
  
%%
figure; 
ftr = 1000;
c = squeeze(squeeze(abs(ctval_stat(1,1,1:14))));
plot(log((abs(ftr*binval(1:14)))),log(c'),'r.');
p = polyfit((log(abs(ftr*binval(1:14)))),log(c'),1);
hold on;
plot((log(abs(ftr*binval(1:14)))),p(1)*log(abs(ftr*binval(1:14))) + p(2));
%%
t=0.5908;
p = polyfit(t^2./binval(1:14),binval(1:14),1);
figure; plot(t^2./binval(1:14),p(1)*t^2./binval(1:14) + p(2));
hold on;
plot (t^2./binval(1:14),binval(1:14),'ro');