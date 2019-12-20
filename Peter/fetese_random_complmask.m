function rfeat = fetese_random_complmask(feat)

complmask = feat.complmask;

rfeat = feat;

nop = sum(sum(complmask));

[nx, ny, ne] = size(complmask);

rcomplmask = zeros(nx,ny,ne);

for i =1:nop
    x1 = random('unif',0,1,1,1);
    y1 = random('unif',0,1,1,1);
    x1 = round(x1*nx);
    y1 = round(y1*ny);
    if x1 > nx
        x1 = nx;
    end
    if x1 == 0
        x1 = 1;
    end
    if y1 > ny
        y1 = ny;
    end
    if y1 == 0
        y1 = 1;
    end
    
    rcomplmask(x1,y1,1) = 1;
end

img_plot3(complmask);
img_plot3(rcomplmask);

rfeat.complmask = rcomplmask;
end