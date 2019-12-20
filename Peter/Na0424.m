clear all
close all
%load('C:/Users/feynman/Documents/MATLAB/Analysis Code/MATLAB/STM View/Color Maps/GrayInverse.mat')
%% load maps
% 33 mK data of the band closest to the chemical potential; 0 T
load C:\Users\Peter\Desktop\Cornell_PhD\Data\NaFeCoAs_data\April_2013\04_24_13\NaFeAs30424A00.mat
% load D:/NaFeAs/130424/FFT30424.A00.mat
%%
G=obj_30424A00_G;
I=obj_30424A00_I;
T=obj_30424A00_T;

%%

g=current_divide2(G,I);

g = polyn_subtract2(g,0);
% Gfilt = gauss_filter_image(G,9,3);
%Ffilt = gauss_filter_image(F,9,3);
%FFT = fourier_transform2d(Gm,'none','amplitude', 'ft');
FFT = fourier_transform2d(g,'none','amplitude', 'ft');

%% Feenstra

g=G;
Imap = I.map;
% zero_energy = find(g.e == 0);
% zero_energy = 1;
%current_offset = mean(mean(Imap(:,:,zero_energy)));
current_offset = 0;
for i = 1:length(g.e)
 %   Imap(:,:,i) = Imap(:,:,i) - Imap(:,:,zero_energy);
    g.map(:,:,i) = g.map(:,:,i)./Imap(:,:,1);
end
% new_Gdata = Gdata;
% new_Gdata.map = new_map;
% new_Gdata.ave = squeeze(squeeze(mean(mean(new_Gdata.map))));

g = polyn_subtract2(g,0);
% Gfilt = gauss_filter_image(G,9,3);
%Ffilt = gauss_filter_image(F,9,3);
%FFT = fourier_transform2d(Gm,'none','amplitude', 'ft');
FFT = fourier_transform2d(g,'none','amplitude', 'ft');


%%
%FFT_feenstra = fourier_transform2d(Ffilt,'none','amplitude', 'ft');
% mapfilt = linear2D_image_correct([-2.23 -2.28],[2.15 -2.35],FFTfilt);
%mapfiltF = linear2D_image_correct([-2.23 -2.28],[2.15, -2.35],FFT_feenstra);
%map = linear2D_image_correct([-2.23 -2.28],[2.15, -2.35],FFT);
% FFTfilt.map = mapfilt;
%FFT_feensta.map = mapfiltF;
%FFT.map = map;
FFT=symmetrize_image_v2(FFT,'vd');
img_obj_viewer2(FFT);
%FFT_feenstra=symmetrize_image(FFT_feenstra,'vd');
%FFT = symmetrize_image(FFT,'vd');
% clear  mapfilt mapfiltF map

%%
ln_cut=line_cut_v4(FFT,[128 128],[256 128],2);
%ln_cut2=line_cut(FFTfilt,[100 100],[100 170],1);
%ln_cutF=line_cut(FFT_feenstra,[100 100],[100 190],1);

for i=1 : 30
    figure(i); plot(1:128,(ln_cut.cut(:,i)),'.k');
end

%%

FFT424 = FFT;
clear FFT


%% display maps
img_obj_viewer2(FFT424);
% img_obj_viewer2(FFT18);
% img_obj_viewer2(FFT15);

%% taking cut
offset = 4;
%define zero degree cut
% in1 = [65 (65+offset)];
% in2 = [65 129];

in1 = [(129+offset) (129)];
in2 = [257 129];

