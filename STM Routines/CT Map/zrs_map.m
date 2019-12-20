function [zrsmap new_data] = zrs_map(data,flag)
[sx sy sz] = size(data.map);
new_data = data;
new_data.map = new_data.map(:,:,1:53);
new_data.e = new_data.e(1:53);
%sx =4;
%sy=4;
zrsmap = zeros(sx,sy);
x = new_data.e;
for i = 1:sx
    for j=1:sy
        if flag ==1    
            y = squeeze(squeeze(new_data.map(i,j,:)));        
            [p,S] = polyfit(x',y,9);
            f = polyval(p,x,S);
            new_data.map(i,j,:) = f;
        end
      
        f = squeeze(squeeze(new_data.map(i,j,:)));
        der = diff(f);
        for k=52:-1:2
            if (der(k) < 0 && der(k-1) > 0)
                break;
            end
        end
        zrsmap(i,j) = (x(k+1)+x(k))/2; 
%    figure; plot(x,f,'b.');
%    hold on; plot(x(i+1),f(i+1),'ro');
    end    
end
figure; pcolor(zrsmap); shading flat;
end
