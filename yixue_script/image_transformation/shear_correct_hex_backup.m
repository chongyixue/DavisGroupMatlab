% 2020-5-14 YXC
% give two Bragg peaks, and return shear corrected image.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% we assume there exist a perfect hexagon from the q-space of our
% triangular lattice, one of the symmetric axis of that hexagon (connecting
% two vertices) is shifted counter-clockwise by alpha from the Qx axis of 
% our coordinate system. There is a shear in real space described by 
% Sr = [1 p;0 1] (italics kinda skew) in a coordinate system angled by theta
% (counter-clockwise) relative to ours. In Q space this corresponds to a
% shift of S = [1 0;-p 1] (still in the shear coordinate system) 
% Our measured Bragg peak Qthilde is a result of these operations:
% rotate CC to shear axis, shear, then de-rotate to our coordinate system.
% R(theta)^-1 S R(theta) Q=Qthilde
% Q1 and Q2 can be expressed in terms of alpha and q0 (length)
% similarlay Qthilde1 and 2 in terms of alpha, q0, p and theta.
% 4 non-linear simultaneous equations are solved numerically
% (the third Bragg peak is related by symmetry)

% in real space, R(theta)^-1 Sr R(theta) newmap = map
% the newmap has the recovered perfect hexagon Bragg peaks by doing
% R(theta)^-1 Sr^-1 R(theta) map = newmap

% care has to be taken as our img_obj_viewer Bragg peaks ij coordinate
% system is vertically inverted from the xy coordinate system.
% xy system: x increase to the right, y increase going up
% ij system (xpix and ypix from imagesc or img_obj_viewer): i increase to
%   the right,j increase going DOWN
% matrixij system: i increase going down, j increase going right


function [newmap,q0,p,theta,alpha] = shear_correct_hex(map,Bragg1,Bragg2,varargin)


nx = size(map.map,1);
center = ceil((nx+1)/2);
Bgs = zeros(2,2);
Bgs(1,:)= reshape(Bragg1-center,1,2);
Bgs(2,:) = reshape(Bragg2-center,1,2);

Bgs = pixij2xy(Bgs);
q0av = mean(sqrt(sum(Bgs.^2,2)));

% figure,imagesc(map.map);axis square;axis off;
figure,plot(Bgs(:,1),Bgs(:,2));
hold on
plot(Bgs(1,1),Bgs(1,2),'ro')
siz = 20;
plot([-siz,siz],[0,0],'k');
plot([0,0],[-siz,siz],'k');axis off;axis square

angle1 = atan2(Bgs(1,2),Bgs(1,1))*180/pi;
angle2 = atan2(Bgs(2,2),Bgs(2,1))*180/pi;

difang = qangle(Bgs(1,:),Bgs(2,:));
if abs(difang-60)<abs(difang-120)
    % two vectors are approx 60 deg apart
    if mod(angle1-angle2,360)<120
        temp = Bgs(1,:);
        Bgs(1,:) = Bgs(2,:);
        Bgs(2,:) = temp;
    end
else
    % two vectors are approx 120 deg apart
    Bgs(1,:) = -Bgs(1,:);
    angle1 = atan2(Bgs(1,2),Bgs(1,1))*180/pi;
    if mod(angle1-angle2,360)<120 
        temp = Bgs(1,:);
        Bgs(1,:) = Bgs(2,:);
        Bgs(2,:) = temp;
    end
end

figure,plot(Bgs(:,1),Bgs(:,2));
hold on
plot(Bgs(1,1),Bgs(1,2),'ro')
siz = 20;
plot([-siz,siz],[0,0],'k');
plot([0,0],[-siz,siz],'k');axis off;axis square
title('after correction')


fun = @(x) root4d(x,Bgs);
x0 = [q0av,0,0,0];
x = fsolve(fun,x0);


q0 = x(1);
p = x(2);
theta = x(3);
alpha = x(4);

% due to the xy to matrix(for imagesc) transformation, CC rotation becomes
% clockwise, and the shear of [1 p;0 1] becomes [1 0;-p 1], hence the
% following difference between implimentation and explanation above.
S = [1 0 0; -p 1 0; 0 0 1]; 
ang = -theta;
R = [cos(ang) sin(ang) 0; -sin(ang) cos(ang) 0; 0 0 1];
tform = affine2d(R^(-1)*S^(-1)*R);
newmap = map;
newmap.name = strcat(map.name,'_shearHexCorrected');
newmap.map = imwarp(map.map,tform);
newmap.map = croptosquare(newmap.map,nx);




















%% functions
function Bragxy=pixij2xy(Bragij)
%assume Bragij is already centered-subtracted

Bragxy(:,1) = Bragij(:,1);
Bragxy(:,2) = -Bragij(:,2);

end

function Bragij=xy2pixij(Bragxy)
%assume Bragij is already centered-subtracted

Bragij = pixij2xy(Bragxy);

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






end








