% load('/Users/andreykostin/Documents/hres SC spec.mat');
figure(10), clf
hold on
eg = S_Gamma.energy;
gspec = S_Gamma.avg / max(S_Gamma.avg);
em = S_M.energy;
mspec = S_M.avg / max(S_M.avg);

emp = S_60502A02_Mtip.energy;
mpspec = S_60502A02_Mtip.avg / max(S_60502A02_Mtip.avg);

plot(eg,gspec,'.k', em, mspec, '.r', emp, mpspec, '.b','MarkerSize',20);
ax1 = gca;
ax1.YTick = linspace(0,1,5);
ax1.XTick = linspace(-4,4,9);
axis([-5 5 -0.05 1.05]);
plot([-5 5],[0 0],'--k','LineWidth',2);
figw
box on
hold off


figure(11), clf
hold on

plot(eg,gspec,'.k', em, mspec, '.r', emp, mpspec, '.b','MarkerSize',20);
ax1 = gca;
ax1.YTick = linspace(0,0.25,6);
ax1.XTick = linspace(-1,1,9);
axis([-1 1 -0.05 0.25]);
plot([-1 1],[0 0],'--k','LineWidth',2);
figw
box on
hold off