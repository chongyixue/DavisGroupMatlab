% 2020-12-14 YXC
% hexagonality from "Hexagonality as a New Shape‑Based Descriptor of Object"
% by Vladimir Ilić1 · Nebojša M. Ralević1
% in an attempt to characterize vmap and Jmap contours

%% A. make theoretical shape and multiply


% % r = linspace(4,100,100001);
% % lambdanm = 100;
% % vnew = theoretical_velocity(lambdanm,r);
% % vold = theoretical_velocityold(lambdanm,r);
% % 
% % figure,plot(r,vold,'b');
% % hold on
% % plot(r,vnew,'r');
% % figure,plot(r,vnew./vold);
% 
% 
% 
% nx = 200;
% lambda = 160;
% FOV = 200; %nm
% xi  =20*10^(-9);%m
% 
% % mat = zeros(nx,nx);
% % center = (nx+1)/2;
% % center = [center,center];
% % center_m = center*FOV*10^(-9)/nx;
% % 
% % [RX,RY] = meshgrid(linspace(0,FOV*10^(-9),nx),linspace(0,FOV*10^(-9),nx));
% % RX = RX-center_m(1);RY=RY-center_m(2);
% % Dist = sqrt((RX).^2+(RY).^2);
% % rhomat = tanh(Dist/xi);
% f1 = figure;
% imagesc(rhomat);
% setcolor(f1,'Blue1');
% axis square;axis off;
% title('\rho');
% 
% 
% 
% hexfilter_bottom = (atan2(RY,RX)>pi/3).*(atan2(RY,RX)<2*pi/3);
% hexfilter_top = (atan2(RY,RX)<-pi/3).*(atan2(RY,RX)>-2*pi/3);
% hexfilter_righttop = (atan2(RY,RX)<0).*(atan2(RY,RX)>-pi/3);
% hexfilter_rightbottom = (atan2(RY,RX)>0).*(atan2(RY,RX)<pi/3);
% hexfilter_lefttop = (atan2(RY,-RX)<0).*(atan2(RY,-RX)>-pi/3);
% hexfilter_leftbottom = (atan2(RY,-RX)>0).*(atan2(RY,-RX)<pi/3);
% sumfilt = hexfilter_bottom+hexfilter_leftbottom+...
%     hexfilter_lefttop+hexfilter_rightbottom+hexfilter_righttop+...
%     hexfilter_top;
% RHex = hexfilter_bottom.*RY+hexfilter_top.*(-RY)+...
%     (hexfilter_rightbottom).*(Dist.*cos(atan2(RY,RX)-pi/6))+...
%     (hexfilter_righttop).*(Dist.*cos(atan2(-RY,RX)-pi/6))+...
%     (hexfilter_leftbottom).*(Dist.*cos(atan(-RY./RX)-pi/6))+...
%     (hexfilter_lefttop).*(Dist.*cos(atan(RY./RX)-pi/6));
% % figure,imagesc(RHex);
% vmat = theoretical_velocity(lambda,RHex*10^(9));
% fv = figure;imagesc(vmat);
% caxis([0,600000]);
% setcolor(fv,'Jet');
% axis square;axis off;
% title('v');
% 
% 
% Jmat = vmat.*rhomat;
% fJ = figure;
% imagesc(Jmat);
% setcolor(fJ,'Viridis');
% axis square;axis off;
% title('J');

% plotcontours(rhomat/max(max(rhomat)),[0.5,0.7,0.9],'r','Viridis','contourblur',1,...
%     'imageblur',1,'title','\rho','caxis',[0,1]);
% plotcontours(vmat,[3,4]*100000,'r','Viridis','contourblur',1,...
%     'imageblur',1,'title','v','caxis',[0,600000]);
% plotcontours(Jmat/max(max(Jmat)),[0.5,0.7],'w','Viridis','contourblur',1,...
%     'imageblur',1,'title','J','caxis',[0,1]);

%% B. hexagonality?

