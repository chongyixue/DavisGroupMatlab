G1 = current_divide2(G,I);
%%
G2 = poly_detrend2(G1,0);
%%
F1 = fourier_block2(G2,'sine');
%%
F2 = rotate_map2(F1,0.75);
%%
F3 = block_symmetrize(F2);
%%
F4 = transform_map3(F3);
%%
F5 = symmetrize_map2(F4);
%%
F6 = blur(F5,2,2);
%%
F7 =  pix_avg(F5);