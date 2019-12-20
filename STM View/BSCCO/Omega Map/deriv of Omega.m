%%
st = 20;
x = avg_spct.e(st:end);
y1 = avg_spct.spct(st:end,1);
y2 = avg_spct.spct(st:end,2);
y3 = avg_spct.spct(st:end,3);
y4 = avg_spct.spct(st:end,4);

Y1 = y1(~isnan(y1));
X1 = x(~isnan(y1))';

Y2 = y2(~isnan(y2));
X2 = x(~isnan(y2))';

Y3 = y3(~isnan(y3));
X3 = x(~isnan(y3))';

Y4 = y4(~isnan(y4));
X4 = x(~isnan(y4))';

figure; plot(X1,Y1,'r'); hold on; plot(X2,Y2,'b');
figure; plot(X3,Y3,'r'); hold on; plot(X4,Y4,'b');

%%
Spx = find_d2idv2(X1,Y1,4,0.5,10);
Spy = find_d2idv2(X2,Y2,4,0.5,10);
Snx = find_d2idv2(X3,Y3,4,0.5,10);
Sny = find_d2idv2(X4,Y4,4,0.5,10);
%%
plot_d2idv2_nem_spect(Spy.dx-Spy.gap_pk_pt,Spy.dy,Spx.dx-Spx.gap_pk_pt,Spx.dy,'Positive Nematicity - Shift in \Omega');
%plot_d2idv2_nem_spect(Sny.dx-Sny.gap_pk_pt,Sny.dy,Snx.dx-Snx.gap_pk_pt,Snx.dy,'Negative Nematicity - Shift in \Omega');
