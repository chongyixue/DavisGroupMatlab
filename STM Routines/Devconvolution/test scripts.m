%% (de)convolution script
spc = 0.01;
x = -5:spc:5;
n = length(x);
y =sin(x);
VA = 1;
%d = floor(VA/D);
s = zeros(1,n);

for i = 1:n
    s(i) = 1/(VA^2)*sum(res_func(x,VA,x(i)).*y)*spc;
end
%%

figure; plot(x,y); hold on; plot(x,s,'r');
%%
spc = 0.25;
x = -5:spc:10;
VA = spc + spc/100000;
y = x.^3;
y2 = LIA_conv(x,y,VA,1);
figure; plot(x,y2); hold on; plot(x,y,'r');
%%
en = G.e*1000;
sp = G.ave';
%%
spc = abs(en(1) - en(2));
VA = spc + spc/100000;
sp2 = LIA_conv(en,sp,VA,1);
figure; plot(en,sp2); hold on; plot(en,sp,'r');
%%
x = -5:0.25:5;
y = exp(-abs(x)).*sin(x);
figure; plot(x,y)
%%
%spc = abs(en(1) - en(2));
%VA = spc + spc/100000;
tic;
d_sp = RL_dconv(x,y,VA);
toc;
%%
figure; plot(x,y); hold on; plot(x,d_sp(end,:),'r');


%%
d_sp_c = LIA_conv(x,d_sp(end,:),VA,1);
figure; plot(x,d_sp_c,'rx'); hold on; plot(x,y);


%%
p = polyfit(en,sp,17);
y = polyval(p,en);
%%
figure; plot(x,conv(res_func(x,VA,0),y,'same')); hold on; plot(x,y,'r')
%%
figure; plot(x,res_func(x,VA,39),'o');
%%
yres = res_func(x,VA,38);
area = sum(2*yres)
figure; plot(x,yres/area,'o');