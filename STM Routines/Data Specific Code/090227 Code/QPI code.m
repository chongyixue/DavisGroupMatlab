G1 = poly_detrend2(G,0);
%%
F1 = fourier_block2(G1,'sine');
%%
F2 = rotate_map2(F1,2.5);
%%
F3 = transform_map3(F2);
%%
F4 = symmetrize_map2(F3);
%%
F5 = blur(F4,3,3);
%%
F6 = gauss_subt(F5,0.35,[0 0]);