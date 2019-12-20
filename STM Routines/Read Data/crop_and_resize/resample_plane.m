function new = resample_plane(a)
%resample plane, anz size, even numer in each direction
[x,y]=size(a);
new=zeros(x/2,y/2);
for j=1:x/2
        for k=1:y/2
    new(j,k)=sum(sum(( a(((j-1)*2+1):(j*2) , ((k-1)*2+1):(k*2) ))));
        end
end


