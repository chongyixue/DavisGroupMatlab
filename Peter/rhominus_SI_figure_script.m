

le = length(rho_3pxl.ev);
rawrho_3p = rho_3pxl.arp1;
smooth_rho_3p = rawrho_3p;

for i=2 : le-1
    smooth_rho_3p(i) = (rawrho_3p(i)+rawrho_3p(i-1)+rawrho_3p(i+1)) / 3;
end

le = length(rho_4pxl.ev);
rawrho_4p = rho_4pxl.arp1;
smooth_rho_4p = rawrho_4p;

for i=2 : le-1
    smooth_rho_4p(i) = (rawrho_4p(i)+rawrho_4p(i-1)+rawrho_4p(i+1)) / 3;
end

le = length(rho_5pxl.ev);
rawrho_5p = rho_5pxl.arp1;
smooth_rho_5p = rawrho_5p;

for i=2 : le-1
    smooth_rho_5p(i) = (rawrho_5p(i)+rawrho_5p(i-1)+rawrho_5p(i+1)) / 3;
end


smooth_rho_3p = smooth_rho_3p / max(abs(smooth_rho_3p));
smooth_rho_4p = smooth_rho_4p / max(abs(smooth_rho_4p));
smooth_rho_5p = smooth_rho_5p / max(abs(smooth_rho_5p));

ev = rho_3pxl.ev;
% 
figure, plot(ev, smooth_rho_3p,'b.','MarkerSize', 16) 
figure, plot(ev, smooth_rho_4p,'k.','MarkerSize', 16) 
figure, plot(ev, smooth_rho_5p,'m.','MarkerSize', 16) 

figure(1), clf

plot(ev, smooth_rho_3p,'b.','MarkerSize',25);
hold on
% plot([0 4.5],[0 0],'--k','LineWidth',2);

axes2 = gca;
axes2.XTick = linspace(0,5,6);
% axes2.YTick = linspace(-0.6,1,5);
axes2.YTick = linspace(-1,1,6);
% axis([0 4.5 -0.7 1.1]);
axis([0 4.5 -1.1 1.1]);
figw
hold off

figure(2), clf

plot(ev, smooth_rho_4p,'k.','MarkerSize',25);
hold on
% plot([0 4.5],[0 0],'--k','LineWidth',2);

axis([0 4.5 -1.5 1.1]);
axes2 = gca;
axes2.XTick = linspace(0,5,6);
% axes2.YTick = linspace(-0.6,1,5);
% axes2.YTick = linspace(-1,1,6);
% axes2.YTick = linspace(-1,1,6);
axes2.YTick = linspace(-1.4,1,7);
% axis([0 4.5 -0.7 1.1]);
% axis([0 4.5 -1.1 1.1]);
% axis([0 4.5 -16 26]);
% axis([0 4.5 -1.5 1.1]);

figw
hold off

% figure(3), clf
% 
% plot(ev, smooth_rho_5p,'m.','MarkerSize',25);
% hold on
% % plot([0 4.5],[0 0],'--k','LineWidth',2);
% 
% axes2 = gca;
% axes2.XTick = linspace(0,5,6);
% % axes2.YTick = linspace(-0.6,1,5);
% axes2.YTick = linspace(-1,1,6);
% % axis([0 4.5 -0.7 1.1]);
% axis([0 4.5 -1.1 1.1]);
% figw
% hold off
% 
% figure(3), clf
% 
% plot(ev, smooth_rho_3p,'c.', ev, smooth_rho_4p,'k.',ev, smooth_rho_5p,'m.','MarkerSize',25);
% hold on
% plot([0 4.5],[0 0],'--k','LineWidth',2);
% 
% axes2 = gca;
% axes2.XTick = linspace(0,5,6);
% axes2.YTick = linspace(-0.6,1,5);
% % axes2.YTick = linspace(-1,1,6);
% axis([0 4.5 -0.7 1.1]);
% % axis([0 4.5 -1.1 1.1]);
% figw
% hold off