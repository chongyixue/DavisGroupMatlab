function O = polar_average_pos(data,angle,ave,cx,cy)
%% 06/04/2013 ANDREY KOSTIN original code modified by P. Sprau for odd
%% number of pixels
%%
if isstruct(data)
    map = data.map;
else
    map = data;
end
    
[ny, nx, nz] = size(map);
coff = min([nx,ny]);
N = floor(coff/2);

theta = linspace(2*pi*(angle-ave/2)/360,2*pi*(angle+ave/2)/360,100);
R = 0:N;
O = zeros(N+1,nz);

for i=1:nz
    for j=1:length(R)
        sum = 0;
        count = 0;
        for k=1:length(theta)
            x = cx+round(R(j)*cos(theta(k)));
            y = cy-round(R(j)*sin(theta(k)));
            if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
              sum=sum+map(x,y,i);
%               figure, img_plot5(map)
%               line(y,x,'Marker','o');
              count = count + 1;
            end
        end
        O(j,i)=sum/count;
    end
end

% close all;

end
