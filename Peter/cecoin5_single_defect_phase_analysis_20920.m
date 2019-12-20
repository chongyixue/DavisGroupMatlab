% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_60516a00_G, obj_60516A00_I, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');


% use the topograph and fit gaussian to impurity
obj_20920A00_T_dc = obj_20920A00_T;
obj_20920A00_T_dc.map = abs( obj_20920A00_T.map );
[dx, dy] = determine_singleimp_center_single_peak(obj_20920A00_T_dc, 1, 31, 40, 5, 5, 'no');


[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_20920A00_G, obj_20920A00_T, [dx, dy], 22);

%% q2 scattering
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [27, 23], [23, 19], 2, 'circle');

% 
% %% q1 scattering
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [27, 19], [19, 19], 5, 'circle');

