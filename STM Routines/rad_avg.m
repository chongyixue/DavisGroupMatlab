function cut = rad_avg(map,x,y,energy,avg_width)
cut = 0;
for i = 1:72
    cut = cut + linecut(rotate_map(map,i*5),x,y,energy,avg_width);
end
cut = cut/72;