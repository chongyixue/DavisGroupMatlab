function A = get_points(map,coord,no_points,clmap)

h = figure;
pcolor(map); shading interp; colormap(clmap);
%pcolor(coord,coord,map); shading interp; colormap(clmap);
q=0;s=0;
count = 0;
while ~isempty(q)
    if count ==no_points
        return
    end
   [x1,y1]=ginput(1);
   count = count + 1;
   A(1,count) = x1; A(2,count) = y1;  
   hold on
   q=x1;s=y1;
end
%close ;
end
