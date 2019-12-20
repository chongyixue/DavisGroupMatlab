%
[data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter(obj_60801A00_T_LF,65, 70);
% 
[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60801a00_G_LF, obj_60801A00_T_LF, [dx, dy], 50, selocex, fe1locex, fe2locex);
% 