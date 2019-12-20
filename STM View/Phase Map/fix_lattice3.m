%Function to find phase map of data and move pixels to their "perfect
%position" based on their phase

%UNITS IN PIXELS

function [ref,phase,peak] = fix_lattice3(data1);
close all
data = data1;

%Open Colormap
cmap = open('C:\MATLAB\ColorMap\IDL_Colormap2.mat');

%Set up Data
% [nr,nc] = size(data1.map);
%Crop Data
% data.map = imcrop(data1.map,[10,10,nr-20,nc-20]);
peak.data = data.map;

%Size of new Data
[nrow,ncol] = size(data.map);
ref = find_ref3(data);

% %Reference image * Topo
phase.tsx = data.map.*ref.sinex;
phase.tcx = data.map.*ref.cosinex;
phase.tsy = data.map.*ref.siney;
phase.tcy = data.map.*ref.cosiney;

% %Plots
figure ; pcolor(phase.tsx); shading flat; colormap(cmap.Defect1); title('Sine x Product Image');
figure ; pcolor(phase.tcx); shading flat; colormap(cmap.Defect1); title('Cos x Product image');
figure ; pcolor(phase.tsy); shading flat; colormap(cmap.Defect1); title('Sine y Product Image');
figure ; pcolor(phase.tcy); shading flat; colormap(cmap.Defect1); title('Cos y Product image');

% Fourier Filter Product Images

% r = input('Radius of Points to Filter' );
r =6;
zm = 1;

ref.A = fourierfilter_in(phase.tsx,r,zm,''); ref.filttsx = ref.A.z1;
ref.B = fourierfilter_in(phase.tcx,r,zm,''); ref.filttcx = ref.B.z1;
ref.C = fourierfilter_in(phase.tsy,r,zm,''); ref.filttsy = ref.C.z1;
ref.D = fourierfilter_in(phase.tcy,r,zm,''); ref.filttcy = ref.D.z1;

%Plot filtered product images
 figure; pcolor(ref.A.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered Sine x Product Image');
 figure; pcolor(ref.B.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered Cosine x Product Image');
 figure; pcolor(ref.C.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered Sine y Product image');
 figure; pcolor(ref.D.z1); shading flat; colormap(cmap.Defect4); title('Fourier Filtered CoSine y Product Image');

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


%Plot Phase Shifts
 figure; pcolor(phase.thetax); shading flat; colormap(cmap.Defect4); title('Phase Map for Qx');
 figure; pcolor(phase.thetay ); shading flat; colormap(cmap.Defect4); title('Phase Map for Qy');


% % Create final phase map

[X Y] = meshgrid(1:nrow,1:ncol);
peak.X = X;
peak.Y = Y;

phase.qxr = (ref.qx(1)*X + ref.qx(2)*Y);
phase.qyr = (ref.qy(1)*X + ref.qy(2)*Y);

phase.phix = phase.qxr+phase.thetax;
phase.phiy = phase.qyr+phase.thetay;
phase.sinephix = sin(phase.phix);
phase.sinephiy = sin(phase.phiy);
a = phase.sinephix + phase.sinephiy;
figure; pcolor(a); shading flat; colormap(cmap.Defect4); title('Sine Phi x+y');
% %Plot Sine PHI
figure; pcolor(sin(phase.phix)); shading flat; colormap(cmap.Defect4); title('Sine Phi x');
figure; pcolor(sin(phase.phiy)); shading flat; colormap(cmap.Defect4); title('Sine Phi y');

% Find places where phase is equal
phase.map = zeros(nrow);
tmp2 = (phase.sinephix  < -0.75  &  phase.sinephiy < -0.75);
phase.map(tmp2) = phase.sinephix(tmp2);
clear tmp2
%Plot
figure; pcolor(phase.map); shading flat; colormap(cmap.Defect1); title('Phase Same');
%Plot Peaks over the topo
phase.layer = data.map + (max(max(data.map)))*phase.map;
figure; pcolor(phase.layer); shading flat; colormap(cmap.Defect4); title('Plot "Peaks" on Topo');

%Plot perfect lattice.
peak.pl = phase.ampx.*ref.cosinex + phase.ampy.*ref.cosiney;
figure; pcolor(peak.pl); shading flat; colormap(cmap.Invgray); axis equal; title('Perfect Lattice sin(A)+sin(B)');

%Find displacment in x direction;
peak.Q1x = ref.qx(1);
peak.Q1y = ref.qx(2);
peak.Q2x = ref.qy(1);
peak.Q2y = ref.qy(2);


% Find displacment 
for x = 1:nrow;
    for y = 1:ncol;
        peak.u_x(x,y) = (phase.thetax(x,y)*peak.Q2y - phase.thetay(x,y)*peak.Q1y)/(peak.Q1x*peak.Q2y - peak.Q1y*peak.Q2x);
        peak.u_y(x,y) = (phase.thetay(x,y)*peak.Q2x - phase.thetay(x,y)*peak.Q1x)/(peak.Q1y*peak.Q2x - peak.Q1x*peak.Q2y);
    end
end

close all

%Recored New r vectors
peak.rnewx = peak.X + peak.u_x;
peak.rnewy = peak.Y + peak.u_y;

%Interplote data.map onto new co-ordinate system of equal phase
peak.int = griddata(peak.X,peak.Y , peak.data , peak.rnewx , peak.rnewy);
figure; pcolor(peak.int); shading flat; colormap(cmap.Invgray); title('Final "Perfect map" interp');
figure; pcolor(peak.data); shading flat; colormap(cmap.Invgray); title('Real Map');


%The interpolated data will return NaN in places, fill in the gaps in order
%to take a fourier transform
peak.int1 = fixm(peak.int);
%Take Fourier Transforms of Real and Adjusted Maps
peak.Fint = fourier_tr2d(peak.int1,'gauss','imaginary',0);
figure; pcolor(peak.Fint); shading flat; axis equal; colormap(cmap.Defect1);  axis off; zoom(2);
peak.Ftdata1 = fourier_tr2d(peak.data,'gauss','imaginary',0);
figure; pcolor(peak.Ftdata1); shading flat; axis equal; colormap(cmap.Defect1);  axis off; zoom(2);
peak.Fint2 = fourier_tr2d(peak.int1,'gauss','',0);
figure; pcolor(peak.Fint2); shading flat; axis equal; colormap(cmap.Invgray);  axis off; zoom(2);
peak.ftdata = fourier_tr2d(peak.data,'gauss',0,0);
figure; pcolor(peak.ftdata); shading flat; axis equal; colormap(cmap.Invgray);  axis off;  zoom(2);


end
