close all
clear all
%load D:/URU2Si2/F.mat
%F.var = 'F';
load D:/URU2Si2/G.mat

%Gm = polyn_subtract2(G,0);
Gfilt = gauss_filter_image(G,9,3);
%Ffilt = gauss_filter_image(F,9,3);
%FFT = fourier_transform2d(Gm,'none','amplitude', 'ft');
FFTfilt = fourier_transform2d(Gfilt,'none','amplitude', 'ft');
%FFT_feenstra = fourier_transform2d(Ffilt,'none','amplitude', 'ft');
mapfilt = linear2D_image_correct([-2.23 -2.28],[2.15 -2.35],FFTfilt);
%mapfiltF = linear2D_image_correct([-2.23 -2.28],[2.15, -2.35],FFT_feenstra);
%map = linear2D_image_correct([-2.23 -2.28],[2.15, -2.35],FFT);
FFTfilt.map = mapfilt;
%FFT_feensta.map = mapfiltF;
%FFT.map = map;
FFTfilt=symmetrize_image(FFTfilt,'vd');
%FFT_feenstra=symmetrize_image(FFT_feenstra,'vd');
%FFT = symmetrize_image(FFT,'vd');
clear  mapfilt mapfiltF map


ln_cut=line_cut_v4(FFTfilt,[100 100],[100 170],1);
%ln_cut2=line_cut(FFTfilt,[100 100],[100 170],1);
%ln_cutF=line_cut(FFT_feenstra,[100 100],[100 190],1);

figure(10), plot(1:70,ln_cut.cut(:,1),'.k');

% figure(1000), imagesc(flipud(ln_cut.cut'));
% colormap(gray);
% figure(1001), imagesc(flipud(ln_cut2.cut'));
% colormap(gray);
img_obj_viewer2(FFTfilt); 

%polarFFT=cartesian_to_polar(FFTfilt);
%polarFFT=cartesian_to_polar(FFT);

%img_obj_viewer2(FFT_feenstra);!!!!!!!!!!!

%polarFFTF = cartesian_to_polar(FFT_feenstra);
%ln_cut.cut(:,1)
%exp_bkg = subtract_exp_bkgnd(ln_cut.cut(:,1));
%data = ln_cut.cut(:,1)-exp_bkg;
%x = 1:length(ln_cut2.cut(:,1));
%test = polar_average(FFTfilt,0,5);
%notfiltdata = polar_average(FFT,0,360);
%x3=[3:20,60:100];
%[y_new, diff] = subtract_exp_bkgnd(x3,notfiltdata(:,37));
%[X1,X2] = ndgrid(1:200,1:200);

%M = zeros(200,200,81);
% for i=1:length(notfiltdata(1,:))
%     [y_new, diff, p] = subtract_exp_bkgnd(x3,notfiltdata(:,i));
%     c = coeffvalues(p);
%     %R(:,i)=diff;
%     %M(:,:,i) = c(1)*exp(c(2)*((X1-100).^2+(X2-100).^2).^(c(3)/2))+c(4);
%     for k=1:200
%         for l=1:200
%             M(k,l,i)=c(1)*exp(c(2)*((k-100).^2+(l-100).^2).^(c(3)/2))+c(4);
%         end
%     end
% end

%t = 1:200;
%s = c(1)*exp(c(2)*(((t-100).^2).^(c(3)/2)))+c(4);
%figure(50), plot(t,s,'.k');

%FFT2 = FFT;
%FFT2.map=FFT.map-M;

% ln_cut=line_cut(FFT2,[100 100],[100 170],1);
% figure(1002), imagesc(flipud(ln_cut.cut'));
% colormap(gray);

% x = 1:length(ln_cut.cut(:,1));
% figure(10), plot(x,ln_cut.cut(:,1),'.k');
% notfiltdata2 = polar_average(FFT2,0,5);
% x2 = 1:length(notfiltdata2(:,1));
% figure(11), plot(x2,notfiltdata2(:,1),'.k');


%figure(10), plot(x,ln_cut.cut(:,1),'.k',x,exp_bkg,'.r');
% figure(1100), plot(x,notfiltdata(:,37),'.k');
% hold on
% plot(x3,y_new,'.r',1:length(notfiltdata(:,37)),diff,'.g');
% hold off
%figure(12), plot(x,exp_bkg,'.r');
%figure(150), plot(x,test(:,37),'.k');
%M=plot_linecut(ln_cut2,10);
% Oave = polar_average(FFTfilt,0,360);
% O = polar_average(FFTfilt,0,10);
% guess = [700 40 5 140];
% %[y_new, p]=fit_to_lorentzian(O(:,2),[30 50],guess);
% low = 30;
% high = 50;
% N = 48;
% q = zeros(1,N);
% y_new = zeros(high-low+1,N);
% 
% for i=1:20
%     %smur = smurdata(O(:,i),3,10);
%     [y_new(:,i), p] = fit_to_lorentzian(Oave(:,i),[low high],guess);
%     vector_low(i) = low;
%     vector_high(i) = high;
%     l = low;
%     h = high;
%     c = coeffvalues(p);
%     guess = c;
%     x0 = c(2);
%     low = round(x0-10);
%     high = round(x0+10);
%     q(i)=x0;
% end
% 
% for i=21:N
%     smur = smurdata(O(:,i),3,10);
%     [y_new(:,i), p] = fit_to_lorentzian(smur,[low high],guess);
%     p
%     vector_low(i) = low;
%     vector_high(i) = high;
%     l = low;
%     h = high;
%     c = coeffvalues(p);
%     guess = c;
%     x0 = c(2);
%     low = round(x0-10);
%     high = round(x0+10);
%     q(i)=x0;
% end
% low = 30;
% high = 50;
% guess = [700 40 5 140];
% % t=1;
% % for i=10:35
% %     [y_new2(:,t), p] = fit_to_lorentzian(O(i,:),[low high], guess);
% %     t=t+1;
% %     vector_low(i) = low;
% %     vector_high(i) = high;
% %     l = low;
% %     h = high;
% %     c = coeffvalues(p);
% %     guess = c;
% %     x0 = c(2);
% %     low = round(x0-10);
% %     high = round(x0+10);
% %     
% % end
% 
% figure(500), plot(q,1000*G.e(1:N),'.k');
% axis([0 100 -10 5]);
% smur=smurdata(O(:,N),3,10);
% figure(200), plot(1:100,O(:,N),'.k',l:h,y_new(:,N),'-r',1:100,smur,'.g');
% test = zeros(100,81);
% test(:,1:20) = Oave(:,1:20);
% test(:,21:end) = O(:,21:end);
% plotting = test(:,1:N);
% for j=21:N
%     plotting(:,j)=smurdata(plotting(:,j),3,10);
% end
% plot_energy_cuts(O(1:35,:),10);
% figure(201), imagesc(flipud(test(:,:)'));
% colormap(gray);
% plot_fits(y_new,vector_low,vector_high,plotting,10);