function [ctmap new_data] = ct_map(data,flag)
[sx sy sz] = size(data.map);
new_data = data;
%sx =4;
%sy=4;
ctmap = zeros(sx,sy);
%stat_map = zeros(sx,sy);
x = new_data.e;
for i = 1:sx
    for j=1:sy
        if flag ==1    
            y = squeeze(squeeze(new_data.map(i,j,:)));        
            [p,S] = polyfit(x',y,7);
            f = polyval(p,x,S);
            %residual = [(y(1:9)-f(1:9)') (y(end-6:end) - f(end-6:end)')];
            %r = norm(residual);         
            %stat_map(i,j) = r;
            new_data.map(i,j,:) = f;
        end
      
        f = squeeze(squeeze(new_data.map(i,j,:)));
        Y1 = diff(f,1)./diff(new_data.e',1);
        avg1 = mean(Y1(1:9));
        avg2 = mean(Y1(end-6:end));
        avg3 = mean(f(25:65)); %26-65 for 80913

        b1 = f(6) - avg1*new_data.e(6); %f(6) for 80913
        b2 = f(end-4) - avg2*new_data.e(end-4);

        r1 = ((avg3-b1)/avg1);
        r2 = ((avg3-b2)/avg2);
        ctmap(i,j) = r1-r2; %ct value
%        ctmap(i,j) = r1; %pband value
%        ctmap(i,j) = r2; % upper hubbard band values
        if (i == 30 && j==30)
        figure; plot(new_data.e,f,'r',new_data.e,0,'b');
        hold on; plot(r1,0,'ro',r2,0,'bo');
        end
    end
end
figure; pcolor((ctmap)); shading flat;
%stat_map = stat_map/(max(max(stat_map)));

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