function new = resample_energy(a)
% XXX resamples block
[sx,sy,sz]=size(a(:,:,:));
new=zeros(sx,sy,sz/2);
for k=1:sz/2
    new(:,:,k)=a(:,:,(k-1)*2+1)+a(:,:,(k)*2);
    
end
