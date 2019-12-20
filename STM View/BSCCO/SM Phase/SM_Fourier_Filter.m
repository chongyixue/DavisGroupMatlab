function new_topo = SM_Fourier_Filter(topo,Q1,Q2,width)
[nr nc] = size(topo);
F_topo = fourier_transform2d(topo,'none','complex','ft');

%img_plot2(abs(F_topo));
gauss_mask = Gaussian(1:nr,1:nc,width,Q1,1) + Gaussian(1:nr,1:nc,width,Q2,1);
%img_plot2(gauss_mask);
F_topo_mask = F_topo.*gauss_mask;
%img_plot2(abs(F_topo_mask));
new_topo = real(fourier_transform2d(F_topo_mask,'none','complex','ift'));
%img_plot2(real(new_topo));
%img_plot2((topo));
end