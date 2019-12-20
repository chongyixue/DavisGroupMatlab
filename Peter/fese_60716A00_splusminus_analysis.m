%% only crop the data so it is the same size as the phase corrected one
 [nprft_data, nprft_topo, crdata, crtopo] = fesesingleimpurity_nophase_onlycrop(obj_60716a00_G, obj_60716A00_T, [14, 114, 14, 114]);
% get the real and imaginary part of data, as well as the symmetrized real
% and imaginary parts
 [realft_data_raw, imagft_data_raw, symrealft_data_raw, symimagft_data_raw, asymrealft_data_raw, asymimagft_data_raw, test_data_raw, rho_raw] = fesesingleimpurity_pjh_analysis(nprft_data, [60, 41], [42, 42], 5, 'circle');

%%
[data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter(obj_60716A00_T_LF,59, 65);
% 
[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60716a00_G_LF, obj_60716A00_T_LF, [dx, dy], 50, selocex, fe1locex, fe2locex);

% electron to hole pocket
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [60, 41], [42, 42], 4, 'circle');


%% electron to electron, and hole to hole pocket
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [68, 50], [51, 33], 5, 'circle');
%% q - vector connecting just noise
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [51, 41], [51, 41], 4, 'circle');
%% intraband scattering in center
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [51, 51], [51, 51], 5, 'circle');
%%
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = fesesingleimpurity_pjh_analysis(prft_data, [60, 41], [42, 42], 4, 'ncircle');
