% script to play with spectrum from map
% 2018/9/13
% MoTeSe project

linespec = obj_80913a06_G_rescale;
topo = obj_80913A06_T_rescale;
linespec2 = linespec;

px=10;py=1;
Nsmooth = 10;
averagegap = gapsize_smoothgap(map,px,py,Nsmooth);
y=squeeze(linespec.map(py,px,:));
% y = running_average(linespec,px,py,0,0);
y_smooth = running_average(linespec,px,py,Nsmooth,0);
% y_smooth = running_average(linespec,1,1,10,0);

% 
% % px = 5;
% py =1;
% Nsmooth=10;
% img_obj_viewer_yxc(linespec)
% 
% for px = 17:17
%     y = running_average(linespec,px,py,0,0);
%     y(1:5)
%     y_smooth = running_average(linespec,px,py,Nsmooth,0);
% 
%     averagegap = gapsize_smoothgap(linespec,px,py,Nsmooth);
%     
% %     img_obj_viewer_yxc(linespec)
%     
%     for py = 1:100
%         topo.map(py,px,1)=averagegap;
%         for E=1:201
%             linespec.map(py,px,E) = y_smooth(E);
%         end
%     end
%     img_obj_viewer_yxc(linespec)
% end

% img_obj_viewer_yxc(topo)
% img_obj_viewer_yxc(linespec)

% figure,plot(linespec.e*1000,y_smooth+shiftup,'-k','LineWidth',0.1)
% hold on
% plot(linespec.e*1000,y,'-b','LineWidth',0.1)
% %*1000 to make it mV, -line, k black
% xlabel('bias (mV)');
% ylabel('dI/dV (nS)');
% str = strcat('spectrum at (',int2str(px),',',int2str(py),')');
% title(str);


figure,plot(linespec.e*1000,y_smooth+shiftup,'-k','LineWidth',0.1)
hold on
plot(linespec.e*1000,y,'-b','LineWidth',0.1)
%*1000 to make it mV, -line, k black
xlabel('bias (mV)');
ylabel('dI/dV (nS)');
str = strcat('spectrum at (',int2str(px),',',int2str(py),')');
title(str);


