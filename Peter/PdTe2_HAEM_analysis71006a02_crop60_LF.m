% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_71001a01_G, obj_71001A01_T, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');

% use the topograph and fit gaussian to impurity

obj_71006A02_T_dc = obj_71006A02_T_LFCorrect_crop;
obj_71006A02_T_dc.map = abs(obj_71006A02_T_LFCorrect_crop.map);
[dx, dy] = determine_singleimp_center_single_peak(obj_71006A02_T_dc, 1, 60, 63, 2, 2, 'no');

% dx = 63;
% dy = 66;

comment = 'rectangle_defect71006a02_LF';

%change crop pixel size accordingly
[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysis(obj_71006a02_G_LFCorrect_crop, obj_71006A02_T_LFCorrect_crop, [dx, dy], 60);
%use clfdata to choose peaks (also = the map that appears after this)


%% sign-preserving scattering??
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho1] = singleimpuritypdte2analysis2(prft_data, [67,57], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho2] = singleimpuritypdte2analysis2(prft_data, [61,54], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho3] = singleimpuritypdte2analysis2(prft_data, [55,58], 2, 'ncircle',comment);

[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho4] = singleimpuritypdte2analysis2(prft_data, [61,45], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho5] = singleimpuritypdte2analysis2(prft_data, [56,42], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho6] = singleimpuritypdte2analysis2(prft_data, [52,41], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho7] = singleimpuritypdte2analysis2(prft_data, [45,43], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho8] = singleimpuritypdte2analysis2(prft_data, [41,46], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho9] = singleimpuritypdte2analysis2(prft_data, [41,52], 2, 'ncircle',comment);
%[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho10] = singleimpuritypdte2analysis2(prft_data, [67, 47], 2, 'ncircle',comment);

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
rho71006a02.rho1 = rho1;
rho71006a02.rho2 = rho2;
rho71006a02.rho3 = rho3;
rho71006a02.rho4 = rho4;
rho71006a02.rho5 = rho5;
rho71006a02.rho6 = rho6;
rho71006a02.rho7 = rho7;
rho71006a02.rho8 = rho8;
rho71006a02.rho9 = rho9;
%rho71006a02.rho10 = rho10;
rho71006a02.comment = comment;
%autosave
savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
slstr = strcat(savepath,'.mat');
saveas(gcf, slstr, 'mat');


%% center
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [56, 56], [56, 56], 4, 'circle');


% 
% %% q1 scattering
%[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 10], [10, 10], 5, 'circle');

