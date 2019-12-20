function opsmapcalc(data)





ev = data.e*1000;
map = data.map;

le = length(ev);

% for j = 1:le
%     if ev(j) == 0
%         zlayer = j;
%     elseif ev(j) == -2.3;
%         flayer = j;
%     elseif ev(j) == -1.7;
%         slayer = j;
%     elseif ev(j) == -0.33333
%         tlayer = j;
%     elseif ev(j) == 0.33333
%         folayer = j;
%     elseif ev(j) == 1.7
%         fvlayer = j;
%     elseif ev(j) == 2.3
%         sxlayer = j;
%     end
% end



[nx, ny, nz] = size(map);

opsmap = zeros(nx, ny, 1);

for i=1:nx
    for j=1:ny
        opsmap(i,j,1) = ((mean(map(i,j,13:25))+mean(map(i,j,58:70)))/2 - mean(map(i,j,36:46)))/mean(map(i,j,:));
    end
end


change_color_of_STM_maps(opsmap,'no');

end