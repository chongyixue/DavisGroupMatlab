function [x y] = bin_plot(img_to_bin,data,nbin)

[bin_img binval] = bin_map(img_to_bin,nbin,min(min(img_to_bin)),max(max(img_to_bin)));

%A = zeros(nbin);

for i = 1:nbin
    tmp = (bin_img == binval(i));
    A(i) = mean(data(tmp));
end
A
figure; plot((binval),abs(A),'x');
binval

end