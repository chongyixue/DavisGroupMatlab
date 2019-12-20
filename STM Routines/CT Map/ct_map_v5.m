%%%%%%
%For STM1 data set 60119A00
%%%%%%

function fit_map = ct_map_v5(map,energy)
load_color;
[sx sy sz] = size(map);
%sx =20;
%sy=20;
c1 = zeros(sx,sy);
c2 = zeros(sx,sy);
r1 = zeros(sx,sy);
r2 = zeros(sx,sy);

avg_map = zeros(sx,sy);

x = energy;
x1= x(1:8);
x2 = x(68:end);
for i = 1:sx
    i
    for j=1:sy  
            y = squeeze(squeeze(map(i,j,:)));
            y1 = y(1:8);                    
            y2 = y(68:end);                    
            [p1,S1] = polyfit(x1',y1,1);
            c1(i,j) = p1(1); r1(i,j) = p1(2);
            [p2,S1] = polyfit(x2',y2,1);
            c2(i,j) = p2(1); r2(i,j) = p2(2);
            avg_map(i,j) = mean(y(30:50));                                    
    end
end
fit_map.r1 = r1;
fit_map.r2 = r2;
fit_map.c1 = c1;
fit_map.c2 = c2;
fit_map.avg = avg_map;
img_plot2(c1,Cmap.Defect1,'c1');
img_plot2(c2,Cmap.Defect1,'c2');
img_plot2(r1,Cmap.Defect1,'r1');
img_plot2(r2,Cmap.Defect1,'r2');
img_plot2(avg_map,Cmap.Defect1,'avgmap');

end

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
%        % y = squeeze(squeeze(data.map(i,j,:)));
%        % [p,S] = polyfit(x',y,7);
%         %f = polyval(p,x);        
%         %new_data.map(i,j,:) = f;
%         f = squeeze(squeeze(new_data.map(i,j,:)));
%         Y1 = diff(f,1);
%         Y2 = diff(f,2);
%         for i=2:floor(80/2)-1
%             if (Y1(i-1) < 0 && Y1(i+1) > 0)
%                 C1 = f(i); I1 = i;              
%                 break;
%             end
%         end
%         for i=79:-1:ceil(80/2)+1
%             if (Y1(i+1) > 0 && Y1(i-1) < 0)
%                 C2 = f(i); I2 = i;
%                 break;
%             end
%         end
%         figure; subplot(3,1,1); plot(data.e,f,'r',data.e(I1),0,'bo',data.e(I2),0,'ko');
%         subplot(3,1,2); plot(1:80,Y1,'r',(I1),0,'bo',(I2),0,'ko');
%         subplot(3,1,3): plot(1:79,Y2,1:79,0,'r');
%         ctmap(i,j) = data.e(I1) - data.e(I2);
%     end
% end
% figure; pcolor(ctmap); shading flat;
% end