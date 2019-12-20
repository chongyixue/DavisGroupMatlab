%% flip the direction of the two maps that go from positive to negative values
obj_60724A00_G.e = fliplr(obj_60724A00_G.e);
obj_60724A00_G.map = flip(obj_60724A00_G.map,3);
obj_60724a00_I.e = fliplr(obj_60724a00_I.e);
obj_60724a00_I.map = flip(obj_60724a00_I.map,3);

obj_60804a00_G.e = fliplr(obj_60804a00_G.e);
obj_60804a00_G.map = flip(obj_60804a00_G.map,3);
obj_60804A00_I.e = fliplr(obj_60804A00_I.e);
obj_60804A00_I.map = flip(obj_60804A00_I.map,3);

%% calculate the Feenstra maps <=> G(r,E) ./ I(r,E)
obj_60721a00_K = feenstra_map(obj_60721a00_G,obj_60721A00_I);
obj_60724A00_K = feenstra_map(obj_60724A00_G,obj_60724a00_I);
obj_60803a00_K = feenstra_map(obj_60803a00_G,obj_60803A00_I);
obj_60804a00_K = feenstra_map(obj_60804a00_G,obj_60804A00_I);


%% subtract the average background and calculate FT with a sine window

% 60721A00 -50 to 0 meV in 41 layers 4.2 K
% conductance
new_data=polyn_subtract2(obj_60721a00_G,0);
obj_60721a00_G_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60721a00_G_FT_sym = symmetrize_image(obj_60721a00_G_FT,'vh');
obj_60721a00_G_FT.r = obj_60721a00_G_FT.r(99:202);
obj_60721a00_G_FT.map = obj_60721a00_G_FT.map(99:202, 99:202, :);
obj_60721a00_G_FT_sym.r = obj_60721a00_G_FT_sym.r(99:202);
obj_60721a00_G_FT_sym.map = obj_60721a00_G_FT_sym.map(99:202, 99:202, :);

% current
new_data=polyn_subtract2(obj_60721A00_I,0);
obj_60721A00_I_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60721A00_I_FT_sym = symmetrize_image(obj_60721A00_I_FT,'vh');
obj_60721A00_I_FT.r = obj_60721A00_I_FT.r(99:202);
obj_60721A00_I_FT.map = obj_60721A00_I_FT.map(99:202, 99:202, :);
obj_60721A00_I_FT_sym.r = obj_60721A00_I_FT_sym.r(99:202);
obj_60721A00_I_FT_sym.map = obj_60721A00_I_FT_sym.map(99:202, 99:202, :);


% K = conductance / current
new_data=polyn_subtract2(obj_60721a00_K,0);
obj_60721a00_K_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60721a00_K_FT_sym = symmetrize_image(obj_60721a00_K_FT,'vh');
obj_60721a00_K_FT.r = obj_60721a00_K_FT.r(99:202);
obj_60721a00_K_FT.map = obj_60721a00_K_FT.map(99:202, 99:202, :);
obj_60721a00_K_FT_sym.r = obj_60721a00_K_FT_sym.r(99:202);
obj_60721a00_K_FT_sym.map = obj_60721a00_K_FT_sym.map(99:202, 99:202, :);

% 60724A00 0 to +50 meV in 41 layers 4.2 K
% conductance
new_data=polyn_subtract2(obj_60724A00_G,0);
obj_60724A00_G_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60724A00_G_FT_sym = symmetrize_image(obj_60724A00_G_FT,'vh');
obj_60724A00_G_FT.r = obj_60724A00_G_FT.r(99:202);
obj_60724A00_G_FT.map = obj_60724A00_G_FT.map(99:202, 99:202, :);
obj_60724A00_G_FT_sym.r = obj_60724A00_G_FT_sym.r(99:202);
obj_60724A00_G_FT_sym.map = obj_60724A00_G_FT_sym.map(99:202, 99:202, :);

% current
new_data=polyn_subtract2(obj_60724a00_I,0);
obj_60724a00_I_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60724a00_I_FT_sym = symmetrize_image(obj_60724a00_I_FT,'vh');
obj_60724a00_I_FT.r = obj_60724a00_I_FT.r(99:202);
obj_60724a00_I_FT.map = obj_60724a00_I_FT.map(99:202, 99:202, :);
obj_60724a00_I_FT_sym.r = obj_60724a00_I_FT_sym.r(99:202);
obj_60724a00_I_FT_sym.map = obj_60724a00_I_FT_sym.map(99:202, 99:202, :);


% K = conductance / current
new_data=polyn_subtract2(obj_60724A00_K,0);
obj_60724A00_K_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60724A00_K_FT_sym = symmetrize_image(obj_60724A00_K_FT,'vh');
obj_60724A00_K_FT.r = obj_60724A00_K_FT.r(99:202);
obj_60724A00_K_FT.map = obj_60724A00_K_FT.map(99:202, 99:202, :);
obj_60724A00_K_FT_sym.r = obj_60724A00_K_FT_sym.r(99:202);
obj_60724A00_K_FT_sym.map = obj_60724A00_K_FT_sym.map(99:202, 99:202, :);

% 60721A00 -10 to 0 meV in 41 layers 10 K
% conductance
new_data=polyn_subtract2(obj_60803a00_G,0);
obj_60803a00_G_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60803a00_G_FT_sym = symmetrize_image(obj_60803a00_G_FT,'vh');
obj_60803a00_G_FT.r = obj_60803a00_G_FT.r(99:202);
obj_60803a00_G_FT.map = obj_60803a00_G_FT.map(99:202, 99:202, :);
obj_60803a00_G_FT_sym.r = obj_60803a00_G_FT_sym.r(99:202);
obj_60803a00_G_FT_sym.map = obj_60803a00_G_FT_sym.map(99:202, 99:202, :);

