% 2020-5-12 YXC
% playing with shearing LF corrected triangular lattice.



%% shearing

% nx = 100;
% 
% 
% [X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,nx,nx));
% Qx = 10;
% Qy = 3;
% test = cos(2*pi*(Qx*X+Qy*Y)/(nx));
% test = mat2STM_Viewer(test,1,1,1,'test');
% img_obj_viewer_test(test)
% 
% figure,imagesc(puffin);axis square;axis off;title("puffin original")
% 
% S = [1 0 0; -0.2 1 0;0 0 1];
% R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0;0 0 1];
% tform1 = affine2d(R);
% tform2 = affine2d(S*R);
% 
% test2 = imwarp(test.map,affine2d(S));
% test2 = croptosquare(test2,nx);
% test2 = mat2STM_Viewer(test2,1,1,1,'test2');
% img_obj_viewer_test(test2)
% 
% puffin1 = imwarp(puffin,tform1);
% puffin2 = imwarp(puffin,tform2);
% figure,imagesc(puffin1);axis square;axis off;title('rotate')
% figure,imagesc(puffin2); axis square;axis off;title('rotate,shear')
% 
% tform3 = affine2d((S*R)^(-1));
% puffin3 = imwarp(puffin2,tform3);
% figure,imagesc(puffin3); axis square;axis off;title('undo')


% S = [1 0 0; p 1 0;0 0 1];
% ang = theta;
% R = [cos(ang) sin(ang) 0; -sin(ang) cos(ang) 0;0 0 1];
% tform2 = affine2d(R^(-1)*S^(-1)*R);
% 
% 
% cdw2 = cdw;
% cdw2.map = imwarp(cdw2.map,tform2);
% img_obj_viewer_test(cdw2)



%% shearing test

% figure,imagesc(puffin);axis square;axis off;title("puffin original")
% 
% p2 = 0.5;
% theta2 = 0;
% S = [1 0 0; -p2 1 0;0 0 1];
% 
% R = [cos(theta2) sin(theta2) 0; -sin(theta2) cos(theta2) 0;0 0 1];
% tform1 = affine2d(R);
% tform2 = affine2d(S*R);
% puffin2 = imwarp(puffin,tform2);
% figure,imagesc(puffin2);axis square;axis off;title("puffin sheared")
% 
% % middle = round(size(puffin2,1)/2);
% % puffin2 = puffin2(
% 
% tform3 = affine2d(S^(-1));
% puffin2 = imwarp(puffin2,tform3);
% figure,imagesc(puffin3);axis square;axis off;title("puffin re-sheared")



%% test with simulated lattice
% q0 = 20;
% Bgxy = zeros(7,2);
% alpha = pi/10;
% theta = pi/8.3;
% 
% Bgxy(1,:) = [q0*cos(alpha),q0*sin(alpha)];
% Bgxy(2,:) = [q0*cos(alpha+pi/3),q0*sin(alpha+pi/3)];
% Bgxy(3,:) = [q0*cos(alpha+2*pi/3),q0*sin(alpha+2*pi/3)];
% 
% Bgxy(4,:) = [q0*cos(alpha+3*pi/3),q0*sin(alpha+3*pi/3)];
% Bgxy(5,:) = [q0*cos(alpha+4*pi/3),q0*sin(alpha+4*pi/3)];
% Bgxy(6,:) = [q0*cos(alpha+5*pi/3),q0*sin(alpha+5*pi/3)];
% 
% Bgxy(7,:) = Bgxy(1,:);
% 
% Bgij = ij2xy(Bgxy);
% % figure,plot(Bgij(:,1),Bgij(:,2),'r');
% % hold on
% % plot(Bgxy(:,1),Bgxy(:,2),'k');axis square
% % legend(["ij","xy"]);
% 
% % figure,plot(Bg(:,1),Bg(:,2));
% % axis square
% % Bg = -Bg;
% 
% nx = 500;
% 
% [X,Y] = meshgrid(linspace(1,nx,nx),linspace(1,nx,nx));
% lat = cos(2*pi*(Bgxy(1,1)*X+Bgxy(1,2)*Y)/(nx))+...
%     cos(2*pi*(Bgxy(2,1)*X+Bgxy(2,2)*Y)/(nx))+...
%     cos(2*pi*(Bgxy(3,1)*X+Bgxy(3,2)*Y)/(nx));
% lat = mat2STM_Viewer(lat,1,1,1,'perfect');
% 
% % img_obj_viewer_test(lat)
% 
% % now shear it
% pshear = 0.2;
% lat2 = lat;
% S = [1 0 0; pshear 1 0;0 0 1];
% R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0;0 0 1];
% tform1 = affine2d(R^(-1)*S*R);
% lat2.map = imwarp(lat.map,tform1);
% lat2.map = croptosquare(lat2.map,nx);
% lat2.name = 'lat2';
% % img_obj_viewer_test(lat2)
% 
% 
% lat3 = lat;
% lat3.name = 'undo cheat';
% lat3.map = imwarp(lat2.map,affine2d(R^(-1)*S^(-1)*R));
% lat3.map = croptosquare(lat3.map,nx);
% % img_obj_viewer_test(lat3)
% 
% answer = [q0,pshear,theta,alpha];
%% predict distorted Bragg peaks

