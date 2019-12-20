%%%%%%%
% CODE DESCRIPTION:  Generate phase information map for periodic
% structures in img input (usually topograph of (quasi_periodic)
% character).  The method uses the lock-in technique for which reference
% functions with a single frequency 
%
% INPUT:  img - 2D image from which to generate phase map
%         q - vector of points in FT image corresponding to Bragg peaks (in
%         pixel number)
%         
% OUTPUT: phi_1 - phase map for direction 1
%         phi_2 - phase map for direction 2
%
% CODE HISTORY
%
%  110628 MHH  Modular code rewritten from old code
%%%%%%%%
function [phi_1 phi_2] = phase_map(img,img_r,q_px,filt_width)

% make reference functions
[nr nc] = size(img);
k0=2*pi/(max(img_r)-min(img_r));
k=linspace(-k0*nc/2,k0*nc/2,nc);
ft_img = fourier_transform2d(img,'none','complex','ft');
%img_plot2(abs(ft_img));
q = k(q_px); %q = q/(2*pi);
[X Y] = meshgrid(img_r,img_r);
% lock-in method reference functions
%A1= sin(q(1,1)*X + q(2,1)*Y); B1 = cos(q(1,1)*X + q(2,1)*Y);
%A2= sin(q(1,2)*X + q(2,2)*Y); B2 = cos(q(1,2)*X + q(2,2)*Y);

A1= sin(q(2,1)*X + q(1,1)*Y); B1 = cos(q(2,1)*X + q(1,1)*Y);
A2= sin(q(2,2)*X + q(1,2)*Y); B2 = cos(q(2,2)*X + q(1,2)*Y);
clear X Y;

% img_plot2(A1); img_plot2(A2);

% taking peak positions to generate filter

%xcoord given as [rnumber, cnumber]
xright = q_px(end:-1:1,1); xleft = q_px(end:-1:1,3);
yup = q_px(end:-1:1,2); ydown = q_px(end:-1:1,4);

%filtx = zeros(nr,nc);
%filty = zeros(nr,nc);

filtx = Gaussian2D(1:nr,1:nc,filt_width,filt_width,0,xright,1) + Gaussian2D(1:nr,1:nc,filt_width,filt_width,0,xleft,1);
filty = Gaussian2D(1:nr,1:nc,filt_width,filt_width,0,yup,1) + Gaussian2D(1:nr,1:nc,filt_width,filt_width,0,ydown,1);
img_plot2(filtx); img_plot2(filty);
 
f1 = filtx.*ft_img;
f2 = filty.*ft_img;
z1 = ifft2(ifftshift(f1));
z2 = ifft2(ifftshift(f2));
img_plot2(abs(ft_img)); img_plot(abs(f1));
clear f1 f2;

% reference signal * filtered signal
Az1 = A1.*z1; Bz1 = B1.*z1;
Az2 = A2.*z2; Bz2 = B2.*z2;
img_plot2(abs(Az1));
%fAz1 = fft2(Az1); fAz1shift = fftshift(fAz1);
%fBz1 = fft2(Bz1); fBz1shift = fftshift(fBz1);

fAz1 = fftshift(fft2(Az1)); 
fBz1 = fftshift(fft2(Bz1)); 
img_plot2(abs(fAz1));
%fAz2 = fft2(Az2); fAz2shift = fftshift(fAz2);
%fBz2 = fft2(Bz2); fBz2shift = fftshift(fBz2);

fAz2 = fftshift(fft2(Az2));
fBz2 = fftshift(fft2(Bz2));

%img_plot2(abs(fAz1));
% create filter to remove 2*k atmoic
%Note the std of the gaussian to creat this filter determines how well the
%imperfection of the lattice are represetned.  A small std can recreate a
%perfect lattice as it ignore dislocations and vacancies.  

filt1x = Gaussian2D(1:nr,1:nc,3,3,0,[nr/2+1 nc/2+1],1);
filt2y = filt1x;
img_plot2(filt1x);

% filtered FT to remove 2*k atomic peaks (low pass filtering)
% first, make filters to remove wavevectors with twice the frequency of the
% atomic corrugation (there should only be ~dc component that remains after this)

% filt1x,filt1y, filt2x, filt2y are needed (probably only two are
% sufficient)
%filt1x = filt; filt1y = filt'; filt2x = filt1x; filt2y = filt1y;

fAz1filt = fAz1.*filt1x; fBz1filt = fBz1.*filt1x;
fAz2filt = fAz2.*filt2y; fBz2filt = fBz2.*filt2y;
img_plot2(abs(fAz1filt));
X1 = ifft2(ifftshift(fAz1filt)); Y1 = ifft2(ifftshift(fBz1filt));
X2 = ifft2(ifftshift(fAz2filt)); Y2 = ifft2(ifftshift(fBz2filt));


img_plot2(X1); img_plot2(X2);
%clear filt1x filt2y fAz1filt fBz1filt fAz2filt fBz2filt;
%clear fAz1shift fAz2shift fBz1shift fBz2shift;

% calculate theta and phi

%should look at the amount of imaginary component.  Needs to be low if taking
%only the real parts of Y and X to form theta
[nr nc] = size(img);
[X Y] = meshgrid(1:nr,1:nc);

%%%%%%%%%%%%%%%%%%% Theta 1 calculation
%theta1 = atan(real(Y1)./real(X1)); 
theta1 = real(atan((Y1)./(X1))); 
%theta in [-pi/2 pi/2] so convert everthing to [0 2pi]
img_plot2(theta1);
% check if coordinate in 3rd quadrant
tmp1 = (theta1 > 0 & real(Y1) < 0) ;
theta1(tmp1) = pi + theta1(tmp1);

% check if coordinate in 2nd quadrant
tmp1 = (theta1 < 0 & real(Y1) > 0);
theta1(tmp1) = pi - abs(theta1(tmp1));

% check if coordinate in 4th quadrant
tmp1 = (theta1 < 0 & real(Y1) < 0);
theta1(tmp1) = 2*pi + theta1(tmp1);


%theta1 = real(atan((Y1)./(X1))); 

clear tmp1
% %%%%%%%%%%%%%%%%%%% THETA 2 calculation
%theta2 = atan(real(Y2)./real(X2)); %theta in [-pi/2 pi/2]
theta2 = real(atan((Y2)./(X2))); 
img_plot2(theta2);
% check if coordinate in 3rd quadrant
tmp1 = (theta2 > 0 & real(Y2) < 0) ;
theta2(tmp1) = pi + theta2(tmp1);

% check if coordinate in 2nd quadrant
tmp1 = (theta2 < 0 & real(Y2) > 0);
theta2(tmp1) = pi - abs(theta2(tmp1));

% check if coordinate in 4th quadrant
tmp1 = (theta2 < 0 & real(Y2) < 0);
theta2(tmp1) = 2*pi + theta2(tmp1);


%theta2 = real(atan((Y2)./(X2))); 

phi1 = q(1,1)*X + q(2,1)*Y + real(theta1);
phi1a = mod(phi1,2*pi);

phi2 = q(1,2)*X + q(2,2)*Y + real(theta2);
phi2a = mod(phi2,2*pi);


%clear X Y X1 X2 Y1 Y2 nr nc phi1 phi2 tmp1 theta1 theta2;
% sin of phi1a and phi2a with topograph to check how well phases match
  img_plot2(real(img)); 
  img_plot2(sin(phi1a));
  img_plot2(sin(phi2a));
  img_plot2(theta1); img_plot2(theta2);
end