%% Divide by current to eliminate setup effect
G2 = current_divide2(G1,I);
%% eliminate constant background
G2 = poly_detrend2(G1,0);
%% gauss filter - removes low frequency components
G3 = gauss_filter(G2,15,10);
%% fourier transform
F1 = fourier_block3(G3,'blackmanharris','amplitude','ft');
%% symmetrize the fourier transform so that opposite quads are equal
F2 = block_symmetrize(F1);

%% rotate map if necessary
sz = size(G.e);
F3 = F1;
for i=1:sz(2)
    temp_map = F1.map(:,:,i);
    F3.map(:,:,i) = rotate_map(temp_map,-1);
end
clear i temp_map sz;
%% shear correct the fourier transform
%F3 = transform_map2(F2,[2.1464 2.1464], [-2.1464 2.1464]); %71003
%F3 = transform_map2(F2,[2.713 2.713], [-2.713 2.713]); % 70929
%F4 = transform_map2(F3,[1.9865 2.070], [-1.9865 2.070]); % 70925
F4 = transform_map3(F3);
%% average map along diagonal and vertical

F5 = symmetrize_map2(F4);

%%
F = F5;
sz = size(F.r');
x = linspace(F.r(end),F.r(1),sz(1));
sz = size(F.e);
filter = Gaussian(x,x,0.25,[0,0],1);
for i=1:sz(2)
    temp_map(:,:,i) = F.map(:,:,i) - F.map(:,:,i).*filter;
end
F8a = F;
F8a.map = temp_map;
clear sz x filter temp_map i;
%F5 = pink_reduce2(F4,1,0.1)
%%
F6 = blur_map(F5,5,2);