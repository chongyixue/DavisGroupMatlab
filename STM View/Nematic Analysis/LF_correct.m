function LF_correct(img,img_r,phase)
% Determine the final corrected topo

[X Y] = meshgrid(img_r,img_r);

q1 = phase.q1; q2 = phase.q2;

%Q_matrix = [qa, qay; qbx, qby];
Q = [q1(2) q1(1); q2(2) q2(1)];
Inv_Q = inv(Q);

%img_plot2(phase.phi1);img_plot2(phase.phi2);

ux_corr = Inv_Q(2,1).*phase.theta1 + Inv_Q(2,2).*phase.theta2;
uy_corr = Inv_Q(1,1).*phase.theta1 + Inv_Q(1,2).*phase.theta2;


topo_f_x = X + ux_corr;
topo_f_y = Y + uy_corr;


% figure(20);pcolor(ux_corr);shading flat; colormap('jet'); colorbar; title('Corrected ux');
%figure(21);pcolor(uy_corr);shading flat; colormap('jet'); colorbar; title('Corrected uy');


%ref_fun.sin1= sin(q(2,1)*X + q(1,1)*Y); ref_fun.cos1 = cos(q(2,1)*X + q(1,1)*Y);
%ref_fun.sin2= sin(q(2,2)*X + q(1,2)*Y); ref_fun.cos2 = cos(q(2,2)*X + q(1,2)*Y);

%==========================================================================

img_correct = griddata(X, Y, img, topo_f_x, topo_f_y,'linear');
A = isnan(img_correct);
img_correct(A) = 0;
%img_plot2(img);
%img_plot2(img_correct);
f=fft2(img_correct - mean(mean(img_correct)));
f=fftshift(f);
f=abs(f);
img_plot2(f);
end