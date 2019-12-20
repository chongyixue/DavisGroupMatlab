
q3_lorparpeak1 = q3_lorpar;
q3_lorparpeak2 = q3_lorpar2;
%%
q1_lorparpeak1 = q1_lorpar;
q1_lorparpeak2 = q1_lorpar2;

%%

en = linspace(-2.1,-1.0, 12);
cut_q1.cut = cut_q1.cut(:,4:15);

p = 10;
figure, hold on
% for i=5:1:15
for i=1:length(en)
    dummy = q1_lorparcomb(i,1:5);
    [M, Mind] = min(abs(cut_q1.r-dummy(3)));
    

    if i == 10
        dummy2 = q1_lorparpeak1(i-4+1,1:5);
        [M, Mind2] = min(abs(cut_q1.r-dummy2(3)));

        dummy3 = q1_lorparpeak2(i-4+1,1:5);
        [M, Mind3] = min(abs(cut_q1.r-dummy3(3)));
    end
    [M, Mind4] = min(abs(cut_q1.r-yg_peter(i-4+1)));
    
    pcut = cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.5;
%     pcut = cut_q1.cut(:,i)/mean(cut_q1.cut(:,i))+(i-1)*0.75;

    mv = pcut(Mind)+0.1;
    mv2 = pcut(Mind2)+0.1;
    mv3 = pcut(Mind3)+0.1;
    mv4 = pcut(Mind4)+0.1;
    pcutnew = sgolayfilt(pcut,3,11);
    plot(cut_q1.r,pcut,'b.-', 'LineWidth', 2);
%     plot(cut_q1.r,pcutnew,'.-' , 'LineWidth', 2);
    cutlabel = strcat(num2str(en(i-4+1)), ' meV');
    if i == 17
        text(cut_q1.r(end-6)-0.0025, pcut(end-5)+0.35,cutlabel,'FontSize', 14); 
    else
        text(cut_q1.r(end-6)-0.0025, pcut(end-5)+0.25,cutlabel,'FontSize', 14); 
    end
    plot(dummy(3), mv,'dr', 'MarkerSize', p,'MarkerFaceColor','r');
    plot(yg_peter(i-4+1), mv4,'+k', 'MarkerSize', p,'MarkerFaceColor','none', 'LineWidth', 2);
    if i == 10
        plot(dummy2(3), mv2,'ok', 'MarkerSize', p,'MarkerFaceColor','none');
        plot(dummy3(3), mv3,'sk', 'MarkerSize', p,'MarkerFaceColor','none');
    end
    
%     herrorbar(dummy(3), mv,  dummy(5)/2,'r'); 
%     plot(dummy2(3), mv2,'dm', 'MarkerSize', p,'MarkerFaceColor','m');
%     plot(mean([dummy2(3), dummy(3)]), mv3,'dk', 'MarkerSize', p,'MarkerFaceColor','k');
%      figure, plot(cut_q1.cut(:,i)/max(cut_q1.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

xlabel('q_y [A^{-1}]', 'Fontsize', 20);
axis([0.065 0.225 1.5 9.25]);
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

en = linspace(-2.4,-0.8, 17);

figure, hold on
for i=1:1:17
    dummy = q3_lorparcomb(i,1:5);
    [M, Mind] = min(abs(cut_q3.r-dummy(3)));
    
    dummy2 = q3_lorparpeak1(i,1:5);
    [M, Mind2] = min(abs(cut_q3.r-dummy2(3)));
    
    dummy3 = q3_lorparpeak2(i,1:5);
    [M, Mind3] = min(abs(cut_q3.r-dummy3(3)));
    
    if i >= 4
        [M, Mind4] = min(abs(cut_q3.r-xg_peter(i-3)));
    end
%     
%     [M, Mind3] = min(abs( cut_q3.r-mean([dummy2(3), dummy(3)]) ));
    
    pcut = cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.5;
%     pcut = cut_q3.cut(:,i)/mean(cut_q3.cut(:,i))+(i-1)*0.75;
    mv = pcut(Mind)+0.12;
    mv2 = pcut(Mind2)+0.12;
    mv3 = pcut(Mind3)+0.12;
    mv4 = pcut(Mind4)+0.12;
    
    pcutnew = sgolayfilt(pcut,3,11);
    plot(cut_q3.r,pcut,'b.-', 'LineWidth', 2);
%     plot(cut_q3.r,pcutnew,'.-' , 'LineWidth', 2);
    cutlabel = strcat(num2str(en(i)), ' meV');
    text(cut_q1.r(end-6)-0.01, pcut(end-5)+0.15,cutlabel,'FontSize', 14); 
    plot(dummy(3), mv,'dr', 'MarkerSize', p,'MarkerFaceColor','r');
    if i==1 || i==2 || i==4 ||i >= 8
        plot(dummy2(3), mv2,'ok', 'MarkerSize', p,'MarkerFaceColor','none');
        plot(dummy3(3), mv3,'sk', 'MarkerSize', p,'MarkerFaceColor','none');
    end
    if i >= 4
        plot(xg_peter(i-3), mv4,'+k', 'MarkerSize', p,'MarkerFaceColor','none', 'LineWidth', 2);
    end
%     herrorbar(dummy(3), mv,  dummy(5)/2,'r'); 
%      plot(dummy2(3), mv2,'dm', 'MarkerSize', p,'MarkerFaceColor','m');
%     plot(mean([dummy2(3), dummy(3)]), mv3,'dk', 'MarkerSize', p,'MarkerFaceColor','k');
%     figure, plot(cut_q3.cut(:,i)/max(cut_q3.cut(:,i))+(i-1)*0.3,'b.-', 'LineWidth', 2);
%     title([num2str(en(i)) ' meV']);
end
hold off

xlabel('q_x [A^{-1}]', 'Fontsize', 20);
axis([0.02 0.225 0 9.25]);
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