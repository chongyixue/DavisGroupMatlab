close all
clear all

%% load and do basic image transformations
% G has been corrected for setup effect via division by the 1st layer of
% the current map
load D:/URU2Si2/G.mat
% get rid of DC signal
Gm = polyn_subtract2(G,0);
% take fourier transform
FFT = fourier_transform2d(Gm,'none','amplitude', 'ft');
% shear correct
map = linear2D_image_correct([-2.23 -2.28],[2.15, -2.35],FFT);
FFT.map = map;
% symmetrize the map
FFT = symmetrize_image(FFT,'vd');
clear map
% do not care about anything within 10 pixel from center
%% taking cut
offset = 7;
%define zero degree cut
% in1 = [100 (100+offset)];
% in2 = [100 180];
in1 = [101+offset 101+offset];
in2 = [181 181];
%in1 = [100 20];
%in2 = [100 100-offset];
% specify the angle
angle = 0;
% compute the cut coordinates
[out1, out2] = coordinates_from_angle(in1,in2,angle,100);
% take the cut;
ln_cut=line_cut_v4(FFT,out1,out2,2);
%ln_cut.cut = flipud(ln_cut.cut);
O = polar_average(FFT,0,360);
O = O((1+offset):80,:);


% plot the cut
figure(1000), imagesc(flipud(ln_cut.cut'));
colormap(gray);
%figure(1001), imagesc(flipud(ln_cut.cut(20:50,25:60)'));
%colormap(gray);
% figure(1002), imagesc(flipud(O'));
% colormap(gray);

%ln_cut.cut=O;

%% extracting QPI

x = (1+offset):(length(ln_cut.cut(:,1))+offset);
x1 = 1:length(ln_cut.cut(1,:));
s=54;
y = ln_cut.cut(s,:);

x2 = 30:60;
%test_fit = -25*x2+1900+45000./((x2-45).^2+8.^2);
%figure(10), plot(x1,y,'.k',x2,test_fit,'.r');
%figure(10), plot(x1,y,'.k');
%[pks, loc] = findpeaks(y,'SORTSTR','descend');
sel = (max(y)-min(y))/8;
%peakfinder(y,sel);

%getpeak(y,[30 60],sel,5)

%figure(10), plot(x,ln_cut.cut(:,55),'.k');

% initial guess for background + lorentzian fit
%guess = [5000 0.1 20000 40 10 150];
%[y_new, p] = complete_fit(ln_cut.cut(:,30),[offset+1 80],guess);
%plot_linecut(ln_cut,10,9,3);


% s = 44;
% [y_new, p] = complete_fit_double_peak(ln_cut.cut(:,s),[offset+1 80],guess,1000*ln_cut.e(s));
% xp = (1+offset):80;
% test_fit = 13000*exp(-0.16*xp)+27000./((xp-28).^2+7.5.^2)+10000./((xp-18).^2+4.^2)+150;
%figure(10), plot(xp,ln_cut.cut(:,s),'.k',xp,test_fit,'-r');
s = 22;
f = ln_cut.cut(s-1,:)+ln_cut.cut(s,:)+ln_cut.cut(s+1,:);
figure(10), plot(1:81,f,'.k');
sel = (max(f)-min(f))/16
p=peakfinder(f,sel)


%------------------------------------------------------------------
%  horizontal fits for the light band [-5.25mV--->1.00mV]
guess = [5000 0.1 40000 28 10 150];
N1=1;
N2=41;

q = zeros(1,N2-N1+1);
t=1;
for k=N1:N2
    [y_new, p] = complete_fit(ln_cut.cut(:,k),[offset+1 80],guess,1000*ln_cut.e(k));
    guess = coeffvalues(p);
    q(t) = guess(4);
    t = t+1;
end
%----------------------------------------------------------------
% horizontal fits for the double peak
guess_double = [13000 0.16 27000 28 7.5 10000 18 4 150];

M1=38;
M2=81;
q2l = zeros(1,M2-M1+1);
q2h = zeros(1,M2-M1+1);
t=1;

for k=M1:M2
    [y_new, p] = complete_fit_double_peak(ln_cut.cut(:,k),[offset+1 80],guess_double,1000*ln_cut.e(k));
    guess_double = coeffvalues(p);
    q2l(t) = guess_double(4);
    q2h(t) = guess_double(7);
    t = t+1;
end
%------------------------------------------------------------------
% vertical peak find for q [M1+offset,M2+offset]
O1 = 1;
O2 = 15;
e = zeros(1,O2-O1+1);
t=1;
prev_peak = 38;
for k=O1:O2
    
    peak = round(getpeak(ln_cut.cut(k,:),[30 60],sel,5,prev_peak));
    e(t)=G.e(peak);
    prev_peak = peak;
    t = t+1;
end
%-----------------------------------------------------------------------
% vertical peak find for q [M1+offset,M2+offset]
P1 = 22;
P2 = 27;
e2low = zeros(1,P2-P1+1);
e2high = zeros(1,P2-P1+1);
t=1;

for k=P1:P2
    f = ln_cut.cut(k-1,:)+ln_cut.cut(k,:)+ln_cut.cut(k+1,:);
    %figure(11), plot(1:81,f,'.k');
    sel = (max(f)-min(f))/16;
    loc = peakfinder(f,sel);
    loc = loc(loc>25&loc<55);
    e2low(t)=G.e(loc(1));
    e2high(t)=G.e(loc(2)); 
    t = t+1;
end
% 
%---------------------------------------------------------------------
% plot result
figure(500), plot(q,1000*G.e(N1:N2),'.k',q2l,1000*G.e(M1:M2),'.g',q2h,1000*G.e(M1:M2),'.g',(O1+offset):(O2+offset),1000*e,'.r',(P1+offset):(P2+offset),1000*e2low,'.r',(P1+offset):(P2+offset),1000*e2high,'.r');
axis([0 80 -10 10]);









% guess_s = guess;
% % horizontal fits for the light band [1.00mV--->-10mV] going down
% % V1 = 1;
% % V2 = 45;
% % q3 = zeros(1,V2-V1+1);
% % for k=V1:V2
% %     %[y_new, p] = complete_fit(ln_cut.cut(:,V2-k+V1),[offset+1 80],guess);
% %     [y_new, p] = complete_fit(O(:,V2-k+V1),[offset+1 80],guess);
% %     guess = coeffvalues(p);
% %     q3(V2-k+1) = guess(4);
% %     t = t+1;
% % end
% 
% guess = guess_s;
% % horizontal fits for the light band [10.00mV---->2.50mV]
% m1=51;
% m2=81;
% q2 = zeros(1,m2-m1+1);
% t=1;
% for k=m1:m2
%     [y_new, p] = complete_fit(ln_cut.cut(:,m2-k+m1),[offset+1 80],guess);
%     guess = coeffvalues(p);
%     q2(m2-k+1) = guess(4);
%     t = t+1;
% end
% 
% % double peak fit for the heavy band hydridization [1.25mV --->2.25mV]
% p1=46;
% p2=50;
% qml = zeros(1,p2-p1+1);
% qmh = zeros(1,p2-p1+1);
% t=1;
% xp = (offset+1):80;
% guess = [30000 0.19 50000 27 9 50000 42 9 130];
% for k=p1:p2
%     [y_new, p] = complete_fit_double_peak(ln_cut.cut(:,p2-k+p1),[offset+1 80],guess);
%     figure(k), plot(xp,y_new,'-r',xp,ln_cut.cut(:,p2-k+p1),'.k');
%     guess = coeffvalues(p);
%     qml(p2-k+1) = guess(4);
%     qmh(p2-k+1) = guess(7);
%     t = t+1;
% end
% % s = 48;
% % y = ln_cut.cut(:,s);
% % ytry = 30000*exp(-0.19*xp)+50000./((xp-27).^2+9^2)+50000./((xp-42).^2+9^2)+130;
% % guess = [30000 0.19 50000 27 9 50000 42 9 130];
% % %guess = [30000 0.19 50000 27 9 200 ];
% % [yfit, p] = complete_fit_double_peak(y,[offset+1 80], guess);
% % figure(100), plot(xp,y,'.k',xp,ytry,'-r',xp,yfit,'-g');
% 
% % vertical peak find for q [M1+offset,M2+offset]
% M1 = 1;
% M2 = 20;
% e = zeros(1,M2-M1+1);
% t=1;
% prev_peak = 38;
% for k=M1:M2
%     
%     peak = round(getpeak(ln_cut.cut(k,:),[30 60],sel,5,prev_peak));
%     e(t)=G.e(peak);
%     prev_peak = peak;
%     
%     t = t+1;
% end
% 
% % vertical peak find for q [n1+offset,n2+offset]
% n1 = 35;
% n2 = 70;
% e2 = zeros(1,n2-n1+1);
% t=1;
% sel = sel*1.5;
% prev_peak = 48;
% for k=n1:n2
%     
%     peak = round(getpeak(ln_cut.cut(k,:),[30 50],sel,5,prev_peak));
%     e2(t)=G.e(peak);
%     prev_peak = peak;
%     t = t+1;
% end
% %figure(500), plot(q,1000*G.e(N1:N2),'.k',q3,1000*G.e(V1:V2),'.k',(M1+offset):(M2+offset),1000*e,'.k',q2,1000*G.e(m1:m2),'.k',qml,1000*G.e(p1:p2),'.k',qmh,1000*G.e(p1:p2),'.k',(n1+offset):(n2+offset),1000*e2,'.k');
% figure(500), plot(q,1000*G.e(N1:N2),'.k',(M1+offset):(M2+offset),1000*e,'.k',q2,1000*G.e(m1:m2),'.k',qml,1000*G.e(p1:p2),'.k',qmh,1000*G.e(p1:p2),'.k',(n1+offset):(n2+offset),1000*e2,'.k');
% % %figure(500), plot(q,1000*G.e(N1:N2),'.k',(M1+offset):(M2+offset),1000*e,'.k',q2,1000*G.e(m1:m2),'.k');
% % 
% % axis([0 80 -5 10]);