%Function to find phase map of data and move pixels to their "perfect
%position" based on their phase


%UNITS FROM T.r

function [ref,phase,peak] = fix_lattice2(data1)
close all
data = data1;
%Open Colormap
%cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');
cmap = open('C:\Analysis Code\MATLAB\ColorMap\IDL_Colormap3.mat');

%%%Set up Data
%Size of original data set
% [nr,nc] = size(data1.map);

%Crop image
% data.map = imcrop(data1.map,[10,10,nr-10,nc-10]);

%Size of new data set
[nrow,ncol] = size(data.map);
ref = find_ref2(data);

% %Reference image * Topo
phase.tsx = data.map.*ref.sinex;
phase.tcx = data.map.*ref.cosinex;
phase.tsy = data.map.*ref.siney;
phase.tcy = data.map.*ref.cosiney;

% %Plots of Product Images
figure ; pcolor(phase.tsx); shading flat; colormap(cmap.Defect1); title('Sine x Product Image');
figure ; pcolor(phase.tcx); shading flat; colormap(cmap.Defect1); title('Cos x Product image');
figure ; pcolor(phase.tsy); shading flat; colormap(cmap.Defect1); title('Sine y Product Image');
figure ; pcolor(phase.tcy); shading flat; colormap(cmap.Defect1); title('Cos y Product image');

%Low Pass Fourier Filter Product Images

% r = input('Radius of Points to Filter' );
r = 6;
%Zoom 
zm = 1; 

%Low Pass filter
A = fourierfilter_in(phase.tsx,r,zm,'sine'); ref.filttsx = A.z1;
B = fourierfilter_in(phase.tcx,r,zm,'sine'); ref.filttcx = B.z1;
C = fourierfilter_in(phase.tsy,r,zm,'sine'); ref.filttsy = C.z1;
D = fourierfilter_in(phase.tcy,r,zm,'sine'); ref.filttcy = D.z1;

%Plot filtered product images
 figure; pcolor(ref.distx', ref.disty ,A.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered Sine x Product Image');
 figure; pcolor(ref.distx', ref.disty ,B.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered Cosine x Product Image');
 figure; pcolor(ref.distx', ref.disty ,C.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered Sine y Product image');
 figure; pcolor(ref.distx', ref.disty ,D.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered CoSine y Product Image');

%Find Phase Shift

 % Create phase shift map
phase.thetax = mod(atan2(ref.filttcx,ref.filttsx),2*pi);
phase.thetay = mod(atan2(ref.filttcy,ref.filttsy),2*pi); 

%Record Amplitude
phase.ampx = real(((ref.filttcx.^2)+(ref.filttsx.^2)).^0.5);
phase.ampy = real(((ref.filttcy.^2)+(ref.filttsy.^2)).^0.5);

%Find Gradient of phase maps
% phase.FX = gradient(gradient(phase.thetax)); % Gradient of phase shift x 
% phase.FY = gradient(gradient(phase.thetay)); % Gradient of phase shift y

%Plot Gradients
% figure; pcolor(phase.FX ); shading flat; colormap(cmap.Defect4); title('FX');
% figure; pcolor(phase.FY); shading flat; colormap(cmap.Defect4); title('FY');

% If the phase jumps by 2pi in places this needs to be fixed.
phase.thetax = fixphase(phase.thetax); % +2pi
phase.thetax = fixphase2(phase.thetax); % -2pi
phase.thetay = fixphase(phase.thetay); % +2pi
phase.thetay = fixphase2(phase.thetay); %-2pi


%Plot Final Phase Shifts
 figure; pcolor(phase.thetax); shading flat; colormap(cmap.Defect4); title('Fixed Phase Map for Qx');
 figure; pcolor(phase.thetay ); shading flat; colormap(cmap.Defect4); title('Fixed Phase Map for Qy');

 
%Find Phi = q.r + phase
%Find q.r
[X Y] = meshgrid(data.r,data.r);
phase.qxr = (ref.qx(1)*X + ref.qx(2)*Y);
phase.qyr = (ref.qy(1)*X + ref.qy(2)*Y);
% Find Phi and sine(phi)
phase.phix = phase.qxr+phase.thetax;
phase.phiy = phase.qyr+phase.thetay;
phase.sinephix = sin(phase.phix);
phase.sinephiy = sin(phase.phiy);
a = phase.sinephix + phase.sinephiy;

