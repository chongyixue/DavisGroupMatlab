% [nprft_data, nprft_topo, crdata, crtopo] = fesesingleimpurity_nophase_onlycrop(obj_31129A00_G, obj_31129A00_T, [1, 101, 1, 101]);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [69, 50], [50, 34], 4, 'circle');


[dx, dy] = fit_singleimp_center(obj_31129A00_T, 56, 73, 6, 6);

[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_31129A00_G, obj_31129A00_T, [dx, dy], 50);

[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [68, 51], [51, 33], 4, 'circle');
%% center scattering
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [81, 81], [69, 68], 8, 'circle');

%%
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [93, 68], [69, 68], 7, 'ncircle');