% % GBLURR = 3;
% % vshape = imgaussfilt(velms,GBLURR)>1000;
% % vshape(55:65,45:54)=1;figure,imagesc(vshape);
% % HH = hexagonality_number(vshape)
% % title(strcat('v:',num2str(real(HH))));axis square;
% Hfit = hexagonality_fit_number(vshape,'title',"v");
% % 
% % 
% rhoshape = imgaussfilt(g0layernew,GBLURR)<0.0143;
% % HC = hexagonality_number(rhoshape)
% % figure,imagesc(rhoshape);title(strcat('\rho:',num2str(real(HC))));axis square;
% Hfit = hexagonality_fit_number(rhoshape,'title',"\rho ")


% Jshape = imgaussfilt(Jmap3.map,GBLURR)>1.5*10^(11);
% Jshape(44:66,44:66)=1;
% HJ = hexagonality_number(Jshape)
% % figure,imagesc(Jshape);title(strcat('J:',num2str(real(HJ))));axis square;
% Hfit = hexagonality_fit_number(Jshape,'title',"J")

%% Hfit radially
% % close all
% % JBlurred = imgaussfilt(Jmap3.map,GBLURR);
% % Jlimits = linspace(1.1,2.1,11)*10^11;
% % pretendradius = zeros(size(Jlimits));
% % Hfit_J = zeros(size(Jlimits));
% % 
% % for i=1:length(Jlimits)
% %     Jshape = JBlurred>Jlimits(i);
% %     Jshape(45:68,44:68)=1;
% %     pretendradius(i) = sqrt(sum(sum(Jshape))/pi)*205/117;
% % %     figure,imagesc(Jshape);
% %     Hfit_J(i)=hexagonality_fit_number(Jshape,'title',strcat("J(",num2str(pretendradius(i)),"nm)"));
% % end
% % figure,plot(pretendradius,Hfit_J);xlim([0,max(pretendradius)])
% % close all
% 
% 
% VBlurred = imgaussfilt(velms,GBLURR);
% Vlimits = linspace(1000,1500,11);
% % Vlimits = linspace(1500,1500,1);
% pretendradius = zeros(size(Vlimits));
% Hfit_v = zeros(size(Vlimits));
% 
% for i=1:length(Vlimits)
%     Vshape = VBlurred>Vlimits(i);
%     Vshape(58,45:55)=1;
%     Vshape(59,45:55)=1;
%     Vshape(60,46:55)=1;
%     Vshape(61,46:55)=1;
%     Vshape(62,47:55)=1;
%     Vshape(63,47:55)=1;
%     Vshape(64,48:55)=1;
%     Vshape(65,49:55)=1;
% 
%     pretendradius(i) = sqrt(sum(sum(Vshape))/pi)*205/117;
% %     figure,imagesc(Jshape);
%     Hfit_v(i)=hexagonality_fit_number(Vshape,'title',strcat("v(",num2str(pretendradius(i)),"nm)"));
% end
% figure,plot(pretendradius,Hfit_v);xlim([0,max(pretendradius)])

%% shapes
% n1 = 117;n2=117;
% mat = zeros(n1,n2);
% [X,Y] = meshgrid(linspace(1,n1,n1),linspace(1,n2,n2));
% cent = ceil((n1+1)/2);

%% circle

% Cshape = sqrt((X-cent).^2+(Y-cent).^2)<n1/5;
% HCirc = hexagonality_number(Cshape)
% figure,imagesc(Cshape);title(strcat('Circle:',num2str(real(HCirc))));axis square;
% c(Cshape)
%% definition of hexagon

% 
foci1 = [50,60];
foci2 = [70,60];
a0 = 113;
% % 
D  = abs(X-foci1(1))+abs(X-foci2(1))+abs(Y-foci1(2))+abs(Y-foci2(2));
hexmat = D<a0;
% % % HN = Hnumber(cir)
figure,imagesc(hexmat);axis square;
% % % a(hexmat)
% % % c(hexmat)
% % cn = centroid(hexmat);
% S = rotateAround(hexmat,cn(1),cn(2),17.2);
% % % top = a(hexmat)^3-c(hexmat)^3
% % % bottom = SMeasure(hexmat,cn,0)
% % % top/bottom*8/3
% figure,imagesc(S);
hold on
plot(foci1(1),foci1(2),'rx');
plot(foci2(1),foci2(2),'rx');
% title(num2str(hexagonality_number(S)));
% Hfit = hexagonality_fit_number(S)
%% functions


