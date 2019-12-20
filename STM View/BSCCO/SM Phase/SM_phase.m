%%%%%%%
% CODE DESCRIPTION: Generate the phase map for the supermodulation in
% BSCCO.  The code generates a fourier filtered topograph, which eliminates
% the atomic corrugations and only leaves the SM.  From this a lock-in
% technique (c.f. Slezak Thesis) is used to extract the phase.
%
%       INPUT: topo  - image of topograph of BSCCO
%              Q1 - [Y X] Modulation wavevector of SM in fourier space upper half
%              Q2 - [Y X] Modulation wavevector of SM in fourier space lower half
%              filt_width1 - fourier filter width for filtering initial
%              topo fourier transform
%              filt_width2 - fourier filter width for filtering of phase
%              locked images near DC.
%   
%       OUTPUT: phase - structure with fourier filtered phase locked images
%       and final phase

% CODE HISTORY
%
% 120101 - Created
%
%%%%%%%
function phase = SM_phase(topo,Q1,Q2,filt_width1,filt_width2)

[nr nc] = size(topo);
% q values in fourier space from pixel values given in Q
q1 = 2*pi/nr*abs((Q1(1)-nr/2+1));
q2 = 2*pi/nr*abs((Q1(2)-nc/2+1));
% distance of SM wavevector to origin
SM_length = sqrt(((nr/2+1) - Q1(1))^2 + ((nc/2+1) - Q1(2))^2)

filt_topo = SM_Fourier_Filter(topo,Q1,Q2,filt_width1);
ref_func = SM_reference_func(nr,nc,Q1);

X = (ref_func.sin).*filt_topo;
Y = (ref_func.cos).*filt_topo;

%img_plot2(X);
%img_plot2(Y);
%img_plot2(filt_topo)
%img_plot2(fourier_transform2d(X,'none','amplitude','ft'));

Ft_X = fourier_transform2d(X,'none','complex','ft');
Ft_Y = fourier_transform2d(Y,'none','complex','ft');

mask = Gaussian(1:nr,1:nc,0.5*SM_length,[nr/2+1 nc/2+1],1);

Ft_X_mask = Ft_X.*mask;
Ft_Y_mask = Ft_Y.*mask;

X_filt = real(fourier_transform2d(Ft_X_mask,'none','complex','ift'));
Y_filt = real(fourier_transform2d(Ft_Y_mask,'none','complex','ift'));
%img_plot2(X_filt);
theta = (atan(Y_filt./X_filt));

%theta in [-pi/2 pi/2] so convert everthing to [0 2pi]

% check if coordinate in 3rd quadrant
tmp1 = (theta > 0 & real(Y_filt) < 0) ;
theta(tmp1) = pi + theta(tmp1);

% check if coordinate in 2nd quadrant
tmp1 = (theta < 0 & real(Y_filt) > 0);
theta(tmp1) = pi - abs(theta(tmp1));

% check if coordinate in 4th quadrant
tmp1 = (theta < 0 & real(Y_filt) < 0);
theta(tmp1) = 2*pi + theta(tmp1);

%img_plot2(theta);
[X Y] = meshgrid(1:nc,1:nr);
phase = asin(sin((q1*Y + q2*X) + theta));
%img_plot2(phase)
%[r c] = find(phase < -pi/2+0.1  & phase >= -pi/2);
[r c] = find(phase <= pi/2  & phase >= pi/2-0.31);
%img_plot2(asin(sin((q1*Y + q2*X) + theta)));
%img_plot2(phase);
%img_plot2(mod((q1*Y + q2*X),2*pi));
img_plot2(topo);
hold on; plot(c,r,'r.');

%img_plot2(mask);

end