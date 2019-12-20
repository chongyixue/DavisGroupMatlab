function plot_d2idv2_nem_spect(x2,y2,x1,y1,main_title)
%figure; set(gcf,'Color',[1 1 1]);
avg_gap = 30;
x2mod = x2*avg_gap;
x1mod = x1*avg_gap;
hold on;
%figure
plot(x2mod,y2,'b','LineWidth',2); hold on;
plot(x1mod,y1,'r','LineWidth',2);

x1extrem = x1mod(y1 ==max(y1));
x2extrem = x2mod(y2 == max(y2));
x1extrem - x2extrem
hold on; plot([x1extrem x1extrem],get(gca,'ylim'),'r');
hold on; plot([x2extrem x2extrem],get(gca,'ylim'),'b');
%xlim([-1.5 1.5]);
set(gca,'fontsize',16)
title(main_title,'fontsize',16);
xlabel('Energy - \Delta (e)','fontsize',16);
ylabel('d^2I/dV^2 (nS/V)','fontsize',16);
leg = legend('O_y','O_x','Location','SouthEast');
set(leg,'Interpreter','tex');
end