% current
new_data=polyn_subtract2(obj_60803A00_I,0);
obj_60803A00_I_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60803A00_I_FT_sym = symmetrize_image(obj_60803A00_I_FT,'vh');
obj_60803A00_I_FT.r = obj_60803A00_I_FT.r(99:202);
obj_60803A00_I_FT.map = obj_60803A00_I_FT.map(99:202, 99:202, :);
obj_60803A00_I_FT_sym.r = obj_60803A00_I_FT_sym.r(99:202);
obj_60803A00_I_FT_sym.map = obj_60803A00_I_FT_sym.map(99:202, 99:202, :);

% K = conductance / current
new_data=polyn_subtract2(obj_60803a00_K,0);
obj_60803a00_K_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60803a00_K_FT_sym = symmetrize_image(obj_60803a00_K_FT,'vh');
obj_60803a00_K_FT.r = obj_60803a00_K_FT.r(99:202);
obj_60803a00_K_FT.map = obj_60803a00_K_FT.map(99:202, 99:202, :);
obj_60803a00_K_FT_sym.r = obj_60803a00_K_FT_sym.r(99:202);
obj_60803a00_K_FT_sym.map = obj_60803a00_K_FT_sym.map(99:202, 99:202, :);

% 60724A00 0 to +10 meV in 41 layers 10 K
% conductance
new_data=polyn_subtract2(obj_60804a00_G,0);
obj_60804a00_G_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60804a00_G_FT_sym = symmetrize_image(obj_60804a00_G_FT,'vh');
obj_60804a00_G_FT.r = obj_60804a00_G_FT.r(99:202);
obj_60804a00_G_FT.map = obj_60804a00_G_FT.map(99:202, 99:202, :);
obj_60804a00_G_FT_sym.r = obj_60804a00_G_FT_sym.r(99:202);
obj_60804a00_G_FT_sym.map = obj_60804a00_G_FT_sym.map(99:202, 99:202, :);

% current
new_data=polyn_subtract2(obj_60804A00_I,0);
obj_60804A00_I_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60804A00_I_FT_sym = symmetrize_image(obj_60804A00_I_FT,'vh');
obj_60804A00_I_FT.r = obj_60804A00_I_FT.r(99:202);
obj_60804A00_I_FT.map = obj_60804A00_I_FT.map(99:202, 99:202, :);
obj_60804A00_I_FT_sym.r = obj_60804A00_I_FT_sym.r(99:202);
obj_60804A00_I_FT_sym.map = obj_60804A00_I_FT_sym.map(99:202, 99:202, :);

% K = conductance / current
new_data=polyn_subtract2(obj_60804a00_K,0);
obj_60804a00_K_FT = fourier_transform2d(new_data,'sine','amplitude','ft');
obj_60804a00_K_FT_sym = symmetrize_image(obj_60804a00_K_FT,'vh');
obj_60804a00_K_FT.r = obj_60804a00_K_FT.r(99:202);
obj_60804a00_K_FT.map = obj_60804a00_K_FT.map(99:202, 99:202, :);
obj_60804a00_K_FT_sym.r = obj_60804a00_K_FT_sym.r(99:202);
obj_60804a00_K_FT_sym.map = obj_60804a00_K_FT_sym.map(99:202, 99:202, :);


%% combine the 4.2 K and 10 K data into one file
obj_60721a00_G_FT_all = obj_60721a00_G_FT_sym;
obj_60721a00_G_FT_all.e = cat(2, obj_60721a00_G_FT_sym.e, obj_60724A00_G_FT_sym.e(2:end));
obj_60721a00_G_FT_all.map = cat(3, obj_60721a00_G_FT_sym.map(:,:,1:33),obj_60803a00_G_FT_sym.map(:,:,2:end), obj_60804a00_G_FT_sym.map(:,:,2:end-1), obj_60724A00_G_FT_sym.map(:,:,9:end) );

obj_60721A00_I_FT_all = obj_60721A00_I_FT_sym;
obj_60721A00_I_FT_all.e = cat(2, obj_60721A00_I_FT_sym.e, obj_60724a00_I_FT_sym.e(2:end));
obj_60721A00_I_FT_all.map = cat(3, obj_60721A00_I_FT_sym.map(:,:,1:33),obj_60803A00_I_FT_sym.map(:,:,2:end), obj_60804A00_I_FT_sym.map(:,:,2:end-1), obj_60724a00_I_FT_sym.map(:,:,9:end) );

obj_60721a00_K_FT_all = obj_60721a00_K_FT_sym;
obj_60721a00_K_FT_all.e = cat(2, obj_60721a00_K_FT_sym.e, obj_60724A00_K_FT_sym.e(2:end));
obj_60721a00_K_FT_all.map = cat(3, obj_60721a00_K_FT_sym.map(:,:,1:33),obj_60803a00_K_FT_sym.map(:,:,2:end), obj_60804a00_K_FT_sym.map(:,:,2:end-1), obj_60724A00_K_FT_sym.map(:,:,9:end) );

obj_60721a00_K_all = obj_60721a00_K;
obj_60721a00_K_all.e = cat(2, obj_60721a00_K.e, obj_60724A00_K.e(2:end));
obj_60721a00_K_all.map = cat(3, obj_60721a00_K.map(:,:,1:33),obj_60803a00_K.map(:,:,2:end), obj_60804a00_K.map(:,:,2:end-1), obj_60724A00_K.map(:,:,9:end) );

