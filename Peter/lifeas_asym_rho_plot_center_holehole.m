

le = length(rho_7p.ev);
rawrho_7p = rho_7p.arp1;
smooth_rho_7p = rawrho_7p;

for i=2 : le-1
    smooth_rho_7p(i) = (rawrho_7p(i)+rawrho_7p(i-1)+rawrho_7p(i+1)) / 3;
end

le = length(rho_8p.ev);
rawrho_8p = rho_8p.arp1;
smooth_rho_8p = rawrho_8p;

for i=2 : le-1
    smooth_rho_8p(i) = (rawrho_8p(i)+rawrho_8p(i-1)+rawrho_8p(i+1)) / 3;
end

le = length(rho_9p.ev);
rawrho_9p = rho_9p.arp1;
smooth_rho_9p = rawrho_9p;

for i=2 : le-1
    smooth_rho_9p(i) = (rawrho_9p(i)+rawrho_9p(i-1)+rawrho_9p(i+1)) / 3;
end


smooth_rho_7p = smooth_rho_7p / max(abs(smooth_rho_7p));
smooth_rho_8p = smooth_rho_8p / max(abs(smooth_rho_8p));
smooth_rho_9p = smooth_rho_9p / max(abs(smooth_rho_9p));

ev = rho_7p.ev;
% 



figure, clf

plot(ev, smooth_rho_7p,'c.-', ev, smooth_rho_8p,'k.-',ev, smooth_rho_9p,'g.-','MarkerSize',25);
hold on
plot([0 10],[0 0],'--k','LineWidth',2);
legend('7 pxl', '8 pxl', '9pxl');
axes2 = gca;
axes2.XTick = linspace(0,10,11);
axes2.YTick = linspace(-1.1,0.4,6);
% axes2.YTick = linspace(-1,1,6);
axis([0 10 -1.1 0.5]);
% axis([0 4.5 -1.1 1.1]);
figw
hold off
