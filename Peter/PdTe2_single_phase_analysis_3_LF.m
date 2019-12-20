% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_71001a01_G, obj_71001A01_T, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');

% use the topograph and fit gaussian to impurity

obj_71005A03_T_dc = obj_71005A03_T_LFCorrect_crop;
obj_71005A03_T_dc.map = obj_71005A03_T_LFCorrect_crop.map;
%[dx, dy] = determine_singleimp_center_single_peak(obj_71005A03_T_dc, 1, 54, 51, 2, 2, 'no');

dx = 54;
dy = 51;

comment = 'rectangle_whitedefect71005a03LF_testcenter';

%change crop pixel size accordingly
[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_71005a03_G_LFCorrect_crop, obj_71005A03_T_LFCorrect_crop, [dx, dy], 50);
%use clfdata to choose peaks (also = the map that appears after this)

%% sign-preserving scattering??
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [51, 45], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [47, 48], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [56, 48], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [41, 45], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [46, 42], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [51, 39], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [56, 42], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [41, 51], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = singleimpuritypdte2analysis2(prft_data, [61, 46], 2, 'ncircle',comment);

%%
rho71005a03LF.rho1 = rho1;
rho71005a03LF.rho2 = rho2;
rho71005a03LF.rho3 = rho3;
rho71005a03LF.rho4 = rho4;
rho71005a03LF.rho5 = rho5;
rho71005a03LF.rho6 = rho6;
rho71005a03LF.rho7 = rho7;
rho71005a03LF.rho8 = rho8;
rho71005a03LF.rho9 = rho9;

rho71005a03LF.comment = comment;





%% center
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [56, 56], [56, 56], 4, 'circle');


% 
% %% q1 scattering
%[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 10], [10, 10], 5, 'circle');

