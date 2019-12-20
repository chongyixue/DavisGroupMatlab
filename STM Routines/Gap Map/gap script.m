%% 
mx = 76;
mn = 1;
g = G.ave(mn:mx);
x = g.e(mn:mx);


%%
g = squeeze(squeeze(G.map(60,60,:)));
clear p;
mx = 76;
mn = 1;
x = G.e(mn:mx);
y = g(mn:mx);
%tic
[p,S] = polyfit(x',y,22);
%toc
f = polyval(p,x);
figure; plot(x,f,'b',x,y,'r');
%figure; plot(1:90,f,'b',1:90,y,'r');
%figure; plot(G.e,p(1)*(G.e.^2) + p(2)*G.e + p(3));
%hold on; plot(G.e,g,'r')
%% omega map
g = squeeze(squeeze(Gmod.map(64,57,:)));
%clear p;
mx = 131;
mn = 50;
x = G.e(mn:mx);
y = g(mn:mx);
%tic
[p,S] = polyfit(x',y,4);
%toc
f = polyval(p,x);
figure; plot(x,f,'b',x,y,'ro');
%figure; plot(1:90,f,'b',1:90,y,'r');

%% find max slope for omega map

diff1 = diff(f,1);
ind = find(diff1 == max(diff1));
figure; plot(x,f,'b');
hold on;
plot(x(39),f(39),'ro');
%%
clear x p y mx mn f S g f
%%


Y1 = diff(f,1);
Y2 = diff(f,2);
figure; plot(G.e,f,'r',G.e,0,'b');
figure; plot(1:80,abs(Y),'b',1:80,0,'r');

%find first minimum
%[C1 I1] = [nan nan];

for i=2:floor(80/2)-1
    if (Y1(i-1) < 0 && Y1(i+1) > 0)
        C1 = f(i); I1 = i;
        break;
    end
end
for i=79:-1:ceil(80/2)+1
    if (Y1(i+1) > 0 && Y1(i-1) < 0)
        C2 = f(i); I2 = i;
        break;
    end
end
%     [C1 I1] = min(abs(Y(i:i+5)));
%     [C2 I2] = min(abs(Y(i+1:i+6));

%%
Y1 = diff(f,1)./diff(G.e,1);
avg1 = mean(Y1(1:9));
avg2 = mean(Y1(end-6:end));

b1 = f(6) - avg1*G.e(6);
b2 = f(end-4) - avg2*G.e(end-4);

r1 = -b1/avg1;
r2 = -b2/avg2;
figure; plot(G.e,f,'r',G.e,0,'b');
hold on; plot(r1,0,'ro',r2,0,'bo');
%%
figure; plot(reshape(gmap,128*128,1),reshape(ctmap,128*128,1),'ro');
%%
[k f] = fourier_block(ctmap-mean(mean(ctmap)),G.r,'kaiser');
figure; pcolor(k,k,fftshift(abs(f))); shading flat; colormap(defect);
[k2 f2] = fourier_block(t-mean(mean(t)),G.r,'kaiser');
figure; pcolor(k2,k2,fftshift(abs(f2))); shading flat; colormap(defect);

