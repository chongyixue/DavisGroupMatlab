for i=1:128*128;
    gmIDL(data(i,1)+1,data(i,2)+1) = data(i,5);
end
%% Down sample 

gmIDLdown = zeros(64,64);
tmp = zeros(128,128);
for i=1:128
    for j=1:128
        tmp(i,j) = mod(j,2)*mod(i,2);
    end
end
   
gmIDL_down = gmIDL(logical(tmp));
gmIDL_down = reshape(gmIDL_down,64,64);