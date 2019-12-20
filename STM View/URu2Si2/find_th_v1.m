function S = find_th_v1(img,crop_width)
cw = crop_width;
A = pick_pts(img);
uiwait;
n = size(A,1);
S = zeros(n,2);
img_plot2(img);
for i = 1:n
    x = A(i,1); y = A(i,2);
    box = img(y-cw:y+cw,x-cw:x+cw);
    [ymax xmax] = find(abs(box) == max(max(abs(box))));
    %box(ymax,xmax)
    %img_plot2(box); hold on; plot(ymax,xmax,'rx');
    xmax = x + (xmax - (cw+1)); ymax = y + (ymax - (cw+1));
    S(i,1) = xmax; S(i,2) = ymax;
    hold on; plot(xmax,ymax,'rx');
    hold on; plot(x,y,'go');
end

end