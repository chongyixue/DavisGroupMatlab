

% [nprft_data, nprft_topo, crdata, crtopo] = fesesingleimpurity_nophase_onlycrop(obj_60716a01_T_SCC_LF, obj_60716a01_T_SCC_LF, [6, 906, 20, 920]);

%% Fe vacancy
% %
% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter(obj_60716a01_T_SCC_LF,496, 488);
% % 
% [prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60716a01_T_SCC_LF, obj_60716a01_T_SCC_LF, [dx, dy], 450, selocex, fe1locex, fe2locex);
% 

%% Se atom on dumbbell
% %
[data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_se_atom(obj_60716a01_T_SCC_LF,487, 490);
% % 
[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60716a01_T_SCC_LF, obj_60716a01_T_SCC_LF, [dx, dy], 450, selocex, fe1locex, fe2locex);
% 