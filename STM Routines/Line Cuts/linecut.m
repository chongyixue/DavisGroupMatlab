function[cut] = linecut(map,x,y,energy,avg_width)
%cut parameters
%(0,0)->(1,0)
[sx,sy,sz] = size(map);
cut = map(1:length(x),length(y)/2,:);
for i = 0:avg_width
    cut = cut + map(1:length(x),length(y)/2 + i,:)+ map(1:length(x),length(y)/2 - i,:);
end
cut = cut/(2*i + 1);
cut = squeeze(cut);

figure;
pcolor(x((end/2+1):end),energy,cut(floor(sx/2):-1:1,:)');
shading flat;
end