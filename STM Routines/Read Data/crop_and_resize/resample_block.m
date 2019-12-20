function new = resample_block(a)
% XXX resamples block
[x,y,z]=size(a(:,:,:));
new=zeros(floor(x/2),floor(y/2),z);
for i=1:z
    for j=1:floor(x/2)
        for k=1:floor(y/2)
             new(j,k,i)=...
                 sum(sum(( a(((j-1)*2+1):(j*2) ,...
                 ((k-1)*2+1):(k*2) , i))))/4;
        end
    end
end
