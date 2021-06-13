% 2020-4-9 YXC
% scale map2 to match map1 given two coordinates each

% points are in (xpix,ypix) form
function newmap2 = scale_to_match(map1,pa1,pa2,map2,pb1,pb2)

%% find the scaling such that for a point in map2, point*scale+move=map1point
d1 = pb1-pa1;
d2 = pb2-pa2;
dp = d1-d2;

dx = pb2(1)-pb1(1);
dy = pb2(2)-pb1(2);

% scale, then move
sx = 1+(dp(1)/dx);
sy = 1+(dp(2)/dy);

x0 = sx*pb1(1);% coordinate after scaling
y0 = sy*pb1(2);
xtarg = pa1(1);% target coordinate
ytarg = pa1(2);
xmove = xtarg-x0;%for every point, you scale, then move xmove/ymove pixels
ymove = ytarg-y0;


%% use scaling and translation found to interpolate everypoint
[nx,~,~] = size(map1.map);
[nx2,~,~] = size(map2.map);
X = linspace(1,nx,nx);
Y = X;

X = (X-xmove)/sx;
Y = (Y-ymove)/sy;
% X = X*sx+xmove;
% Y = Y*sy+ymove;

assignin('base','X',X)

newmap2 = map1;
newmap2.name = map2.name;
newmap2.ops = map2.ops;
newmap2.ops{end+1} = 'scale';
newmap2.type = map2.type;
newmap2.var = map2.var;

for i = 1:nx
    for j=1:nx
        x = X(i);y=Y(j);
        if x>=1 && y>=1 && x<=nx2 && y<=nx2
            newmap2.map(j,i) = pixel_val_interp(map2.map,x,y);
        else
            newmap2.map(j,i)=0;
        end
    end
end



end




