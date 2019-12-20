
%%
q1_lorpar = q1_lorparcomb;
q3_lorpar = q3_lorparcomb;
%%
cut_q3 = cut_q3M;
cut_q1 = cut_q1M;

en = [-1.1, linspace(-0.9,-0.5, 5)];

p = 10;
figure, hold on
for i=1:1:6
    dummy = q1_lorpar(i,1:5);
    [M, Mind] = min(abs(cut_q1.r-dummy(3)));
    
%     dummy2 = q1_lorpar2(i-5+1,1:3);
%     [M, Mind2] = min(abs(cut_q1.r-dummy2(3)));
%     
%     [M, Mind3] = min(abs( cut_q1.r-mean([dummy2(3), dummy(3)]) ));
    
    pcut = cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.2;
    mv = pcut(Mind)+0.05;
%     mv2 = pcut(Mind2)+0.1;
%     mv3 = pcut(Mind3)+0.1;
    plot(cut_q1.r,pcut,'b.-', 'LineWidth', 2);
    cutlabel = strcat(num2str(en(i)), ' meV');
    text(cut_q1.r(end)-0.015, pcut(end-2)+0.03,cutlabel,'FontSize', 14);
    plot(dummy(3), mv,'dr', 'MarkerSize', p,'MarkerFaceColor','r');
%     herrorbar(dummy(3), mv,  dummy(5)/2,'r'); 
%     plot(dummy2(3), mv2,'dm', 'MarkerSize', p,'MarkerFaceColor','m');
%     plot(mean([dummy2(3), dummy(3)]), mv3,'dk', 'MarkerSize', p,'MarkerFaceColor','k');
%      figure, plot(cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

xlabel('q_y [A^{-1}]', 'Fontsize', 20);
axis([0.0 0.12 0.2 2.1]);
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
pos(3:4)=[15,20];
posdiff = posold - pos(3:4);
pos(1:2) = pos(1:2) + posdiff;
set(gcf,'position',pos)
prepprint



%%

figure, hold on
for i=1:1:6
    dummy = q3_lorpar(i,1:5);
    [M, Mind] = min(abs(cut_q3.r-dummy(3)));
    
%     dummy2 = q3_lorpar2(i,1:3);
%     [M, Mind2] = min(abs(cut_q3.r-dummy2(3)));
%     
%     [M, Mind3] = min(abs( cut_q3.r-mean([dummy2(3), dummy(3)]) ));
    
    pcut = cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.35;
    mv = pcut(Mind)+0.1;
%     mv2 = pcut(Mind2)+0.1;
%     mv3 = pcut(Mind3)+0.1;
    plot(cut_q3.r,pcut,'b.-', 'LineWidth', 2);
    cutlabel = strcat(num2str(en(i)), ' meV');
    if i == 1 || i==2 || i==3
        text(cut_q3.r(end)-0.067, pcut(end)+(i*0.075),cutlabel,'FontSize', 14);
    elseif i == 4
        text(cut_q3.r(end)-0.067, pcut(end)+0.25,cutlabel,'FontSize', 14);
    elseif i == 5
        text(cut_q3.r(end)-0.067, pcut(end)+0.225,cutlabel,'FontSize', 14);
    elseif i == 6
        text(cut_q3.r(end)-0.067, pcut(end)+0.35,cutlabel,'FontSize', 14);
    end
    plot(dummy(3), mv,'dr', 'MarkerSize', p,'MarkerFaceColor','r');
%     herrorbar(dummy(3), mv,  dummy(5)/2,'r'); 
%      plot(dummy2(3), mv2,'dm', 'MarkerSize', p,'MarkerFaceColor','m');
%     plot(mean([dummy2(3), dummy(3)]), mv3,'dk', 'MarkerSize', p,'MarkerFaceColor','k');
%     figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

xlabel('q_x [A^{-1}]', 'Fontsize', 20);
axis([0.12 0.45 0.15 2.8]);
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
pos(3:4)=[15,20];
posdiff = posold - pos(3:4);
pos(1:2) = pos(1:2) + posdiff;
set(gcf,'position',pos)
prepprint