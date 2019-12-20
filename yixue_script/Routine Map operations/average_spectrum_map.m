% 2019-9-17 YXC

function av = average_spectrum_map(map,varargin)
data=map.map;
[nx,ny,~] = size(data);
N=nx*ny;
data=sum(data,1:2)./N;
data=squeeze(data);
e=map.e*1000;
if nargin>1
    figure,plot(e,data)
    hold on
    xlabel("mV")
end
    av = data;
end