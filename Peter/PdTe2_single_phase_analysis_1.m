% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_71001a01_G, obj_71001A01_T, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');

% use the topograph and fit gaussian to impurity

obj_71001A01_T_dc = obj_71001A01_T;
obj_71001A01_T_dc.map = abs(obj_71001A01_T.map);
[dx, dy] = determine_singleimp_center_single_peak(obj_71001A01_T_dc, 1, 61, 67, 5, 5, 'no');


comment = 'defect1';

[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_71001a01_G, obj_71001A01_T, [dx, dy], 55);

%% sign-preserving scattering
 [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [62, 52], [62, 52], 3, 'circle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [56, 49], [56, 49], 3, 'circle',comment);
 [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [62, 46], [62, 46], 2, 'circle',comment);
%% sign-changing scattering
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [50, 53], [50, 53], 3, 'circle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [67, 50], [67, 50], 2, 'circle',comment);
 [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [56, 44], [56, 44], 2, 'circle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [50, 46], [50, 46], 2, 'circle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [45, 50], [45, 50], 2, 'circle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis(prft_data, [45, 56], [45, 56], 2, 'circle',comment);
 %% center
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [56, 56], [56, 56], 4, 'circle');


% 
% %% q1 scattering
%[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 10], [10, 10], 5, 'circle');

