
[dx1, dy1] = determine_singleimp_center_single_peak(obj_60428a00_G_LF, 1, 148, 149, 8, 8, 'no');
[dx2, dy2] = determine_singleimp_center_single_peak(obj_60428a00_G_LF, 11, 148, 149, 8, 8, 'invert');

dx = (dx1+dx2)/2;
dy = (dy1+dy2)/2;

[data_loc, lfsedx, lfsedy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_se_atom_integer(obj_60428A00_T_LF,148, 149);
[data_loc, lffedx, lffedy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60428A00_T_LF,150, 143);

fedx = dx + (lffedx - lfsedx);
fedy = dy + (lffedy - lfsedy);

p = 10;
change_color_of_STM_maps(obj_60428A00_T_LF.map,'no')
hold on 

plot(lfsedx, lfsedy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 3);
plot(lffedx, lffedy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);

plot(dx, dy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 3);
plot(fedx, fedy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m', 'LineWidth', 3);


hold off

p = 10;
change_color_of_STM_maps(obj_60428a00_G_LF.map(:,:,1),'no')
hold on 

plot(lfsedx, lfsedy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 3);
plot(lffedx, lffedy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);

plot(dx, dy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 3);
plot(fedx, fedy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m', 'LineWidth', 3);


hold off

p = 10;
change_color_of_STM_maps(obj_60428a00_G_LF.map(:,:,11),'no')
hold on 

plot(lfsedx, lfsedy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 3);
plot(lffedx, lffedy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 3);

plot(dx, dy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 3);
plot(fedx, fedy,'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','m','MarkerFaceColor','m', 'LineWidth', 3);


hold off
%% Fe up using LF topo

% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60428A00_T_LF,150, 143);
% 
[prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60428a00_G_LF, obj_60428A00_T_LF, [lffedx, lffedy], 120, selocex, fe1locex, fe2locex);

real_prft_data = prft_data;
real_prft_data.map = real(prft_data.map);

imag_prft_data = prft_data;
imag_prft_data.map = imag(prft_data.map);


real_prft_topo = prft_topo;
real_prft_topo.map = real(prft_topo.map);

imag_prft_topo = prft_topo;
imag_prft_topo.map = imag(prft_topo.map);

%% Fe up using LF map, fit to defects in first and last layer add suffix df (defect fit origin)

[prft_data_df, prft_topo_df, clfdata_df, clftopo_df] = fesesingleimpurityphaseanalysis(obj_60428a00_G_LF, obj_60428A00_T_LF, [fedx, fedy], 120, selocex, fe1locex, fe2locex);

real_prft_data_df = prft_data_df;
real_prft_data_df.map = real(prft_data_df.map);

imag_prft_data_df = prft_data_df;
imag_prft_data_df.map = imag(prft_data_df.map);


real_prft_topo_df = prft_topo_df;
real_prft_topo_df.map = real(prft_topo_df.map);

imag_prft_topo_df = prft_topo_df;
imag_prft_topo_df.map = imag(prft_topo_df.map);


%% Se vacancy
% % %
% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_se_atom_integer(obj_60428A00_T_LF,150, 151);
% % % 
% [prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60428a00_G_LF, obj_60428A00_T_LF, [dx, dy], 120, selocex, fe1locex, fe2locex);
% % 
% 
% real_prft_data = prft_data;
% real_prft_data.map = real(prft_data.map);
% 
% imag_prft_data = prft_data;
% imag_prft_data.map = imag(prft_data.map);
% 
% 
% real_prft_topo = prft_topo;
% real_prft_topo.map = real(prft_topo.map);
% 
% imag_prft_topo = prft_topo;
% imag_prft_topo.map = imag(prft_topo.map);


%% Fe right
% %
% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60428A00_T_LF,158, 151);
% % 
% [prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60428a00_G_LF, obj_60428A00_T_LF, [dx, dy], 120, selocex, fe1locex, fe2locex);
% 
% real_prft_data = prft_data;
% real_prft_data.map = real(prft_data.map);
% 
% imag_prft_data = prft_data;
% imag_prft_data.map = imag(prft_data.map);
% 
% 
% real_prft_topo = prft_topo;
% real_prft_topo.map = real(prft_topo.map);
% 
% imag_prft_topo = prft_topo;
% imag_prft_topo.map = imag(prft_topo.map);