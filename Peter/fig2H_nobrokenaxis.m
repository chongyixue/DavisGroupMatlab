
color_map_path = 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = 'C:\Users\pspra\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
% color_map_path = '/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/STM View/Color Maps/';
color_map = struct2cell(load([color_map_path 'Jet.mat']));
color_map = color_map{1};

% load('/Users/andreykostin/Documents/MATLAB/Analysis Code/MATLAB/FeSe figs/q3q1M.mat');

xm = [-0.262,-0.292,-0.314,-0.337,-0.359];
ym = [-0.082,-0.082,-0.075,-0.067,-0.060];

xm_peter = [0.15984,0.18981,0.23219, 0.26964,0.28462,0.31458,0.33705,0.34454, 0.36963];
ym_peter = [0.05994,0.06993,0.08239, 0.08239,0.0749,0.06741,0.05992,0.05243, 0];

xm1 = xm_peter;
ym1 = ym_peter;

xm_error = 0.75*[0.04995,0.03996,0.02247, 0.02247,0.02247,0.02247,0.02247,0.02247, 0.02997];


figure(1),


p = 10;


line([-0.025,0.425],[0,0],'Color','k','LineStyle','--','LineWidth',2)
line([0,0],[-0.025,0.15],'Color','k','LineStyle','--','LineWidth',2)


%%
crad = 0.005;
% rectangle('Position',[xm1(1)-crad/2,ym1(1)-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[1, 0, 0]*0.3,'LineStyle','none')

      
plot(xm1(9), ym1(9),'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','k');   

hold on

verrorbar(xm1(9), ym1(9), xm_error(7),'k');
herrorbar(xm1(9), ym1(9), xm_error(7),'k');

cp = linspace(0.3, 1, 8);
cp = floor( linspace(1, 256, 8) );
for i=1 : length(xm1)-1
%     rectangle('Position',[xm1(i)-crad/2,ym1(i)-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[1, 0, 0]*cp(i),'LineStyle','none')
%       plot(xm1(i), ym1(i),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[1, 0, 0]*cp(i),'MarkerFaceColor',[1, 0, 0]*cp(i)); 
      plot(xm1(i), ym1(i),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(i), :),'MarkerFaceColor',color_map(cp(i), :));
%     plot(xg1(i), yg1(i),'ok', 'MarkerSize', p,'MarkerFaceColor','k');  
    if i==1 || i==2 || i==3 || i==5 || i==7
        verrorbar(xm1(i), ym1(i),  xm_error(i),'k');
        herrorbar(xm1(i), ym1(i),  xm_error(i),'k');  
    end
end

%%
q1_lorpar = q1m_lorparcomb;
q3_lorpar = q3m_lorparcomb;
%%
%cp = linspace(0.3, 1, 6);
%cp = floor( linspace(1, 256, 6) );
for i=1 : 6
    dummy = q1_lorpar(i,1:5);
    
%     rectangle('Position',[-crad/2,dummy(3)-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[0, 1, 0] * cp(i),'LineStyle','none')
      
%     plot(0, dummy(3),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[0, 1, 0]*cp(i),'MarkerFaceColor',[0, 1, 0]*cp(i)); 
    plot(0, dummy(3),'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(i+2), :),'MarkerFaceColor',color_map(cp(i+2), :)); 

end    
 
for i=1:6
    dummy = q1_lorpar(i,1:5);
    if i==6 || i==6
        verrorbar(0, dummy(3),  0.75*dummy(5),'k'); 
    end
end

%cp = linspace(0.3, 1, 6);
%cp = floor( linspace(1, 256, 6) );
for i=1 : 6
    dummy = q3_lorpar(i,1:5);
    
%     rectangle('Position',[dummy(3)-crad/2,-crad/2,crad,crad],'Curvature',[1,1],...
%           'FaceColor',[0, 0, 1] * cp(i),'LineStyle','none')
      
%     plot(dummy(3), 0,'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',[0, 0, 1]*cp(i),'MarkerFaceColor',[0, 0, 1]*cp(i)); 
    plot(dummy(3), 0,'Marker', 'o', 'MarkerSize', p,'MarkerEdgeColor',color_map(cp(i+2), :),'MarkerFaceColor',color_map(cp(i+2), :)); 
end  
clear dummy
for i=1:6
     dummy = q3_lorpar(i,1:5);
    if i==1 || i==3 || i==5
        herrorbar(dummy(3), 0,  0.75*dummy(5),'k');
    end
end

plot(0, 0,'Marker', 'd', 'MarkerSize', p,'MarkerEdgeColor','k','MarkerFaceColor','w', 'LineStyle', '--');

hold off

ylabel('q_y [A^{-1}]', 'Fontsize', 20);
xlabel('q_x [A^{-1}]', 'Fontsize', 20);
%hold off
axis equal
% axis square
axis([-0.025 0.45 -0.025 0.15]);
%axis(2*[-0.25 0.25 -0.25 0.25]);
%axis(2*[-0.25 0 -0.25 0.25]);
ax2 = gca;
ax2.FontSize = 20;
ax2.TickLength = [0.02 0.02];
ax2.LineWidth = 2;
ax2.XTick = linspace(-0.0,0.4,5);
ax2.YTick = linspace(-0.0,0.1,3);
%axis square
%axis off
%ax2.XTick = linspace(0,90,7);
%xlabel('q_x (A^{-1})','FontSize',20);
%ylabel('q_y (A^{-1})','FontSize',20);

figsiz=[20 20];
fig_siz(figsiz);
%pbaspect([1.25 1 1])

figw
box off
