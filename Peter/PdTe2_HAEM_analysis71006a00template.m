% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_71001a01_G, obj_71001A01_T, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');

% use the topograph and fit gaussian to impurity

obj_71001A01_T_dc = obj_71001A01_T;
obj_71001A01_T_dc.map = abs( obj_71001A01_T.map );
[dx, dy] = determine_singleimp_center_single_peak(obj_71001A01_T_dc, 1, 61, 67, 5, 5, 'no');

% dx = 61;
% dy = 67;

comment = 'rectangle_blackdefect71001a01';

%change crop pixel size accordingly
[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_71001a01_G, obj_71001A01_T, [dx, dy], 50);
%use clfdata to choose peaks (also = the map that appears after this)


%% sign-preserving scattering??
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho1] = singleimpuritypdte2analysis2(prft_data, [56,49], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho2] = singleimpuritypdte2analysis2(prft_data, [51,45], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho3] = singleimpuritypdte2analysis2(prft_data, [46,48], 2, 'ncircle',comment);

[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho4] = singleimpuritypdte2analysis2(prft_data, [61,46], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho5] = singleimpuritypdte2analysis2(prft_data, [56,43], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho6] = singleimpuritypdte2analysis2(prft_data, [51,40], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho7] = singleimpuritypdte2analysis2(prft_data, [46,42], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho8] = singleimpuritypdte2analysis2(prft_data, [41,47], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho9] = singleimpuritypdte2analysis2(prft_data, [41,52], 2, 'ncircle',comment);

%                                                                                                                        
%                        6                                             
%                     /     \ 
%                 7            5                                               
%              /                   \ 
%           8            2           4                                                 
%           |                        |
%           |     3             1                                                          
%           |  
%           9         center                                                

%%
rho71001a01.rho1 = rho1;
rho71001a01.rho2 = rho2;
rho71001a01.rho3 = rho3;
rho71001a01.rho4 = rho4;
rho71001a01.rho5 = rho5;
rho71001a01.rho6 = rho6;
rho71001a01.rho7 = rho7;
rho71001a01.rho8 = rho8;
rho71001a01.rho9 = rho9;

rho71001a01.comment = comment;
%autosave
savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
slstr = strcat(savepath,'.mat');
saveas(gcf, slstr, 'mat');


%% center
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [56, 56], [56, 56], 4, 'circle');


% 
% %% q1 scattering
%[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 10], [10, 10], 5, 'circle');

