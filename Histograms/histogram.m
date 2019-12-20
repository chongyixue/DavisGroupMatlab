function fh = histogram(fdata,nbins)
[sx sy sz] = size(fdata);
[n x] = hist(reshape(fdata,sx*sy*sz,1),nbins);

fh = figure; bar(x,n./sum(n)*100,1);
end
