% 2020-5-14 YXC
% testing imwarp for scale to match

% map = cdw;
% nx = size(map.map,1);
% 
% 
% xtrans = 10.5;
% T = [1 0 0;0 1 0; xtrans 0 1];
% R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
% I = [1 0 0;0 1 0; 0 0 1];
% Scale = [sx 0 0; 0 sy 0; 0 0 1];
% 
% % tform = affine2d(T*R);
% tform = affine2d(T);
% centerOutput = affineOutputView(size(map.map),tform,'BoundsStyle','CenterOutput');
% [map.map,ref] = imwarp(map.map,tform,'OutputView' ,centerOutput);
% % img_obj_viewer_test(map)
% % ref
% % xlim = ref.XWorldLimits(1)
% 
% % map.map = crop_warpedimage(map.map,nx,ref);
% img_obj_viewer_test(map)

% close all
% clear map
% map.map = zeros(100,100);
% map.map = meshgrid(linspace(1,100,100),linspace(1,100,100));
% map.r = linspace(1,100,100);
% % map.map(10,10)=1;
% % map.map(51,51)=1;
% map.name = 'map';
% map.var = 'G';
% map.e = 1;
% img_obj_viewer_test(map)
% 
% 
% M = [1 0 0; 0 1 0; 10.8 0 1];
% tform = affine2d(M);
% centerOutput = affineOutputView(size(map.map),tform,'BoundsStyle','CenterOutput');
%     
% map.map = imwarp(map.map,tform,'OutputView' ,centerOutput);
% map.name = 'map2';
% img_obj_viewer_test(map)

% close all
%% hex Bragg testing
% theta1 = 0;
% theta2 = 60;
% phase = 260;
% 
% 
% theta1 = (theta1+phase)*pi/180;theta2 = (theta2+phase)*pi/180;
% [Q3,theta3]=thirdBragg(1,1,theta1,theta2)
% theta3*180/pi
% 
% 
% figure,plot([0, cos(theta1)],[0,sin(theta1)]);
% hold on
% plot([0, cos(theta2)],[0,sin(theta2)]);
% plot([0, cos(theta3)],[0,sin(theta3)]);
% xlim([-1 1]);ylim([-1 1]); axis square


%% test imwarp through register_lattice_gui 
% map4.map = zeros(100,100)+0.5;
% map5.map = zeros(100,100)+0.5;
% 
% map4.map(10,10)=1;
% map4.map(70:72,31)=1;
% map4.map(43,92)=1;
% 
% map5.map(20,13)=1;
% map5.map(65:67,35)=1;
% map5.map(55,92)=1;
% 
% map4.map(1,1) = 0;
% map5.map(1,1) = 0;
% 
% register_lattice_gui(map4,map5)





function [Q3,theta3] = thirdBragg(Q1,Q2,theta1,theta2)


diff1 = abs(mod(theta1,2*pi)-mod(theta2,2*pi));
diff2 = 2*pi-diff1;
diff = min(diff1,diff2);
if abs(diff-pi/3)>abs(diff-2*pi/3) %diff closer to 120 deg
    theta2 = theta2-pi;
end



Q3 = sqrt(Q1^2+Q2^2-2*Q1*Q2*cos(theta2-theta1));

top = Q2*cos(theta2)-Q1*cos(theta1);
bottom = Q1*sin(theta1)-Q2*sin(theta2);
theta3 = pi/2+atan(top/bottom);


end














