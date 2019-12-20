% [nprft_data, nprft_topo, crdata, crtopo] = fesesingleimpurity_nophase_onlycrop(obj_40324A00_G, obj_40324A00_T, [1, 49, 15, 63]);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [37, 25], [25, 13], 3, 'circle');


% [dx, dy] = fit_singleimp_center(obj_4032400_T, 56, 73, 6, 6);

[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_40324A00_G, obj_40324A00_T, [25, 37], 24);

[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [37, 25], [25, 13], 3, 'circle');
%% center scattering
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [81, 81], [69, 68], 8, 'circle');

%%
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [93, 68], [69, 68], 7, 'ncircle');
