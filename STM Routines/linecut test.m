%% Azimuthally averaged data plot
figure;
for i=6:22
    plot(qscaled(30:70),cut1(30:70,i)' + i*90,'b','Linewidth',1.5)
    hold on;
end
for i=23:28
    plot(qscaled(30:70),cut1(30:70,i)' + i*90,'k','Linewidth',1.5)
    hold on;
end
for i=29:71
    plot(qscaled(20:70),cut1(20:70,i)' + i*90,'r','Linewidth',1.5)
    hold on;
end
%%
figure;
for i=15:22
    plot(qlow(20:70),cutl(20:70,i) + i*70,'Linewidth',1.5);
    hold on;
end
%%
figure;
for i=25:34
    plot(qhigh(25:70),cuth(25:70,i) + i*70,'Linewidth',1.5);
    hold on;
end
%%
figure; errorbar(low_band(:,1),low_band(:,2),low_band(:,3),'x');
hold on;
errorbar(high_band(:,1),high_band(:,2),high_band(:,3),'x');

%% LOW BAND QPI FITS
qpi = 'a*exp(b*x^1 + z) + d*exp(-(x-f)^2/(2*s^2)) + c';
qpi = 'a*exp(b*x^1 + z) + d*0.5*s/((x-f)^2 + (0.5*s)^2) + c';
%qpi = 'a*x^3 + b*x^2 + c*x + d';
x = qlow(19:70);
y = cutl(19:70,14);

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[300 -0.01 100 100 0.3  0.05 1],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',50000,...
    'MaxFunEvals', 50000);

f = fittype(qpi,'options',s);
[p,gof] = fit(x',y,f);
param = p;

x2 = min(x):0.001:max(x);
y2 = p.a.*exp(p.b*x2.^1 + p.z) + p.d.*exp(-(x2-p.f).^2./(2*p.s.^2)) + p.c;
y2 = p.a.*exp(p.b*x2.^1 + p.z) + p.d.*0.5*p.s./((x2-p.f).^2 + (0.5*p.s).^2) + p.c;
figure;
plot(x2,y2)
hold on;
plot(x,y,'rx')
p
%% LOW BAND FITS with WINDOW OPTIMIZATION

qpi = 'a*exp(b*x^1 + z) + d*0.5*s/((x-f)^2 + (0.5*s)^2) + c';
%qpi = 'a*x^3 + b*x^2 + c*x + d';
x = qlow(19:70);
y = cutl(19:70,10);

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[300 -0.01 100 100 0.3  0.05 1],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',50000,...
    'MaxFunEvals', 50000);

f = fittype(qpi,'options',s);
%for i = 15:20
[p,gof] = fit(x',y,f);
param = p;

x2 = min(x):0.001:max(x);
y2 = p.a.*exp(p.b*x2.^1 + p.z) + p.d.*0.5*p.s./((x2-p.f).^2 + (0.5*p.s).^2) + p.c;
figure;
plot(x2,y2)
hold on;
plot(x,y,'rx')
p
%% LOW BAND AUTOMATED BAND FITS

qpi = 'a*exp(b*x^1 + z) + d*exp(-(x-f)^2/(2*s^2)) + c';
qpi = 'a*exp(b*x^1 + z) + d*0.5*s/((x-f)^2 + (0.5*s)^2) + c';

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[300 -12 150 250 0.3  0.05 2.0],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',50000,...
    'MaxFunEvals', 50000);

fo = fittype(qpi,'options',s);
x = qlow(18:70);
for i = 6:22
    i
    y = cutl(18:70,i);
    [p gof] = fit(x',y,fo);
    paramslow(i-5) = p.f;
end
%%
figure; plot (paramslow(2:end),Low.e(7:22),'x');

%%
hold on;
for i=6:22
    plot(qlow(15:45),cutl(15:45,i) + i*90,'Linewidth',1.5);
    hold on;
end
for i = 7:22
    plot (qlow(15:45),paramslow(i-5),'rx');
end
%% HIGH BAND QPI ANALYSIS
qpi = 'a*exp(b*x^1 + z) + d*exp(-(x-f)^2/(2*s^2)) + c';
%qpi = 'a*x^3 + b*x^2 + c*x + d';
x = qhigh(15:70);
y = cuth(15:70,6);

s = fitoptions('Method','NonlinearLeastSquares',...
    'Startpoint',[300 -0.18 -5000 180 0.3  0.02 3],...
    'Algorithm','Levenberg-Marquardt',...
    'TolX',1e-6,...
    'MaxIter',100000,...
    'MaxFunEvals', 100000);

f = fittype(qpi,'options',s);
[p,gof] = fit(x',y,f);
param = p;

x2 = min(x):0.001:max(x);
y2 = p.a.*exp(p.b*x2.^1 + p.z) + p.d.*exp(-(x2-p.f).^2./(2*p.s.^2)) + p.c;
figure;
plot(x2,y2)
hold on;
plot(x,y,'rx')
