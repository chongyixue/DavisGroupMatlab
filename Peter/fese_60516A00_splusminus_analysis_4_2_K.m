% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_60516a00_G, obj_60516A00_I, [53, 123, 9, 79], [1, 51]);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 2, 'circle');


% use the first and last current layer dumbbell and calculate the average
% of these two results
[dx1, dy1] = determine_singleimp_center_double_peak(obj_60516A00_I, 1, 98, 47, 4, 4, 89, 45, 4, 4, 'invert');
[dx2, dy2] = determine_singleimp_center_double_peak(obj_60516A00_I, 51, 97, 46, 4, 4, 87, 48, 4, 4, 'no');

dx = (dx1+dx2)/2;
dy = (dy1+dy2)/2;

[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_60516a00_G, obj_60516A00_I, [dx, dy], 35, [1, 51]);

[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [30, 30], [41, 31], 2, 'circle');
%% center scattering
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [30, 30], [41, 31], 3, 'circle');

%%
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [30, 30], [41, 31], 3, 'ncircle');
