%% Fig 1 from  01008A00
xlim([85 193]); ylim([14 122]);

%% Fig 3  e f
tol = 0.007;
new_img1 = DeltaNR_tile;
new_img2 = OmegaNR_tile;
new_img1(new_img1 < tol & new_img1 > -tol) = 0;
new_img2(new_img2 < tol & new_img2 > -tol) = 0;

tmp =new_img1;
tmp(new_img2==0) = 0;
new_img2(new_img1==0) = 0;
new_img1 = tmp;
clear tmp tol 
img_plot2(binary_domains(new_img1),Cmap.PurBlaCop,'\Delta_N^R');
caxis([-0.035 0.035]);
 xlim([5 105]); ylim([70 170])
img_plot2(binary_domains(new_img2),Cmap.PurBlaCop(end:-1:1,:),'\Omega_N^R');
caxis([-0.05 0.05]);
 xlim([5 105]); ylim([70 170])
 clear new_img1 new_img2
 %% Fig 3 a b
 img_plot2(gap_map_mod,Cmap.Defect1,'\Delta');
 xlim([5 105]); ylim([70 170])
 caxis([-42 -18]);
 img_plot2(omega_map_mod,Cmap.Defect1,'\Omega');
 xlim([5 105]); ylim([70 170])
 caxis([30 70]);
 %% Fig 3 c
 img_plot2(topo2,Cmap.Blue2,'topo');
 xlim([5 105]); ylim([70 170]);
 caxis([-0.018 0.023]);
 %% Fig 4 e
 [c MN xedges yedges] = twod_hist_maps(OmegaNR_tile(DeltaNR_tile~=0),DeltaNR_tile(DeltaNR_tile~=0));
 p = Gaussian2D_fit(MN,xedges(1,:),yedges(:,1),[0.02 0 0 0.01 0.01 pi/4]);
 Gaussian_v2(xedges(1,:),yedges(:,1)',p(4),p(5),p(6),[p(2) p(3)],p(1));
 colormap(hot);
 
 %% Fig 4 c d - maybe
 nem_dom_avg(omega_map_mod,nem_img_local_OmegaNR_neg,Cu_index,Ox_index1,Ox_index2,Oy_index1,Oy_index2,25);