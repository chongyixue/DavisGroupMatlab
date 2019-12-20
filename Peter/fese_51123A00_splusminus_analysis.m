% [nprft_data, nprft_topo, crdata, crtopo] = fesesingleimpurity_nophase_onlycrop(obj_51123A00_G, obj_51123A00_T, [14, 114, 14, 114]);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(nprft_data, [41, 41], [61, 42], 4, 'ncircle');

%
[data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter(obj_51123A00_T_LF,67, 59);

[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_51123A00_G_LF, obj_51123A00_T_LF, [dx, dy], 50, selocex, fe1locex, fe2locex);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [41, 41], [61, 42], 4, 'circle');
%%
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [41, 41], [61, 42], 4, 'ncircle');




