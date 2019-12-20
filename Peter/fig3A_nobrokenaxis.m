
% color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = '/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/STM View/Color Maps/';
color_map = struct2cell(load([color_map_path 'Jet.mat']));
color_map = struct2cell(load([color_map_path 'LightBlueBlackLightGreen.mat']));
color_map = struct2cell(load([color_map_path 'Terrain2.mat']));
color_map = struct2cell(load([color_map_path 'Defect_yellow.mat']));
% color_map = struct2cell(load([color_map_path 'PurpleBlackCopper.mat']));
% color_map = struct2cell(load([color_map_path 'PurpleOrange.mat']));




color_map = color_map{1};

% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/q3q1Gamma.mat');

eg_peter = linspace(-2.1,-0.8,14);
xg_peter = 1.03*[0.122,0.10948,0.10304,0.10304,0.10304,0.0966,0.10304,0.0966,0.09016,0.08372,0.07728,0.07084,0.0644,0.0644];
yg_peter = 1.03*abs([-0.077,-0.10304,-0.10948,-0.11592,-0.12236,-0.1288,-0.14168,-0.15456,-0.15456,-0.161,-0.161,-0.16744,-0.16744,-0.17388]);

xg1 = xg_peter;
yg1 = yg_peter;

% em = linspace(-0.9,-0.50,5);
% 
% 
% xm = [-0.262,-0.292,-0.314,-0.337,-0.359];
% ym = [-0.082,-0.082,-0.075,-0.067,-0.060];
% 
% xm_peter = [0.26964,0.28462,0.31458,0.33705,0.34454];
% ym_peter = [-0.08239,-0.0749,-0.06741,-0.05992,-0.05243];
% 
% xm_peter2 = 0.23219;
% ym_peter2 = -0.08239;
% 
% xm_peter3 = [0.10989,0.15984,0.18981,0.22977,0.24975,0.25974,0.28971,0.28971,0.31968,0.34968,0.36963,0.36963];
% ym_peter3 = [-0.05994,-0.05994,-0.06993,-0.06993,-0.06993,-0.06993,-0.05994,-0.05994,-0.06993,-0.07992,-0.04995,0];
% 
% %xm_peter3 = [0.22977,0.24975,0.25974,0.28971,0.28971,0.31968,0.33966,0.35964,0.36963];
% %ym_peter3 = [-0.06993,-0.06993,-0.06993,-0.05994,-0.05994,-0.06993,-0.07992,-0.04995,0];
% 
% % xm_peter4 = [0.35964, 0.36963];
% % ym_peter4 = [-0.04995, 0];
% 
% xm_peter4 = [0.36963];
% ym_peter4 = [0];

% xm_error = [0.02247,0.02247,0.02247,0.02247,0.02247];
% 
% xm_error2 = 0.02247;
% 
% xm_error4 = [0.02997];
% 
% % xm_error4 = [0.02997, 0.02997];

figure(2), clf,


p = 10;


line([-0.025,0.175],[0,0],'Color','k','LineStyle','--','LineWidth',2)
line([0,0],[-0.025,0.225],'Color','k','LineStyle','--','LineWidth',2)


%%
xg_error = 1.03*0.75*[0.02576,0.01932,0.02576,0.02576,0.02576,0.02576,0.01932,0.02576,0.02576,0.01932,0.01932,0.01932,0.02576,0.02576];

%%
crad = 0.005;
% rectangle('Position',[xg1(1)-crad/2,yg1(1)-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[1, 0, 0]*0.3,'LineStyle','none')
      
cp = floor( linspace(1, 256, 15) );

% plot(xg1(1), yg1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[1, 0, 0]*0.3,'MarkerFaceColor',[1, 0, 0]*0.3);
plot(xg1(1), yg1(1),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(2),:),'MarkerFaceColor',color_map(cp(2),:));
      
% plot(xg1(1), yg1(1),'ok', 'MarkerSize', p,'MarkerFaceColor','k');      
hold on

verrorbar(xg1(1), yg1(1), xg_error(1),'k');
herrorbar(xg1(1), yg1(1), xg_error(1),'k');

