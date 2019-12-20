%%%%%%%
% CODE DESCRIPTION:  Generate phase information map for periodic
% structures in img input (usually topograph of (quasi_periodic)
% character).  The method uses the lock-in technique for which reference
% functions with a single frequency is multipled with the image (for method
% see James Slezak Thesis).
%
% INPUT:  img - 2D image from which to generate phase map
%         q_px - vector of points in FT image corresponding to Bragg peaks (in
%         pixel number) 
%         q_px = [x1 x2 x3 x4; y1 y2 y3 y4]
%         
% OUTPUT: phase - structure containing Bragg peaks q1 and q2 in k-space
%                 coodinates and theta1 and theta2, the phase maps for the
%                 displacement from perfect periodicity         
%
%                 theta1 - phase map for direction 1
%                 theta - phase map for direction 2
%
% CODE HISTORY
%
%110628 MHH  Modular code rewritten from old code
%%%%%%%%
function phase = phase_map_hex(img,img_r,q_px,filt_width)
load_color;
cols = Cmap.Blue2;
[nr nc] = size(img);
% make reference sine and cosine function functions
ref_fun = lockin_ref_fun_hex(img,img_r,q_px);
img_plot2(ref_fun.sin1);
img_plot2(ref_fun.sin2);
img_plot2(ref_fun.sin3);
%save q1 and q2 vectors - needed for LF correction
phase.q1 = ref_fun.q1; phase.q2 = ref_fun.q2; phase.q3 = ref_fun.q3;
phase.q_px = q_px;
% multiply image by reference functions
lock_signal.ts1 = img.*ref_fun.sin1; lock_signal.tc1 = img.*ref_fun.cos1;
lock_signal.ts2 = img.*ref_fun.sin2; lock_signal.tc2 = img.*ref_fun.cos2;
lock_signal.ts3 = img.*ref_fun.sin3; lock_signal.tc3 = img.*ref_fun.cos3;

%  img_plot2(img,Cmap.Blue2,'IMAGE');
%  img_plot2(lock_signal.ts1,cols,'X-dir sin locked image');img_plot2(lock_signal.tc1,cols,'X-dir cos locked image');
%  img_plot2(lock_signal.ts2,cols,'Y-dir sin locked image');img_plot2(lock_signal.tc2,cols,'Y-dir cos locked image');

% fourier filter reference multipled images to retain components near DC
filt_img.ts1 = (fourier_filter_dc(lock_signal.ts1,filt_width));
filt_img.tc1 = (fourier_filter_dc(lock_signal.tc1,filt_width));
filt_img.ts2 = (fourier_filter_dc(lock_signal.ts2,filt_width));
filt_img.tc2 = (fourier_filter_dc(lock_signal.tc2,filt_width));
filt_img.ts3 = (fourier_filter_dc(lock_signal.ts3,filt_width));
filt_img.tc3 = (fourier_filter_dc(lock_signal.tc3,filt_width));

%img_plot2(abs(filt_img.ts1),cols,'X-dir sin locked FT'); img_plot2(abs(filt_img.tc1),cols,'X-dir cos locked FT');
%img_plot2(abs(filt_img.ts2),cols,'Y-dir sin locked FT'); img_plot2(abs(filt_img.tc2),cols,'Y-dir cos locked FT');

% %Find Phase Shift arising of quasiperiodicity of lattice
% 
% Create phase shift map
%phase.theta1 = mod(atan2(filt_img.tc1,filt_img.ts1),2*pi);
%phase.theta2 = mod(atan2(filt_img.tc2,filt_img.ts2),2*pi); 
%%
phase.theta1 = atan2(real(filt_img.tc1),real(filt_img.ts1));
phase.theta2 = atan2(real(filt_img.tc2),real(filt_img.ts2));
phase.theta3 = atan2(real(filt_img.tc3),real(filt_img.ts3));
phase.theta1 = mod(phase.theta1,2*pi) - pi; %useless??
phase.theta2 = mod(phase.theta2,2*pi) - pi; %useless??
phase.theta3 = mod(phase.theta3,2*pi) - pi; %useless??
phase.s_phase1 = ref_fun.s_phase1;
phase.s_phase2 = ref_fun.s_phase2;
phase.s_phase3 = ref_fun.s_phase3;

% phase.theta1 = atan2(real(filt_img.ts1), real(filt_img.tc1));
% phase.theta2 = atan2(real(filt_img.ts2), real(filt_img.tc2));
% % phase.theta1 = mod(phase.theta1,2*pi) - pi; %useless??
% % phase.theta2 = mod(phase.theta2,2*pi) - pi; %useless??
% phase.s_phase1 = ref_fun.s_phase1;
% phase.s_phase2 = ref_fun.s_phase2;
% 
% [FXt1, FYt1] = gradient(phase.theta1);
% [FXt2, FYt2] = gradient(phase.theta2);
% 
% img_plot2(phase.theta1,cols,'theta 1');
% img_plot2(FXt1,cols,'gradient x theta 1');
% img_plot2(FYt1,cols,'gradient y theta 1');
% img_plot2((FXt1.^2 + FYt1.^2).^0.5,cols,'absolute value gradient theta 1');
% 
% 
% img_plot2(phase.theta2,cols,'theta 2');
% img_plot2(FXt2,cols,'gradient x theta 2');
% img_plot2(FYt2,cols,'gradient y theta 2');
% img_plot2((FXt2.^2 + FYt2.^2).^0.5,cols,'absolute value gradient theta 2');




% %Record Amplitude
% phase.amp1 = real(((filt_img.ts1.^2)+(filt_img.tc1.^2)).^0.5);
% phase.amp2 = real(((filt_img.ts2.^2)+(filt_img.tc2.^2)).^0.5);
% 
% %img_plot2((phase.amp1),Cmap.Defect1);
% %img_plot2((phase.amp2),Cmap.Defect1);
 
%img_plot2(sin(phase.phi2));
%img_plot2(sin(phase.phi1));
%img_plot2(phase.amp2.*sin(phase.phi1) + phase.amp2.*sin(phase.phi2));
% img_plot2(img,cols,'Orignal Image');

end