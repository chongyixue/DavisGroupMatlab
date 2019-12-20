function fh = histogram4(fdata1,fdata2,fdata3,fdata4,nbins)
[s1x s1y s1z] = size(fdata1);
[s2x s2y s2z] = size(fdata2);
[s3x s3y s3z] = size(fdata3);
[s4x s4y s4z] = size(fdata4);
[n1 x1] = hist(reshape(fdata1,s1x*s1y*s1z,1),nbins);
[n2 x2] = hist(reshape(fdata2,s2x*s2y*s2z,1),nbins);
[n3 x3] = hist(reshape(fdata3,s3x*s3y*s3z,1),nbins);
[n4 x4] = hist(reshape(fdata4,s4x*s4y*s4z,1),nbins);

fh = figure; bar(x1,n1./sum(n1)*100,1,'b');
hold on; bar(x2,n2./sum(n2)*100,1,'r');
hold on; bar(x3,n3./sum(n3)*100,1,'r');
hold on; bar(x4,n4./sum(n4)*100,1,'r');
end
