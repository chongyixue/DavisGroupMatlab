G1 = current_divide2(G,I);
%%
G2 = poly_detrend2(G1,0);
%%
F1 = fourier_block2(G2,'sine');
%%
F2 = rotate_map2(F1,0.5);
%%
F3 = transform_map3(F2);%lattice = +/-2.275
%%
F4 = symmetrize_map2(F3);
%%
F5 = blur(F4,2,2);
%%
F6 = gauss_subt(F5,0.5,[0 0]);
%%
F7 =  pix_avg(F5);