% %Plot Sine PHI
figure; pcolor(ref.distx', ref.disty ,sin(phase.phix)); shading flat; colormap(cmap.Defect4); title('Sine Phi x');
figure; pcolor(ref.distx', ref.disty ,sin(phase.phiy)); shading flat; colormap(cmap.Defect4); title('Sine Phi y');
figure; pcolor(ref.distx', ref.disty ,a); shading flat; colormap(cmap.Defect4); title('Sine Phi x+y');

% Find places where phase is equal
phase.map = zeros(nrow);
tmp2 = (phase.sinephix  < -0.75  &  phase.sinephiy < -0.75);
phase.map(tmp2) = phase.sinephix(tmp2);
clear tmp2
%Plot
figure; pcolor(ref.distx', ref.disty ,phase.map); shading flat; colormap(cmap.Defect1); title('Phase Same');
%Plot Peaks over the topo
phase.layer = data.map + (max(max(data.map)))*phase.map;
figure; pcolor(ref.distx', ref.disty ,phase.layer); shading flat; colormap(cmap.Defect4); title('Plot "Peaks" on Topo');

%Plot perfect lattice.
peak.pl = phase.ampx.*ref.cosinex + phase.ampy.*ref.cosiney;
figure; pcolor(ref.distx', ref.disty ,peak.pl); shading flat; colormap(cmap.Invgray); axis equal; title('Perfect Lattice sin(A)+sin(B)');

%Find displacment in x direction;
peak.Q1x = ref.qx(1);
peak.Q1y = ref.qx(2);
peak.Q2x = ref.qy(1);
peak.Q2y = ref.qy(2);


% Find displacment fields
for x = 1:nrow;
    for y = 1:ncol;
        peak.u_x(x,y) = (phase.thetax(x,y)*peak.Q2y - phase.thetay(x,y)*peak.Q1y)/(peak.Q1x*peak.Q2y - peak.Q1y*peak.Q2x);
        peak.u_y(x,y) = (phase.thetay(x,y)*peak.Q2x - phase.thetay(x,y)*peak.Q1x)/(peak.Q1y*peak.Q2x - peak.Q1x*peak.Q2y);
    end
end

%Recored New r vectors
peak.rnewx = X + peak.u_x;
peak.rnewy = Y + peak.u_y;

%Interplote data.map onto new co-ordinate system of equal phase
peak.int = griddata(X,Y , data.map , peak.rnewx , peak.rnewy);
figure; pcolor(peak.int); shading flat; colormap(cmap.Invgray); title('Final "Perfect map" interp');
figure; pcolor(data.map); shading flat; colormap(cmap.Invgray); title('Real Map');

%The interpolated data will return NaN in places, fill in the gaps in order
%to take a fourier transform
peak.int1 = fixm(peak.int);
%Take Fourier Transforms
peak.Fint = fourier_tr2d(peak.int1,'gauss','imaginary',0);
figure; pcolor(peak.Fint); shading flat; axis equal; colormap(cmap.Defect1);  axis off; zoom(2); title('Imaginary Part of Interpolated Data FT')
peak.Ftdata1 = fourier_tr2d(data.map,'gauss','imaginary',0);
figure; pcolor(peak.Ftdata1); shading flat; axis equal; colormap(cmap.Defect1);  axis off; zoom(2); title('Imaginary Part of Original Data FT')
peak.Fint2 = fourier_tr2d(peak.int1,'gauss','',0);
figure; pcolor(peak.Fint2); shading flat; axis equal; colormap(cmap.Invgray);  axis off; zoom(2); title('Abs Interpolated Data FT')
peak.ftdata = fourier_tr2d(data.map,'gauss',0,0);
figure; pcolor(peak.ftdata); shading flat; axis equal; colormap(cmap.Invgray);  axis off;  zoom(2); title('Abs Original Data FT')


end