%in1 = [101+offset 101+offset];
%in2 = [181 181];
%in1 = [100 20];
%in2 = [100 100-offset];
% specify the angle
angle = 45;
% compute the cut coordinates
[out1, out2] = coordinates_from_angle(in1,in2,angle,129);
% take the cut;
ln_cut424=line_cut_v4(FFT424,out1,out2,5);
% plot the cut
figure(1424), imagesc(flipud(ln_cut424.cut'));
% figure(1425), imagesc((ln_cut424.cut'));
%colormap(GrayScaleMod);
colormap(gray);

% for i=1 : 30
%     figure(i); plot(1:88,(ln_cut424.cut(:,i)),'.k');
% end

%% polar average

O = polar_average_odd(FFT424,0,360);
figure(1426), imagesc(flipud(O'));

for i=1 : 31
    figure(i); plot(1:129,(O(:,i)),'.k');
    title([num2str(ln_cut424.e(i)*1000) 'mV ' 'single peak']);
end

% figure;
% hold on
% for i=1 : 31
%     plot(1:129,((O(:,i))/max(O(:,i)))+i*0.1,'.k');
%     title([num2str(ln_cut424.e(1)*1000) 'mV to ' num2str(ln_cut424.e(end)*1000)  'mV single peak']);
% end
% hold off
%%
offset=4;
x = (1+offset):(length(ln_cut424.cut(:,1))+offset);
% x = (1+offset):(length(O(:,1))+offset);
% guess = [0.8 0.11 0.5 38 10 0.004];
guess = [0.6 0.15 0.4 40 3 0.004];
%guess = [0.3 0.07 0.5 20 2.3 0.03];

% --------------------------------------------------------------------------
% single_peak fit for the light band -4mV-------> -3.25mV
% 0T
A1=6;
A2=31;
q424 = zeros(1,A2-A1+1);
%guess15 = [0.7 0.07 0.5 15 4 0.3 25 4 0.3 45 2 0.05];
%guess04 = [0.72 0.13 2 15 4.5 1.1 26 3.5 0.05 48 3 0.23];
%guess522 = [3000 0.07 5000 15 7 500];
guess424 = guess;
tol = 1e-6;
t=1;
for k=A1:A2
    test2=ln_cut424.cut(:,k)/max(ln_cut424.cut(:,k));
    [y_new, p] = complete_fit(test2,[x(1) x(end)],guess424,1000*ln_cut424.e(k));
%     [y_new, p] = complete_fit(ln_cut424.cut(:,k),[x(1) x(end)],guess424,1000*ln_cut424.e(k));
%     test=O(:,k)/max(O(:,k));
%     [y_new, p] = complete_fit(test,[x(1) x(end)],guess424,1000*ln_cut424.e(k));
    guess424 = coeffvalues(p);
%     x0 = guess522(4);
%     m = FFT522.map((65+offset):(65+x0+5),(65+offset):(65+x0+5),k);
%     [fp] = complete_fit2D(m,tol,guess522,[(1+offset) (1+x0+5)]); 
%     q522_2d(t)=fp(4);
    q424(t) = guess424(4);
    t = t+1; 
end

plot(q424,ln_cut424.e(A1:A2),'.')
% guess528 = [1.9 0.6 6 9.5 5.1 0.085];
% B1=20;
% B2=33;
% q528_2 = zeros(1,B2-B1+1);
% t=1;
% for k=B1:B2
%     [y_new, p] = complete_fit(ln_cut528.cut(:,k),[x(1) x(end)],guess528,1000*ln_cut528.e(k));
%     guess528 = coeffvalues(p);
% %     x0 = guess522(4);
% %     m = FFT522.map((65+offset):(65+x0+5),(65+offset):(65+x0+5),k);
% %     [fp] = complete_fit2D(m,tol,guess522,[(1+offset) (1+x0+5)]); 
% %     q522_2d_2(t)=fp(4);
%     q528_2(t) = guess528(4);
%     t = t+1; 
% end
% % 
% q528 = (q528-1)/56*sqrt(2);
% q528_2 = (q528_2-1)/56*sqrt(2);
% % 
% q_hand = [64 64.5 64 64.5 64.75 65 65 65 65.25 65 64 64 68 69.5 71 71 71 75 64 65 65 65 65 65 65 65.25 65.50 65 65 64.75 64.50 64 63.50];
% q_hand = q_hand - 56;
% q_hand = (q_hand-1)/56*sqrt(2);
% % 
% q=[q528 q528_2];
% %figure(528), plot(q528,1000*ln_cut528.e(A1:A2),'.k')
% figure(528), plot(q528,1000*ln_cut528.e(A1:A2),'.k',q528_2,1000*ln_cut528.e(B1:B2),'.k');
% % %figure(522), plot(q522,1000*ln_cut522.e(A1:A2),'.k',q522_2,1000*ln_cut522.e(B1:B2),'.k',q_hand,1000*ln_cut522.e,'.r');
% % figure(528), plot(q,1000*ln_cut528.e,'.k');
% % %figure(522), plot(q,1000*ln_cut522.e,'.k',q_hand,1000*ln_cut522.e,'.r');
% axis([0.1 0.6 -5 0.5]);
% title('0.150 T');
% xlabel('q (pi/delta(x))');
% ylabel('bias (mV)');
% % 
% % 
% figure(523), plot(q_hand,1000*ln_cut528.e,'.k');
% axis([0.1 0.6 -5 0.5]);
% title('0.150 T');
% xlabel('q (pi/delta(x))');
% ylabel('bias (mV)');