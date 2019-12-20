function O = polar_average(data,angle,ave)
map = data.map;

[nx ny nz] = size(map);
N = floor(nx/2);
theta = linspace(2*pi*(angle-ave/2)/360,2*pi*(angle+ave/2)/360,100);
R = 1:N;
O = zeros(N,nz);
for i=1:nz
    for j=1:length(R)
        sum = 0;
        count = 0;
        for k=1:length(theta)
            x = N+round(R(j)*cos(theta(k)));
            y = N-round(R(j)*sin(theta(k)));
            if((x>=1)&&(x<=nx)&&(y<=ny)&&(y>=1))
              sum=sum+map(y,x,i);
              count = count + 1;
            end
        end
        O(j,i)=sum/count;
    end
end