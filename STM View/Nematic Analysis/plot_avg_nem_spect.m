function plot_avg_nem_spect(x,y1,y2,main_title)
figure; set(gcf,'Color',[1 1 1]);
plot(x,y1,'b','LineWidth',2); hold on;
plot(x,y2,'r','LineWidth',2);
%xlim([-1.5 1.5]);
set(gca,'fontsize',16)
title(main_title,'fontsize',16);
xlabel('Energy (e)','fontsize',16);
ylabel('Conductance (nS)','fontsize',16);
leg = legend('O_y','O_x','Location','SouthEast');
set(leg,'Interpreter','tex');
end