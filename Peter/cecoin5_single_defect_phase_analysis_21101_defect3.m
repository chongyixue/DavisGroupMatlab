% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_60516a00_G, obj_60516A00_I, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');


% use the topograph and fit gaussian to impurity
obj_21101A00_T_dc = obj_21101A00_T;
obj_21101A00_T_dc.map = abs( obj_21101A00_T.map );
[dx, dy] = determine_singleimp_center_single_peak(obj_21101A00_T_dc, 1, 77, 28, 5, 5, 'no');


[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_21101A00_G, obj_21101A00_T, [dx, dy], 13);

%% q2 scattering
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 14], [14, 10], 2, 'circle');


% 
% %% q1 scattering
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 10], [10, 10], 5, 'circle');

