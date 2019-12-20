%%
nbin=25;
[gbin binval] = bin_map(gmap,nbin,defect);
for i=1:nbin
    tmp = (gbin == binval(i));
    ctval = ctmap(tmp);
    gmap_ctmap(i,1) = mean(ctval);
    gmap_ctmap(i,2) = std(ctval);
    errorbar(binval(i),gmap_ctmap(i,1),gmap_ctmap(i,2),'.');
    hold on
    clear tmp;
end
%%
x2 = binval(1:12);
y2 = gmap_ctmap(1:12,:);
[p2,S2] = polyfit(x2',abs(y2(:,1)),1);
f2 = polyval(p2,x2);
figure; plot(x2,f2,'b')
hold on
errorbar(x2,abs(y2(:,1)),y2(:,2),'rx');

    