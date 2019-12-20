% [nprft_data, nprft_topo, crdata, crtopo] = singleimpurity_nophase_onlycrop(obj_71001a01_G, obj_71001A01_T, [53, 123, 9, 79], []);

% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(nprft_data, [30, 30], [41, 31], 3, 'circle');

% use the topograph and fit gaussian to impurity

obj_71009A00_T_dc = obj_71009A00_T;
obj_71009A00_T_dc.map = abs(obj_71009A00_T.map);
[dx, dy] = determine_singleimp_center_single_peak(obj_71009A00_T_dc, 1, 63, 61, 2, 2, 'no');

 dx = 63;
 dy = 61;

comment = 'bla';

%change crop pixel size accordingly
[prft_data, prft_topo, clfdata, clftopo] = singleimpurityphaseanalysistest(obj_71009a00_G, obj_71009A00_T, [dx, dy], 50);
%use clfdata to choose peaks (also = the map that appears after this)


%% sign-preserving scattering??
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho1] = singleimpuritypdte2analysis2(prft_data, [57,48], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho2] = singleimpuritypdte2analysis2(prft_data, [51,44], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho3] = singleimpuritypdte2analysis2(prft_data, [45,48], 2, 'ncircle',comment);

[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho4] = singleimpuritypdte2analysis2(prft_data, [61,44], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho5] = singleimpuritypdte2analysis2(prft_data, [57,41], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho6] = singleimpuritypdte2analysis2(prft_data, [51,38], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho7] = singleimpuritypdte2analysis2(prft_data, [45,41], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho8] = singleimpuritypdte2analysis2(prft_data, [40,46], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho9] = singleimpuritypdte2analysis2(prft_data, [40,52], 2, 'ncircle',comment);
[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho10] = singleimpuritypdte2analysis2(prft_data, [67, 47], 2, 'ncircle',comment);


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
rho71009a00.rho1 = rho1;
rho71009a00.rho2 = rho2;
rho71009a00.rho3 = rho3;
rho71009a00.rho4 = rho4;
rho71009a00.rho5 = rho5;
rho71009a00.rho6 = rho6;
rho71009a00.rho7 = rho7;
rho71009a00.rho8 = rho8;
rho71009a00.rho9 = rho9;
rho71009a00.rho10 = rho10;
rho71009a00.comment = comment;
%autosave
savepath = 'C:\Users\chong\Documents\MATLAB\STMdata\PdTe2\HAEM\';
slstr = strcat(savepath,'.mat');
saveas(gcf, slstr, 'mat');


%% center
% [realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [56, 56], [56, 56], 4, 'circle');


% 
% %% q1 scattering
%[realft_data, imagft_data, symrealft_data, symimagft_data, asymrealft_data, asymimagft_data, test_data, rho] = generalsingleimpurity_pjh_analysis(prft_data, [18, 10], [10, 10], 5, 'circle');

