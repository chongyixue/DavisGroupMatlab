%%
px_n = 200;
x = 0:px_n-1;
y = x;
[xx yy] = meshgrid(x,y);
z = zeros(px_n-1,px_n-1);
for i = 1:10:px_n-1
    for j = 1:10:px_n-1
        z(i,j) = 1;
    end
end
img_plot2(z);
%%
img_plot2(xcorr2(z));
%%
f=fft2(z-mean(mean(z)));
f=fftshift(f);
f=abs(f);
% 
 img_plot2((f));
 %%
 %%
n=250;
ov=3;
nr=35;
sigma=2;
a=zeros(n);
noise1=.0;
noise2=0;
x=1:n;
[yy,xx]=ndgrid(x,x');
uvx=peaks(n)/3;
xx=xx+0*uvx';
for j=-ov:nr+ov
   for k=-ov:nr+ov
       a=a+...
           gauss2d(xx,yy,...
           ([k,j]+noise1*rand(1,2))/nr*n,10,sigma);
   end
end
a=a+noise2*rand(n);
figure(1)
pcmy(a);

shading flat
axis square
figure(2)
ff=myfft2(a);
%ff=ff(91:110,141:160);
pcmy((ff),[0 .1]);
shading flat
colormap gray