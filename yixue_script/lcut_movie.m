
data   = test;
x1     = 200;
y1     = 200;
x2     = 400;
y2     = 200;
av_pix = 5;

cuttest = line_cut_v4(data,[x1 y1],[x2 y2],av_pix);

energylayer = 10;
figure()
plot(cuttest.r,cuttest.cut(:,energylayer))