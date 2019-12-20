%% Fe up

[data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60801A00_T_LF,65, 73);
% 
[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60801a00_G_LF, obj_60801A00_T_LF, [dx, dy], 55, selocex, fe1locex, fe2locex);

[prft_idata, prft_topo, clfidata, clftopo] = fesesingleimpurityphaseanalysis(obj_60801A00_I_LF, obj_60801A00_T_LF, [dx, dy], 55, selocex, fe1locex, fe2locex);

real_prft_data = prft_data;
real_prft_data.map = real(prft_data.map);

imag_prft_data = prft_data;
imag_prft_data.map = imag(prft_data.map);

real_prft_idata = prft_idata;
real_prft_idata.map = real(prft_idata.map);

imag_prft_idata = prft_idata;
imag_prft_idata.map = imag(prft_idata.map);

real_prft_topo = prft_topo;
real_prft_topo.map = real(prft_topo.map);

imag_prft_topo = prft_topo;
imag_prft_topo.map = imag(prft_topo.map);