cp = linspace(0.3, 1, 14);
cp = floor( linspace(1, 256, 15) );
for i=2 : length(xg1)
%     rectangle('Position',[xg1(i)-crad/2,yg1(i)-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[1, 0, 0]*cp(i),'LineStyle','none')
%     plot(xg1(i), yg1(i),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[1, 0, 0]*cp(i),'MarkerFaceColor',[1, 0, 0]*cp(i)); 
    plot(xg1(i), yg1(i),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(i+1), :),'MarkerFaceColor',color_map(cp(i+1), :)); 
%     plot(xg1(i), yg1(i),'ok', 'MarkerSize', p,'MarkerFaceColor','k');  
    if i == 3 || i == 8 || i== 14 
        verrorbar(xg1(i), yg1(i),  xg_error(i),'k');
        herrorbar(xg1(i), yg1(i),  xg_error(i),'k');  
    end
end

%%
cp = linspace(0.3, 1, 14);
cp = floor( linspace(1, 256, 15) );
for i=1 : 12
    dummy = q1_lorparcomb(i,1:5);
    
%     rectangle('Position',[-crad/2,dummy(3)-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[0, 1, 0] * cp(i),'LineStyle','none')
      
%     plot(0, dummy(3),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[0, 1, 0]*cp(i),'MarkerFaceColor',[0, 1, 0]*cp(i));
    if i== 7 || i == 7 || i== 8 || i == 8 
    else
        plot(0, 1.03*dummy(3),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(i+1), :),'MarkerFaceColor',color_map(cp(i+1), :));
        if i == 6 || i == 6|| i == 6 || i== 12  
            verrorbar(0, 1.03*dummy(3),  1.03*dummy(5),'k'); 
        end
    end
end    
    
cp = linspace(0.3, 1, 17);
cp = floor( linspace(1, 256, 15) );
for i=1 : 12
    dummy = q3_lorparcomb(i,1:5);
    if i==1
        plot(1.03*dummy(3), 0,'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k'); 
        herrorbar(1.03*dummy(3), 0,  1.03*dummy(5),'k');
%     elseif i == 2 || i == 9 || i== 12 || i == 12  || i== 14 || i == 15
    else
%         rectangle('Position',[dummy(3)-crad/2,-crad/2,crad,crad],'Curvature',[1,1],...
%               'FaceColor',[0, 0, 1] * cp(i),'LineStyle','none')
%         plot(dummy(3), 0,'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[0, 0, 1]*cp(i),'MarkerFaceColor',[0, 0, 1]*cp(i)); 
        plot(1.03*dummy(3), 0,'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(i-1), :),'MarkerFaceColor',color_map(cp(i-1), :)); 
        if i == 9 || i == 9 || i== 9 || i == 9  
            herrorbar(1.03*dummy(3), 0, 1.03*dummy(5),'k');  
        end
    end
end  

plot(0, 0,'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','w', 'LineStyle', '--');

hold off

ylabel('q_y [10^{-2} A^{-1}]', 'Fontsize', 20);
xlabel('q_x [10^{-2} A^{-1}]', 'Fontsize', 20);
%hold off
axis equal
axis([-0.01 0.17 -0.01 0.22]);
% %axis(2*[-0.25 0.25 -0.25 0.25]);
% %axis(2*[-0.25 0 -0.25 0.25]);
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
% ax2.XTick = linspace(0,.16,9);
% ax2.XTickLabel = {'0', '2','4', '6', '8', '10', '12', '14', '16'}; 
ax2.XTick = linspace(0,.16,5);
ax2.XTickLabel = {'0','4', '8', '12', '16'}; 
ax2.YTick = linspace(0,0.20,6);
ax2.YTickLabel = {'0','4','8', '12', '16', '20'}; 
% %axis square
% %axis off
% %ax2.XTick = linspace(0,90,7);
% %xlabel('q_x (A^{-1})','FontSize',20);
% %ylabel('q_y (A^{-1})','FontSize',20);

figsiz=[20 20];
fig_siz(figsiz);
%pbaspect([1.25 1 1])

figw
box off
