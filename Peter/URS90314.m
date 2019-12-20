% close all
% clear all

%% load data
% load D:/URU2Si2/G90314A13.mat
load C:\Users\Peter\Dropbox\QPIforPeter\G90314A13.mat
%% usual manipulations
% remove DC
G = polyn_subtract2(G90314A13,0);
%img_obj_viewer2(G);
% *optional remove core
G2 = gauss_filter_image(G90314A13,9,3);
% take FFT of G and G2, G2 has lower frequencies removed
FFT = fourier_transform2d(G,'none','amplitude', 'ft');
FFT2 = fourier_transform2d(G2,'none','amplitude', 'ft');
% shear correct
% map = linear2D_image_correct([-2.00 -1.98],[1.91 -2.18],FFT);
map = linear2D_image_correct([25 26],[228 16],FFT);

% map2 = linear2D_image_correct([-2.02 -1.94],[1.93 -2.04],FFT2);
map2 = linear2D_image_correct([25 28],[229 23],FFT2);

FFT.map = map;
FFT2.map = map2;
% %img_obj_viewer2(FFT); 
% symmetrize data
FFT=symmetrize_image_v2(FFT,'vd');
FFT2=symmetrize_image_v2(FFT2,'vd');
clear map map2

% img_obj_viewer2(FFT); 
% img_obj_viewer2(FFT2); 

%% do a line cut for a range of angles
offset = 0;
%define zero degree cut coordinates
in1 = [129 (129+offset)];
in2 = [129 230];
% specify the angle
angle = 0;
% compute the cut coordinates
[out1, out2] = coordinates_from_angle(in1,in2,angle,129);

%ln_cut=line_cut_v4(FFT,out1,out2,0);
ln_cut2=line_cut_v4(FFT2,out1,out2,2);
numrows = length(ln_cut2.cut(:,1));
numcols = length(FFT.e);

N = 10;
angles = linspace(0,45,N);
wcore = zeros(numrows,numcols,N);
nocore = zeros(numrows,numcols,N);
r = zeros(numrows,N);

%figure(10), plot(1:length(ln_cut2.cut(:,1)),ln_cut2.cut(:,1),'.k');


for i=1:N
    angle = angles(i);

    [out1, out2] = coordinates_from_angle(in1,in2,angle,129);
    ln_cut=line_cut_v4(FFT,out1,out2,2);
    ln_cut2=line_cut_v4(FFT2,out1,out2,2);
    len = length(ln_cut.cut(:,1));
    x = (1+offset):(len+offset);
    % this converts the q range from pixel units to 2pi/a units for this
    % particular map
    r1 = 0.0193/(1.98*sqrt(2))*sqrt((out1(1)-129).^2+(out1(2)-129).^2);
    r2 = 0.0193/(1.98*sqrt(2))*sqrt((out2(1)-129).^2+(out2(2)-129).^2);
    p1 = x(1);
    p2 = x(end);
    m = (r2-r1)/(p2-p1);
    b = (p2*r1-r2*p1)/(p2-p1);
    r(1:len,i) = m*x + b;
    wcore(1:len,:,i) = ln_cut.cut;
    nocore(1:len,:,i) = ln_cut2.cut;
    
end

%% fill the cut structure
 cut_struct.wcore = wcore;
 cut_struct.nocore = nocore;
 cut_struct.r = r;
 cut_struct.e = FFT.e;
 cut_struct.angles = angles;

% cut = smooth_cut(ln_cut.cut,3);
% ln_cut.cut=cut;
% 
% 
% figure(2000), imagesc(ln_cut.cut(:,:)');
% set(gca,'YDir','normal')
% colormap(gray);


% x = (1+offset):(length(ln_cut.cut(:,1))+offset);
% for s=1:31
%     figure(s+20), plot(x,ln_cut.cut(:,s),'.k');
% end