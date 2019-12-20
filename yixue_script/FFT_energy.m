

%% example playaround code for FFTshift shit
%2017/11/18 YXC
% clear data;
% clear xx;
% N=201;
% k=7;
% for n=1:N
%     xx(n) = (n-(N+1)/2)*0.1+0.1;
%     data(n) = sin(k*n*2*pi/N)+4+2*cos((k+3)*n*2*pi/N+33);
%     %data(n) = sin(n*2*pi/N)+0.8*sin(n*2*pi/N+40);
% end
%
% figure,
% plot(xx,data)
%
%
% figure, plot(xx,fftshift(abs(fft(data))))

%%
clear data;
clear xx;
clear x;
clear y;
clear yy;

[y,x] = read_pointspectra3('71117A04');
% figure, plot(x,y);
data = y;
% figure, plot(x,fftshift(abs(fft(data))))
% hold on
% xlabel('energy(meV)');

% list = [1:13,40:44,64:65,80:95,106:111,135:140,180:200];
list = [1:3,14,46,64,80,90,109,138,190,201];

for n = 1:length(list)
    m=list(n);
    xx(n) = x(m);
    yy(n) = y(m);
end

figure(),
plot(x,y,'r.');
hold on
plot(xx,yy,'b.');

% play-polynomial fit
% for n=1:30
%     yy(n)=n^3-4*n^2+0.3-exp(n*0.001);
%     xx(n)=n*0.3-8;
% end

p = polyfit(xx,yy,4);
y1=polyval(p,x);
figure,
plot(x,y,'g.')%green for whole curve
hold  on
plot(x,y1,'b')%blue for fitted background curve
hold on
plot(xx,yy,'r.')%red for points for poly-fit


data2 = data - polyval(p,x);
figure, plot(x,data2,'b.')
figure, plot(x,fftshift(abs(fft(data2))))
hold on
xlabel('energy(meV)');
hold on
plot(x,fftshift(abs(fft(data))),'b')
