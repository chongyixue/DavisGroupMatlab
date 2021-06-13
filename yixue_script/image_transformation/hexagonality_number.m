% 2020-12-14 YXC
% hexagonality from "Hexagonality as a New Shape‑Based Descriptor of Object"
% by Vladimir Ilić1 · Nebojša M. Ralević1
% in an attempt to characterize vmap and Jmap contours



%% functions

function [H,aS,cS,center,angle,S2] = hexagonality_number(image)

% cen = centroid(image);
% nn1 = size(image,1);
% nn2 = size(image,2);
% [XX,YY] = meshgrid(linspace(1,nn1,nn1),linspace(1,nn2,nn2));
% XX = XX.*image;
% YY = YY.image;


[H,S2,center,angle]  = Hnumber(image);
aS = a(S2);
cS = c(S2);


%% B hexagonality

function [H,S2,cn,thetachosen] = Hnumber(S)
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
        thetachosen = theta(i);
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
c = real(c);
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



end