%% B hexagonality

function H = Hnumber(S)
cn = centroid(S);
theta = linspace(0,360,91);
thetachosen = 0;

Schosen = S;
minbottom = inf;
for i=1:length(theta)
    [bottom,S2] = SMeasure(S,cn,theta(i));
    if bottom<minbottom
        minbottom=bottom;
        Schosen = S2;
        thetachosen = theta(i);
    end
end


%% 2nd time finer
theta = linspace(thetachosen-2,thetachosen+2,51);
for i=1:length(theta)
    [bottom,S2] = SMeasure(S,cn,theta(i));
    if bottom<minbottom
        minbottom=bottom;
        Schosen = S2;
    end
end


%% final
top = a(Schosen)^3-c(Schosen)^3;
H = (8/3)*top/minbottom;
end

function [Snumber,S2] = SMeasure(S,cn,theta)
n1 = size(S,1);
n2 = size(S,2);
[X,Y] = meshgrid(linspace(1,n2,n2),linspace(1,n1,n1));
S2 = rotateAround(S,cn(1),cn(2),theta);
X = X-cn(1);Y = Y-cn(2);
Integrand = abs(X-c(S2))+abs(Y)+abs(X+c(S2))+abs(Y);
Snumber = sum(sum(Integrand.*S2));

end


function center = centroid(S)
n1 = size(S,1);
n2 = size(S,2);
[X,Y] = meshgrid(linspace(1,n2,n2),linspace(1,n1,n1));
center = [0,0];
A = sum(sum(S));
center(1) = sum(sum(X.*S))/A;
center(2) = sum(sum(Y.*S))/A;
end

function a = a(S)
A = sum(sum(S));
a = sqrt(A*(3*Hu1(S)+3*sqrt(Hu2(S))+0.5)/2);
end

function c = c(S)
A = sum(sum(S));
c = sqrt(A*(3*Hu1(S)+3*sqrt(Hu2(S))-0.5)/2);
end

function H2 = Hu2(shapemat)
S = shapemat;
H2 = ((moment2(S,2,0)-moment2(S,0,2))^2+4*moment2(S,1,1)^2)/(moment2(S,0,0)^4);
end

function H1 = Hu1(shapemat)
H1 = (moment2(shapemat,2,0)+moment2(shapemat,0,2))/(moment2(shapemat,0,0)^2);
end

function m = moment2(shapemat,p,q)
cn = centroid(shapemat);
n1 = size(shapemat,1);
n2 = size(shapemat,2);
[X,Y] = meshgrid(linspace(1,n2,n2),linspace(1,n1,n1));
X = X-cn(1);
Y = Y-cn(2);
m = sum(sum((X.^p).*(Y.^q).*shapemat));
end

function m = moment(shapemat,p,q)
n1 = size(shapemat,1);
n2 = size(shapemat,2);
[X,Y] = meshgrid(linspace(1,n2,n2),linspace(1,n1,n1));
m = sum(sum(X.^p.*Y.^q.*shapemat));
end

%% 0 : Frequently used
function setcolor(ax,col)
color_map_path = 'C:\Users\chong\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\';
color_map = struct2cell(load([color_map_path col]));
color_map = color_map{1};
colormap(ax,color_map);
end

%% contour
function ff = plotcontours(image,contourlist,contourcolor,colormap,varargin)
climitset = 0;
blurimage = 0;
blurcontour = 0;
labelornot = 'off';
lw = 1;
tt = 'contour plot';
if nargin>4
    skipover = 0;
    for i=1:length(varargin)
        if skipover ~=0
            skipover = skipover-1;
        else
            switch varargin{i}
                case 'Linewidth'
                    skipover = 1;
                    lw = varargin{i+1};
                case 'title'
                    skipover = 1;
                    tt = varargin{i+1};
                case 'caxis'
                    skipover = 1;
                    climitset = 1;
                    climit = varargin{i+1};
                case 'imageblur'
                    skipover =1;
                    imageblur = varargin{i+1};
                    blurimage=1;
                case 'contourblur'
                    skipover = 1;
                    blurcontour = 1;
                    contourblur = varargin{i+1};
                    
                case 'label'
                    skipover = 0;
                    labelornot = 'on';
                
                otherwise
                    st = num2str(varargin{i});
                    fprintf(strcat('"',st,'" is not recognized as a property'));
            end

        end
    end
