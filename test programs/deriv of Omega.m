%%
st = 30;
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
Spx = find_d2idv2(X1,Y1,4,0.7,10);
Spy = find_d2idv2(X2,Y2,4,0.7,10);
Snx = find_d2idv2(X3,Y3,4,0.7,10);
Sny = find_d2idv2(X4,Y4,4,0.7,10);
%%
plot_d2idv2_nem_spect(Spy.dx-Spy.gap_pk_pt,Spy.dy,Spx.dx-Spx.gap_pk_pt,Spx.dy,'Positive Nematicity - Shift in \Omega');
plot_d2idv2_nem_spect(Sny.dx-Sny.gap_pk_pt,Sny.dy,Snx.dx-Snx.gap_pk_pt,Snx.dy,'Negative Nematicity - Shift in \Omega');
%% Y1 spectra
l_Y1 = length(Y1);
frac_peak = 0.7;
peak_val1 = max(Y1);
min_val1 = min(Y1);
min_val1_ind = find(Y1==min_val1,1,'last');
frac_val1 = (peak_val1 - min_val1)*frac_peak + min_val1;
% find set indices which satisfy being larger that frac_val and
% on the right side of the minimum
frac_peak_ind1 = find((Y1>=frac_val1).*(X1>=X1(min_val1_ind)) == 1,1);
kstart = 1; kend = l_Y1 - frac_peak_ind1 + 1 ;
v = X1(kstart:end-kend); 
w = Y1(kstart:end-kend); w = w';    
figure; plot(v,w);
%%
degree_poly = 4;
res = 10;
[p S] = polyfit(v,w',degree_poly);
% generate fine spacing fit
spc = mean(abs(diff(v)));            
v_refine = v(1):spc/res:v(end);
f = polyval(p,v_refine,S);
 hold on; plot(v_refine,f,'r')
% calc 2nd derivative from fit to find inflection points
%%
[df2 dv2] = num_der2b(2,f,v_refine);
%find the minimum point on the fit
min_fval_ind = find(f == min(f),1);
%figure; plot(dx2,df2)
inflect_index = find_zero_crossing(df2);
v_refine(inflect_index)

%% Y2 spectra
l_Y2 = length(Y2);
frac_peak = 0.7;
peak_val2 = max(Y2);
min_val2 = min(Y2);
min_val2_ind = find(Y2==min_val2,1,'last');
frac_val2 = (peak_val2 - min_val2)*frac_peak + min_val2;
% find set indices which satisfy being larger that frac_val and
% on the right side of the minimum
frac_peak_ind2 = find((Y2>=frac_val2).*(X2>=X2(min_val2_ind)) == 1,1);
kstart = 1; kend = l_Y2 - frac_peak_ind2 + 1 ;
v = X1(kstart:end-kend); 
w = Y2(kstart:end-kend); w = w';    
figure; plot(v,w);
%%
degree_poly = 4;
res = 10;
[p S] = polyfit(v,w',degree_poly);
% generate fine spacing fit
spc = mean(abs(diff(v)));            
v_refine = v(1):spc/res:v(end);
f = polyval(p,v_refine,S);
 hold on; plot(v_refine,f,'r')
% calc 2nd derivative from fit to find inflection points
%%
[df2 dv2] = num_der2b(2,f,v_refine);
%find the minimum point on the fit
min_fval_ind = find(f == min(f),1);
%figure; plot(dx2,df2)
inflect_index = find_zero_crossing(df2);
v_refine(inflect_index)



%%
figure; plot(X1,Y1,'b'); hold on; plot(X2,Y2,'r');
%%
xlim([-3.2 0]);
[p S] = polyfit(X1,Y1,19);
f = polyval(p,X1);
%figure; plot(X1,Y1,'x'); hold on;  plot(X1,f,'r');
xlim([-3.2 0]);
[dY1 dX1] = num_der2b(1,Y1,X1);
[dY2 dX2] = num_der2b(1,Y2,X2);
[df dx] = num_der2b(1,f,X1);
figure; plot(dX1,dY1); hold on; plot(dX2,dY2,'r');
%hold on; plot(dx,df,'g');
xlim([-3.2 0]);
%%
x(y1 == max(y1))
%%
xx = x(84:125); yy = y1(84:125);
xx = xx - x(y1 == max(y1));
%figure; plot(xx,yy);
yy2 = yy(~isnan(yy));
xx2 = xx(~isnan(yy));
%figure; plot(xx2,yy2,'r');
%%
[dy dx] = num_der2b(2,yy2,xx2);
figure; plot(dx,dy);
%%

[p1 S] = polyfit(xx2',yy2,4);
% generate fine spacing fit
f1 = polyval(p1,xx2);
figure; plot(xx2,f1);
%%
[df1 dx1] = num_der2b(1,f,xx2);
figure; plot(dx1,df1);
%%
x(y2 == max(y2))
%%
xx = x(84:125); y2y = y2(84:125);
xx = xx - x(y2 == max(y2));
%figure; plot(xx,y2y);
y2y2 = y2y(~isnan(y2y));
xx2 = xx(~isnan(y2y));
%figure; plot(xx2,y2y2,'r');
%%
[p2 S] = polyfit(xx2',y2y2,4);
% generate fine spacing fit
f2 = polyval(p2,xx2);
figure; plot(xx2,f2);
%%
[df2 dx2] = num_der2b(1,f,xx2);
figure; plot(dx2,df2);
%%
figure; plot(dx2,df2,'r'); hold on; plot(dx1,df1);

%%