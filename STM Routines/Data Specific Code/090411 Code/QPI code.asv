%%
Gn = current_divide2(G,I);
%%
G1 = poly_detrend2(Gn,0);
%%
F1 = fourier_block2(G1,'sine');
%%
F2 = rotate_map2(F1,1);
%%
F3 = block_symmetrize(F2);
%%
F4 = transform_map3(F3);
%%
F5 = symmetrize_map2(F4);
%%
F6 = blur(F5,3,4);