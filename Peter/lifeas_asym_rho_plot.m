

le = length(rho_5p.ev);
rawrho_5p = rho_5p.arp1;
smooth_rho_5p = rawrho_5p;

for i=2 : le-1
    smooth_rho_5p(i) = (rawrho_5p(i)+rawrho_5p(i-1)+rawrho_5p(i+1)) / 3;
end

le = length(rho_6p.ev);
rawrho_6p = rho_6p.arp1;
smooth_rho_6p = rawrho_6p;

for i=2 : le-1
    smooth_rho_6p(i) = (rawrho_6p(i)+rawrho_6p(i-1)+rawrho_6p(i+1)) / 3;
end

le = length(rho_7p.ev);
rawrho_7p = rho_7p.arp1;
smooth_rho_7p = rawrho_7p;

for i=2 : le-1
    smooth_rho_7p(i) = (rawrho_7p(i)+rawrho_7p(i-1)+rawrho_7p(i+1)) / 3;
end


smooth_rho_5p = smooth_rho_5p / max(abs(smooth_rho_5p));
smooth_rho_6p = smooth_rho_6p / max(abs(smooth_rho_6p));
smooth_rho_7p = smooth_rho_7p / max(abs(smooth_rho_7p));

ev = rho_5p.ev;
% 



figure, clf

plot(ev, smooth_rho_5p,'r.-', ev, smooth_rho_6p,'c.-',ev, smooth_rho_7p,'k.-','MarkerSize',25);
hold on
plot([0 10],[0 0],'--k','LineWidth',2);
legend('5 pxl', '6 pxl', '7pxl');
axes2 = gca;
axes2.XTick = linspace(0,10,11);
axes2.YTick = linspace(-0.2,1,6);
% axes2.YTick = linspace(-1,1,6);
axis([0 10 -0.3 1.1]);
% axis([0 4.5 -1.1 1.1]);
figw
hold off
%%


le = length(rho_5p.ev);
rawrho_5p = rho_5p.arp2;
smooth_rho_5p = rawrho_5p;

for i=2 : le-1
    smooth_rho_5p(i) = (rawrho_5p(i)+rawrho_5p(i-1)+rawrho_5p(i+1)) / 3;
end

le = length(rho_6p.ev);
rawrho_6p = rho_6p.arp2;
smooth_rho_6p = rawrho_6p;

for i=2 : le-1
    smooth_rho_6p(i) = (rawrho_6p(i)+rawrho_6p(i-1)+rawrho_6p(i+1)) / 3;
end

le = length(rho_7p.ev);
rawrho_7p = rho_7p.arp2;
smooth_rho_7p = rawrho_7p;

for i=2 : le-1
    smooth_rho_7p(i) = (rawrho_7p(i)+rawrho_7p(i-1)+rawrho_7p(i+1)) / 3;
end


smooth_rho_5p = smooth_rho_5p / max(abs(smooth_rho_5p));
smooth_rho_6p = smooth_rho_6p / max(abs(smooth_rho_6p));
smooth_rho_7p = smooth_rho_7p / max(abs(smooth_rho_7p));

ev = rho_5p.ev;



figure, clf

plot(ev, smooth_rho_5p,'b.-', ev, smooth_rho_6p,'c.-',ev, smooth_rho_7p,'k.-','MarkerSize',25);
hold on
plot([0 10],[0 0],'--k','LineWidth',2);
legend('5 pxl', '6 pxl', '7pxl');
axes2 = gca;
axes2.XTick = linspace(0,10,11);
axes2.YTick = linspace(-1,0.6,5);
% axes2.YTick = linspace(-1,1,6);
axis([0 10 -1.1 0.6]);
% axis([0 4.5 -1.1 1.1]);
figw
hold off