% Qnew = zeros(7,2);
% Qnew(1,1) = Bgxy(1,1)+pshear*q0*sin(theta)*cos(theta-alpha);
% Qnew(1,2) = Bgxy(1,2)-pshear*q0*cos(theta)*cos(theta-alpha);
% Qnew(2,1) = Bgxy(2,1)+pshear*q0*sin(theta)*cos(theta-alpha-pi/3);
% Qnew(2,2) = Bgxy(2,2)-pshear*q0*cos(theta)*cos(theta-alpha-pi/3);
% Qnew(3,1) = Bgxy(3,1)+pshear*q0*sin(theta)*cos(theta-alpha-2*pi/3);
% Qnew(3,2) = Bgxy(3,2)-pshear*q0*cos(theta)*cos(theta-alpha-2*pi/3);
% Qnew(4,:) = -Qnew(1,:);
% Qnew(5,:) = -Qnew(2,:);
% Qnew(6,:) = -Qnew(3,:);
% Qnew(7,:) = Qnew(1,:);
% % Qnew = ij2xy(Qnew);
% 
% % figure,plot(Qnew(1:2,1),Qnew(1:2,2));title("bla")
% 
% % Qnew = Qnew+251;
% figure,plot(Qnew(:,1),Qnew(:,2),'r'); title('Qnew');
% hold on
% 
% 
% % Bgxy = Bgxy+251;
% plot(Bgxy(:,1),Bgxy(:,2),'k');axis square
% plot(Bgxy(1,1),Bgxy(1,2),'rx')
% plot(Bgxy(2,1),Bgxy(2,2),'bx')
% plot(Bgxy(3,1),Bgxy(3,2),'kx')
% 
% plot(Qnew(1,1),Qnew(1,2),'rx')
% plot(Qnew(2,1),Qnew(2,2),'bx')
% plot(Qnew(3,1),Qnew(3,2),'kx')
% 
% hold on
% plot(Bgxy(:,1),Bgxy(:,2),'k');axis square
%% apply the thing

