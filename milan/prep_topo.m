function topo=prep_topo(topo)

[sy,sx]=size(topo);

%lines
for j=1:sy
    topo(j,:)=topo(j,:)/sum(topo(j,:))*sx;
end

%plane y
%make xy
xy=nan(sx*sy,2);
for j=1:sx
    xy((j-1)*sy+1:j*sy,1)=1:sy;
    xy((j-1)*sy+1:j*sy,2)=j;
end

topo=reshape(topo,1,sx*sy);

po=polyfitn(xy,topo,...
    'constant, x, y'); %x*x, y*y, x*x*y, x*y*y
topo=topo-polyvaln(po,xy)';

topo=reshape(topo,sy,sx);