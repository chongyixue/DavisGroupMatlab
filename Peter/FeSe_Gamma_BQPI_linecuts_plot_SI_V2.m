
q3_lorparpeak1 = q3_lorpar;
q3_lorparpeak2 = q3_lorpar2;
%%
q1_lorparpeak1 = q1_lorpar;
q1_lorparpeak2 = q1_lorpar2;

%%
cut_q1_plot = cut_q1;
en = linspace(-2.1,-1.0, 12);
cut_q1_plot.cut = cut_q1.cut(:,4:15);
cut_q1_plot.e = cut_q1.e(4:15);

p = 10;
figure, hold on
% for i=5:1:15
for i=1:length(en)
    dummy = q1_lorparcomb(i,1:5);
    [M, Mind] = min(abs(cut_q1_plot.r-dummy(3)));
    

    
    
    pcut = cut_q1_plot.cut(:,i)/max(cut_q1_plot.cut(:,i))+(i-1)*0.5;
%     pcut = cut_q1.cut(:,i)/mean(cut_q1.cut(:,i))+(i-1)*0.75;

    mv = pcut(Mind)+0.1;
    
    pcutnew = sgolayfilt(pcut,3,11);
    plot(cut_q1_plot.r,pcut,'b.-', 'LineWidth', 2, 'MarkerSize', 14);
%     plot(cut_q1.r,pcutnew,'.-' , 'LineWidth', 2);
%     cutlabel = strcat(num2str(en(i)), ' meV');
    
%     text(cut_q1_plot.r(end-6)-0.0025, pcut(end-5)+0.25,cutlabel,'FontSize', 14); 
    
    plot(dummy(3), mv,'dr', 'MarkerSize', p,'MarkerFaceColor','r');
    
    
    herrorbar(dummy(3), mv,  dummy(5)/2,'r'); 
%     plot(dummy2(3), mv2,'dm', 'MarkerSize', p,'MarkerFaceColor','m');
%     plot(mean([dummy2(3), dummy(3)]), mv3,'dk', 'MarkerSize', p,'MarkerFaceColor','k');
%      figure, plot(cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

xlabel('q_y [A^{-1}]', 'Fontsize', 20);
axis([0.065 0.2 0 6.75]);
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
% ax2.XTick = linspace(-0.025,0.175,5);
% ax2.YTick = linspace(-0.025,0.225,5);
box on

%%
set(gcf,'units','centimeters')
pos=get(gcf,'position');
pos=pos(:);
posold = pos(3:4);
pos(3:4)=[7.5,20];
posdiff = posold - pos(3:4);
pos(1:2) = pos(1:2) + posdiff;
set(gcf,'position',pos)
prepprint

%%

en = linspace(-2.3,-1.2, 12);

cut_q3_plot = cut_q3;
en = linspace(-2.1,-1.0, 12);
cut_q3_plot.cut = cut_q3.cut(:,2:13);
cut_q3_plot.e = cut_q3.e(2:13);


figure, hold on
for i=1:1:12
    dummy = q3_lorparcomb(i,1:5);
    [M, Mind] = min(abs(cut_q3_plot.r-dummy(3)));
    
    
    pcut = cut_q3_plot.cut(:,i)/max(cut_q3_plot.cut(:,i))+(i-1)*0.5;
    
    mv = pcut(Mind)+0.12;
    
    
    pcutnew = sgolayfilt(pcut,3,11);
    plot(cut_q3_plot.r,pcut,'b.-', 'LineWidth', 2, 'MarkerSize', 14);
%     plot(cut_q3.r,pcutnew,'.-' , 'LineWidth', 2);
%     cutlabel = strcat(num2str(en(i)), ' meV');
%     text(cut_q1.r(end-6)-0.01, pcut(end-5)+0.15,cutlabel,'FontSize', 14); 
    plot(dummy(3), mv,'dr', 'MarkerSize', p,'MarkerFaceColor','r');
    
    herrorbar(dummy(3), mv,  dummy(5)/2,'r'); 
%      plot(dummy2(3), mv2,'dm', 'MarkerSize', p,'MarkerFaceColor','m');
%     plot(mean([dummy2(3), dummy(3)]), mv3,'dk', 'MarkerSize', p,'MarkerFaceColor','k');
%     figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

xlabel('q_x [A^{-1}]', 'Fontsize', 20);
axis([0.02 0.194 0 6.75]);
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
% ax2.XTick = linspace(-0.025,0.175,5);
% ax2.YTick = linspace(-0.025,0.225,5);
box on

%%
set(gcf,'units','centimeters')
pos=get(gcf,'position');
pos=pos(:);
posold = pos(3:4);
pos(3:4)=[7.5,20];
posdiff = posold - pos(3:4);
pos(1:2) = pos(1:2) + posdiff;
set(gcf,'position',pos)
prepprint