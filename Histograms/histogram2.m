function fh = histogram2(fdata1,fdata2,nbins)
[s1x s1y s1z] = size(fdata1);
[s2x s2y s2z] = size(fdata2);
[n1 x1] = hist(reshape(fdata1,s1x*s1y*s1z,1),nbins);
[n2 x2] = hist(reshape(fdata2,s2x*s2y*s2z,1),nbins);

fh = figure; bar(x1,n1./sum(n1)*100,1,'b');
hold on; bar(x2,n2./sum(n2)*100,1,'r');
end