% Bgs = [[266 236]',[246 234]',[230 249]']';
% % Bgs = [[266 236]',[230 249]',[246 234]']';
% center = 251;
% Bgs = Bgs-center;
% Bgs = ij2xy(Bgs);
% % 
% % Bgs = -Bgs; % the Bragg points needs to be counter clockwise
% % % later add a checker so that user dont need to worry about it
% % 
% % 
% q0av = mean(sqrt(sum(Bgs.^2,2)));
% % 
% % % options = struct('Algorithm','levenberg-marquardt');
% % 
% fun = @(x) root4d(x,Bgs);
% x0 = [q0av,0,0,0];
% x = fsolve(fun,x0);
% 
% % 
% % 
% q0 = x(1)
% p = x(2)
% theta = x(3)
% alpha = x(4)
% 
% answer
% 
% % % Qnew = plotoriginalq2(q0,alpha);
% % % angle12 = qangle(Qnew(1,:),Qnew(2,:))
% % % angle23 = qangle(Qnew(2,:),Qnew(3,:))
% % 
% % 
% img_obj_viewer_test(lat2)
% S = [1 0 0; -p 1 0;0 0 1];
% ang = -theta;
% R = [cos(ang) sin(ang) 0; -sin(ang) cos(ang) 0;0 0 1];
% tform3 = affine2d(R^(-1)*S^(-1)*R);
% lat4 = lat2;
% lat4.name = 'attempt';
% lat4.map = imwarp(lat4.map,tform3);
% lat4.map = croptosquare(lat4.map,nx);
% img_obj_viewer_test(lat4)

% close all
% cropped = lat2.map(62:441,62:441);
% lat2 = mat2STM_Viewer(cropped,1,1,1,'distorted');
% 
% img_obj_viewer_test(lat2)
% b1 = [187,178];
% b2 = [203,180];
% b3 = [207,193];
% b4 = [195,204];
% b5 = [179,202];
% b6 = [175,189];
% % [newmap,~,~,~] = shear_correct_hex(lat2',b2,b6);
% [newmap,~,~,~] = shear_correct_hex(lat2',b6,b1);
% % [newmap,~,~,~] = shear_correct_hex(lat2,[246 234]',[266 236]');
% img_obj_viewer_test(newmap)


%% investigate something about xy to ij transformation
% test = zeros(10,10);
% test(5,1)=4;
% figure,imagesc(test)
% test = mat2STM_Viewer(test,1,1,1,'test');
% img_obj_viewer_test(test)

bg1 = [832,645];
bg2 = [859,768];
% [cdwnew,~,p,theta,~] = shear_correct_hex(cdw,bg1,bg2,'window',8);
[cdwnew,~,p,theta,~] = shear_correct_hex(cdw,bg1,bg2,'ptheta',[p,theta]);
img_obj_viewer_test(cdwnew)

function Bragxy=ij2xy(Bragij)
%assume Bragij is already centered-subtracted

Bragxy(:,1) = Bragij(:,1);
Bragxy(:,2) = -Bragij(:,2);

end

function Bragij=xy2ij(Bragxy)
%assume Bragij is already centered-subtracted

Bragij = ij2xy(Bragxy);

end

function map = croptosquare(old,nx)

map = zeros(nx,nx);
oldx = size(old,1);
oldy = size(old,2);

[nx1,nx2] = decidecropsize(oldx,nx);
[ny1,ny2] = decidecropsize(oldy,nx);

if oldx<nx
    if oldy<nx
        map(nx1:nx2,ny1:ny2) = old;
    else
        map(nx1:nx2,:) = old(:,ny1:ny2);
    end
else
    if oldy<nx
        map(:,ny1:ny2)=old(nx1:nx2,:);
    else
        map = old(nx1:nx2,ny1:ny2);
    end
end


end

function [nx1,nx2] = decidecropsize(size1,size2)
if size1==size2
    nx1=1;
    nx2=size1;
else
    if size1>size2
        big = size1;
        small = size2;
    else
        big = size2;
        small= size1;
    end
    
    nx1 = round((big-small)/2)+1;
    nx2 = nx1+small-1;
    
end
end

function F3 = root2ndtime(Bgs,Qnew)


for i=1:2

    
end

end

function F2 = root4d(x,Bgs)

q0 = x(1);
p = x(2);
theta = x(3);
alpha = x(4);

q1x = q0*cos(alpha)+p*q0*sin(theta)*(cos(theta-alpha))-Bgs(1,1);
q1y = q0*sin(alpha)-p*q0*cos(theta)*(cos(theta-alpha))-Bgs(1,2);
q2x = q0*cos(alpha+pi/3)+p*q0*sin(theta)*(cos(theta-alpha-pi/3))-Bgs(2,1);
q2y = q0*sin(alpha+pi/3)-p*q0*cos(theta)*(cos(theta-alpha-pi/3))-Bgs(2,2);
% q3x = q0*cos(alpha+2*pi/3)+p*q0*sin(theta)/(cos(theta-alpha-2*pi/3))-Bgs(3,1);
% q3y = q0*sin(alpha+2*pi/3)-p*q0*cos(theta)/(cos(theta-alpha-2*pi/3))-Bgs(3,2);

F2 = [q1x,q1y,q2x,q2y];
% F2 = [q1x,q1y,q2x,q2y,q3x,q3y];

end

function Q = ShearTransformation(Qold)



end


function angle = qangle(v1,v2)
A = sum(v1.*v2);
v1mag = sqrt(sum(v1.^2));
v2mag = sqrt(sum(v2.^2)); 
B = v1mag*v2mag;
angle = acos(A/B)*180/pi;

end


function Qnew = plotoriginalq2(q0,alpha)

pts = zeros(7,2);
pts(1,:) = [q0*cos(alpha),q0*sin(alpha)];
pts(7,:) = pts(1,:);
pts(4,:) = -pts(1,:);
pts(2,:) = [q0*cos(alpha+pi/3),q0*sin(pi/3+alpha)];
pts(5,:) = -pts(2,:);
pts(3,:) = [q0*cos(2*pi/3+alpha),q0*sin(2*pi/3+alpha)];
pts(6,:) = -pts(3,:);

figure,plot(pts(:,1),pts(:,2));

axis square;
axis off;

Qnew = pts(1:3,:);

end



function Qnew = plotoriginalq(q0,theta)

pts = zeros(7,2);
pts(1,:) = [q0*cos(theta),-q0*sin(theta)];
pts(7,:) = pts(1,:);
pts(4,:) = -pts(1,:);
pts(2,:) = [q0*cos(pi/3-theta),q0*sin(pi/3-theta)];
pts(5,:) = -pts(2,:);
pts(3,:) = [-q0*cos(pi/3+theta),q0*sin(pi/3+theta)];
pts(6,:) = -pts(3,:);

figure,plot(pts(:,1),pts(:,2));

axis square;
axis off;

Qnew = pts(1:3,:);

end



function F = root3d(x,Bgs)

% x(1): q0 
% x(2): p 
% x(3): theta

F(1) = 1+x(2)^2*cos(x(3))^2+2*x(2)*cos(x(3))*sin(x(3))-sum(Bgs(1,:).^2)/x(1)^2;
F(2) = 1+x(2)^2*cos(pi/3-x(3))^2-2*x(2)*cos(pi/3-x(3))*sin(pi/3-x(3))-sum(Bgs(2,:).^2)/x(1)^2;
F(3) = 1+x(2)^2*cos(pi/3+x(3))^2+2*x(2)*cos(pi/3+x(3))*sin(pi/3+x(3))-sum(Bgs(3,:).^2)/x(1)^2;

end


