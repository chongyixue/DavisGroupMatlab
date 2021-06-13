% 2020-3-27 YXC match map1 onto map2 such that the chosen points match 
% as best as they could with strecthing and shifting only 
% (no rotation)
% input map structures into map1 and map2, 
% varargin are point1 from map1, point1 from map2, ...point i from map1
% etc..


function newmap1 = stretch_to_match(map1,map2,varargin)
points = length(varargin)/2;
[nx1,~,~] = size(map1.map);
[nx,~,~] = size(map2.map);

pp1 = cell(1,points);
pp2 = pp1;

for r=1:length(points)
    if mod(r,2)==0
        pp1{r/2} = varargin{r-1};
        pp2{r/2} = varargin{r};
    end
end

plotdefects(max(nx1,nx),'r.',pp1,'b.',pp2);
title('atoms near defects-redTopo,blueconductance maxpix=',num2str(max(nx1,nx)));


function new = gausscenterall(map1,map2,varargin)
% input as such >>gausscenterall([xa1,ya1],[xb1,yb1],...)
n = length(varargin);
new = zeros(2,n);
for i=1:n
    if mod(i,2) == 1
        map = map1;
    else
        map = map2;
    end
    new(:,i) = gausscenter(varargin{i},2,map);
%     varargout{i} = gausscenter(varargin{i},2,map);
end
end

function newcenter = gausscenter(point,halfpix,map)
xpix = point(1); ypix = point(2);
siz = halfpix;
data = map.map(ypix-siz:ypix+siz,xpix-siz:xpix+siz);
[x,~,~] = complete_fit_2d_gaussian(data);
xc = x(2)+xpix-siz-1;
yc = x(4)+ypix-siz-1;
newcenter = [xc,yc];
end

function [xmove,ymove] = translation(varargin)
% input as such >>scalingfunctions([xa1,ya1],[xb1,yb1],...)
% where xbn = x coordinate of defect n in picture b
% we assumed scaling operation is already done
nn = length(varargin)/2;

mov = zeros(nn,2);
Apoints = zeros(nn,2);
Bpoints = zeros(nn,2);

for ii=1:2*nn
    if mod(ii,2)==1
        before = varargin{ii};
        Apoints((ii+1)/2,:) = before;
    else
        mov(ii/2,:) = varargin{ii}-before;
        Bpoints(ii/2,:) = varargin{ii};
    end
end

xmove = sum(mov(:,1))/nn;
ymove = sum(mov(:,2))/nn;


mvdist = @(x) movedmaxdist(x,Apoints,Bpoints);


x0 = [xmove,ymove];
x = fminsearch(mvdist,x0);

xmove = x(1);ymove= x(2);
% x0
% movedmaxdist(x0,Apoints,Bpoints)
% x
% movedmaxdist(x,Apoints,Bpoints)


end
function mxdist = movedmaxdist(moveA,Apoints,Bpoints)
pts = size(moveA,1);
mv = zeros(pts,2);
for q=1:pts
   mv(q,:) =  moveA;
end
Am = Apoints+moveA;
mxdist = maxdistance(Am,Bpoints);

end

function maxdist = maxdistance(Apoints,Bpoints)
% Apoints are matrix Apoints(number,x or y)

dist = (Apoints-Bpoints).^2;
dist = squeeze(sum(dist,2));
maxdist = sqrt(max(dist));
end

function [sx,sy] = scale(varargin)
% input as such >>scalingfunctions([xa1,ya1],[xb1,yb1],...)
% where xbn = x coordinate of defect n in picture b

[a,b,c] = scalingfunctions(varargin{:});

%fit to get sx and sy
x = a./c;
y = b./c;
f = polyfit(x,y,1);
gradient = -1/(f(1));
inter = f(2);
sy = sqrt(1/inter);
sx = sqrt(gradient*sy^2);

end

function [a,b,c] = scalingfunctions(varargin)


% input as such >>scalingfunctions([xa1,ya1],[xb1,yb1],...)
% where xbn = x coordinate of defect n in picture b
% we assume the scale is on the first picture (a), such that
% sx^2(xa1-xa2)^2+sy^2(ya1-ya2)^2 = (xb1-xb2)^2+(yb1-yb2)^2.
% to generate (pairs choose 2) equations in the form
% a_i sx^2 + b_i sx^2 = c_i
npoints = length(varargin)/2;
n = nchoosek(npoints,2);
a = zeros(1,n);
b = a; c=a;

mat = reshape(cell2mat(varargin),2,2,npoints);
% index: mat(x or y, pic 1 or 2, pointnumber)

% generate pairs
pairs = zeros(2,n);
count = 1;
for j=1:npoints-1
    for k = j+1:npoints
        pairs(1,count) = j;
        pairs(2,count) = k;
        count=count+1;
    end
end

for p = 1:n
    p1 = pairs(1,p);p2 = pairs(2,p);%pointnumber
    xa1 = mat(1,1,p1);
    xa2 = mat(1,1,p2);
    ya1 = mat(2,1,p1);
    ya2 = mat(2,1,p2);
    xb1 = mat(1,2,p1);
    xb2 = mat(1,2,p2);
    yb1 = mat(2,2,p1);
    yb2 = mat(2,2,p2);
    
    a(p) = (xa1-xa2)^2;
    b(p) = (ya1-ya2)^2;
    c(p) = (xb1-xb2)^2+(yb1-yb2)^2;
end
end

function plotdefects(pixels,varargin)
% for varargin, put in sequence
% 1-style(eg 'r.')  (optional), followed by
% 2-markersize(optional),followed by
% 3-all the points that you want to have the above style and size.
% then loop back to 1 again if more is needed
% note that 3 is in format of [x1,y1],...
% eg plotdefects(256,'kx',10,[23,51],[33,1],'b.',[60,3])

%assume square, plot boundaries we assume y goes down (negative)
xmin = -0.5;xmax = pixels+0.5;
ymin = -pixels-0.5;ymax = 0.5;
figure,plot([xmin,xmax,xmax,xmin,xmin],[ymax,ymax,ymin,ymin,ymax],'k')
axis off; axis equal; shading flat;
xlim([-1,pixels+1]);ylim([-1-pixels,1]);
hold on

style = 'r.';markersize = 10;
for i=1:length(varargin)
   input = varargin{i};
   if ischar(input)
       style = input;
   elseif length(input)==1
       markersize = inut;
   else
       x = input(1);
       y = input(2);
       plot(x,-y,style,'MarkerSize',markersize)
   end
end
end

function ICRNmap = do_ICRN(RNmap,ICmap)
RN = RNmap.map;
IC = sqrt(ICmap.map);
ICRNmap = ICmap;
ICRNmap.name = 'ICRN';
ICRNmap.map = IC./RN;
img_obj_viewer_test(RNmap)
img_obj_viewer_test(ICmap)
img_obj_viewer_test(ICRNmap);
end

function map = undo_background_subtraction(oldmap)
map = oldmap;
map.map = oldmap.topo1;
end

function topo = fliptopo(oldtopo)
topo = oldtopo;
topo.topo1 = flipud(oldtopo.topo1);
topo.map = flipud(oldtopo.map);
end

end

