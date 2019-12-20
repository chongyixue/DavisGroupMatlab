function phase = full_phase_map(img,img_r,theta,q_px)
load_color;
cols = Cmap.Defect1;
[X Y] = meshgrid(img_r,img_r);
 ref_fun = lockin_ref_fun(img,img_r,q_px);
 phase.q1r = ref_fun.q1(2,1)*X + ref_fun.q1(1,1)*Y;
 phase.q2r = ref_fun.q2(2,1)*X + ref_fun.q2(1,1)*Y;

phase.phi1 = mod(phase.q1r + theta.theta1,2*pi);
 phase.phi2 = mod(phase.q2r + theta.theta2,2*pi);
 %%phase.phi1 = phase.q1r + theta.theta1;
%phase.phi2 = phase.q2r + theta.theta2;

 
img_plot2(phase.phi1,cols,'phi 1');
img_plot2(phase.phi2,cols,'phi 2');
 

phase.q1 = ref_fun.q1; phase.q2 = ref_fun.q2;
img_plot2(sin(phase.phi2));
img_plot2(sin(phase.phi1));
img_plot2(theta.amp2.*sin(phase.phi1) + theta.amp2.*sin(phase.phi2));
img_plot2(img,cols,'Orignal Image');

end