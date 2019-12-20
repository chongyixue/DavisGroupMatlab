


le = length(rho.ev);
rawrho = rho.arp1;
smooth_rho = rawrho;

for i=2 : le-1
    smooth_rho(i) = (rawrho(i)+rawrho(i-1)+rawrho(i+1)) / 3;
end


smooth_rho = smooth_rho / max(smooth_rho);

ev = rho.ev;
% 
% figure, plot(ev, smooth_rho_3p,'b.','MarkerSize', 16) 
% figure, plot(ev, smooth_rho_4p,'k.','MarkerSize', 16) 
% figure, plot(ev, smooth_rho_5p,'m.','MarkerSize', 16) 

figure(10), clf

plot(ev, smooth_rho,'k.','MarkerSize',25);
hold on
% plot([0 4.5],[0 0],'--k','LineWidth',2);

axes2 = gca;
axes2.XTick = linspace(0,5,6);
% axes2.YTick = linspace(-0.6,1,5);
axes2.YTick = linspace(-1.4,1,7);
% axes2.YTick = linspace(-1,1,6);
% axis([0 4.5 -0.7 1.1]);
% axis([0 4.5 -1.1 1.1]);
axis([0 4.5 -1.5 1.1]);
figw
hold off