end

if blurcontour==1
    imgsmooth = imgaussfilt(image,contourblur);
else
    imgsmooth = image;
end

if blurimage == 1
    imagetoplot = imgaussfilt(image,imageblur);
else
    imagetoplot = image;
end

ff=figure;
imagesc(imagetoplot);
setcolor(ff,colormap);axis off; axis equal
if climitset==1
    caxis(climit);
end
colorbar;
hold on;
contour(imgsmooth,contourlist,contourcolor,'LineWidth',lw,...
    'ShowText',labelornot);
title(tt)
end


function v = theoretical_velocityold(lambda_nm,r_nm)
hbar = 1.055*10^(-34); %J s
m  = 2*9.1*10^(-31);   %kg

if length(r_nm)==1
    dr = 0.001;
    r = linspace(r_nm-dr,r_nm+dr,3)*10^(-9);
    K = besselk(0,r*10^9/lambda_nm);
    v = gradient((hbar/m)*K,r); % in m/s
    v = v(2);
else
    r = r_nm*10^(-9);
    K = besselk(0,r_nm/lambda_nm);
    v = gradient((hbar/m)*K,r); % in m/s
end
v = -v;
end

function v = theoretical_velocity(lambda_nm,r_nm)
hbar = 1.055*10^(-34); %J s
m  = 2*9.1*10^(-31);   %kg


r = r_nm*10^(-9);
K = besselk(-1,r/lambda_nm);
% v = K;
v = (hbar/m)*K; % in m/s


end

%% copied from internet
function output=rotateAround(image, pointY, pointX, angle, varargin)
% ROTATEAROUND rotates an image.
%   ROTATED=ROTATEAROUND(IMAGE, POINTY, POINTX, ANGLE) rotates IMAGE around
%   the point [POINTY, POINTX] by ANGLE degrees. To rotate the image
%   clockwise, specify a negative value for ANGLE.
%
%   ROTATED=ROTATEAROUND(IMAGE, POINTY, POINTX, ANGLE, METHOD) rotates the
%   image with specified method:
%       'nearest'       Nearest-neighbor interpolation
%       'bilinear'      Bilinear interpolation
%       'bicubic'       Bicubic interpolation
%    The default is fast 'nearest'. Switch to 'bicubic' for nicer results.
%
%   Example
%   -------
%       imshow(rotateAround(imread('eight.tif'), 1, 1, 10));
%
%   See also IMROTATE, PADARRAY.
%   Contributed by Jan Motl (jan@motl.us)
%   $Revision: 1.2 $  $Date: 2014/05/01 12:08:01 $
% Parameter checking.
numvarargs = length(varargin);
if numvarargs > 1
    error('myfuns:somefun2Alt:TooManyInputs', ...
        'requires at most 1 optional input');
end
optargs = {'nearest'};    % Set defaults for optional inputs
optargs(1:numvarargs) = varargin;
[method] = optargs{:};    % Place optional args in memorable variable names
% Initialization.
[imageHeight imageWidth ~] = size(image);
centerX = floor(imageWidth/2+1);
centerY = floor(imageHeight/2+1);
dy = centerY-pointY;
dx = centerX-pointX;
% How much would the "rotate around" point shift if the 
% image was rotated about the image center. 
[theta, rho] = cart2pol(-dx,dy);
[newX, newY] = pol2cart(theta+angle*(pi/180), rho);
shiftX = round(pointX-(centerX+newX));
shiftY = round(pointY-(centerY-newY));
% Pad the image to preserve the whole image during the rotation.
padX = abs(shiftX);
padY = abs(shiftY);
padded = padarray(image, [padY padX]);
% Rotate the image around the center.
rot = imrotate(padded, angle, method, 'crop');
% Crop the image.
output = rot(padY+1-shiftY:end-padY-shiftY, padX+1-shiftX:end-padX-shiftX, :);
end

