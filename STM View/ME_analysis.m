% data points

r = [35 75 115 155] + 3 + 1;
c = [46 76 106 136 166] + 1;

%[X Y] = meshgrid(c,r);
hold on;
plot(X,Y,'go');
%%
read_pointspectra;
%%
S01f = fix_spect(S01);

%%
ss = S01f;
figure; plot(ss.energy,ss.spect/max(ss.spect));
title('S01')
rr = r(1);  cc = c(1);
y = squeeze(squeeze(G.map(rr,cc,:))); y = y/max(y);
hold on; plot(G.e*1000,y,'r');