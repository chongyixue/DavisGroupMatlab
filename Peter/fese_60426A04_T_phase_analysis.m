%% Fe up

% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60426a04_T_LF_SCC_LF,463, 433);
% % 
% [prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60426a04_T_LF_SCC_LF, obj_60426a04_T_LF_SCC_LF, [dx, dy], 380, selocex, fe1locex, fe2locex);
% 
% real_prft_topo = prft_topo;
% real_prft_topo.map = real(prft_topo.map);
% 
% imag_prft_topo = prft_topo;
% imag_prft_topo.map = imag(prft_topo.map);

%% Se vacancy
% % %
% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_se_atom_integer(obj_60426a04_T_LF_SCC_LF,462, 461);
% % % 
% [prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60426a04_T_LF_SCC_LF, obj_60426a04_T_LF_SCC_LF, [dx, dy], 380, selocex, fe1locex, fe2locex);
% % 
% 
% real_prft_topo = prft_topo;
% real_prft_topo.map = real(prft_topo.map);
% 
% imag_prft_topo = prft_topo;
% imag_prft_topo.map = imag(prft_topo.map);


%% Fe right
% %
% [data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60426a04_T_LF_SCC_LF,492, 461);
% % 
% [prft_data, prft_topo, clfdata, clftopo] = fesesingleimpurityphaseanalysis(obj_60426a04_T_LF_SCC_LF, obj_60426a04_T_LF_SCC_LF, [dx, dy], 380, selocex, fe1locex, fe2locex);
% 
% real_prft_topo = prft_topo;
% real_prft_topo.map = real(prft_topo.map);
% 
% imag_prft_topo = prft_topo;
% imag_prft_topo.map = imag(prft_topo.map);


%% Fe up IFT analysis with Gaussian mask

[data_loc, dx, dy, selocex, fe1locex, fe2locex] = fesefinddefectcenter_integer(obj_60426a04_T_LF_SCC_LF,463, 433);
% 
[prft_data, prft_topo, clfdata, clftopo, selocex, fe1locex, fe2locex] = fesesingleimpurityphaseanalysis_nosine(obj_60426a04_T_LF_SCC_LF, obj_60426a04_T_LF_SCC_LF, [dx, dy], 380, selocex, fe1locex, fe2locex);

mask = Gaussianmask(prft_topo, 369, 369, 393, 393, 393, 370, 369, 392,  3);

real_prft_topo = prft_topo;
real_prft_topo.map = real(prft_topo.map);
real_prft_topo.cpx_map = real(prft_topo.map) .* mask;

imag_prft_topo = prft_topo;
imag_prft_topo.map = imag(prft_topo.map);
imag_prft_topo.cpx_map = imag(prft_topo.map) .* mask * 1i;

ampl_prft_topo = prft_topo;
ampl_prft_topo.map = abs(prft_topo.map);
ampl_prft_topo.cpx_map = abs(prft_topo.map) .* mask;

real_fe_topo = ifftshift( ( fourier_transform2d_vb(real_prft_topo.cpx_map,'none','real','ift') ) );

imag_fe_topo = ifftshift( ( fourier_transform2d_vb(imag_prft_topo.cpx_map,'none','real','ift') ) );

ampl_fe_topo = ifftshift( ( fourier_transform2d_vb(ampl_prft_topo.cpx_map,'none','real','ift') ) );

%%

% [mgt1, mgt2, mgt3, mgt4] = Gaussian_fit_qpeaks(real_prft_topo, 369, 369, 393, 393, 393, 370, 369, 392,  3);
% figure, plot([mgt1, mgt2, mgt3, mgt4])

[mgt1, mgt2, mgt3, mgt4] = mean_q_peaks(real_prft_topo, 369, 369, 392, 369, 369, 392, 392, 392);
figure, plot([mgt1, mgt2, mgt3, mgt4])

real_5mV_xmy = abs(mgt1) - abs(mgt2);
real_5mV_xpy = (abs(mgt1) + abs(mgt2)) / 2;

% [mgt1, mgt2, mgt3, mgt4] = Gaussian_fit_qpeaks(imag_prft_topo, 369, 369, 393, 393, 393, 370, 369, 392,  3);
% figure, plot([mgt1, mgt2, mgt3, mgt4])

[mgt1, mgt2, mgt3, mgt4] = mean_q_peaks(imag_prft_topo, 369, 369, 392, 369, 369, 392, 392, 392);
figure, plot([mgt1, mgt2, mgt3, mgt4])

imag_5mV_xmy = abs(mgt1) - abs(mgt2);
imag_5mV_xpy = (abs(mgt1) + abs(mgt2)) / 2;

% [mgt1, mgt2, mgt3, mgt4] = Gaussian_fit_qpeaks(ampl_prft_topo, 369, 369, 393, 393, 393, 370, 369, 392,  3);
% figure, plot([mgt1, mgt2, mgt3, mgt4])

[mgt1, mgt2, mgt3, mgt4] = mean_q_peaks(ampl_prft_topo, 369, 369, 392, 369, 369, 392, 392, 392);
figure, plot([mgt1, mgt2, mgt3, mgt4])

ampl_5mV_xmy = abs(mgt1) - abs(mgt2);
ampl_5mV_xpy = (abs(mgt1) + abs(mgt2)) /2;

%% plot position of Se and Fe atoms for FeSe

[nx, ny, nz] = size(clftopo.map);
p = 6;

change_color_of_STM_maps(clftopo.map,'no')


hold on 

for i=1:length(fe1locex(1,:))
    if fe1locex(1,i) >= 500 && fe1locex(1,i) <= ny && fe1locex(2,i) >= 500 && fe1locex(2,i) <= nx
        plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(fe2locex(1,:))
    if fe2locex(1,i) >= 500 && fe2locex(1,i) <= ny && fe2locex(2,i) >= 500 && fe2locex(2,i) <= nx
        plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(selocex(1,:))
    if selocex(1,i) >= 500 && selocex(1,i) <= ny && selocex(2,i) >= 500 && selocex(2,i) <= nx
        plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
%         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
    end
end

% plot(ndx, ndy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);


hold off


[nx, ny, nz] = size(real_fe_topo);
p = 6;

change_color_of_STM_maps(real_fe_topo,'no')


hold on 

for i=1:length(fe1locex(1,:))
    if fe1locex(1,i) >= 500 && fe1locex(1,i) <= ny && fe1locex(2,i) >= 500 && fe1locex(2,i) <= nx
        plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(fe2locex(1,:))
    if fe2locex(1,i) >= 500 && fe2locex(1,i) <= ny && fe2locex(2,i) >= 500 && fe2locex(2,i) <= nx
        plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(selocex(1,:))
    if selocex(1,i) >= 500 && selocex(1,i) <= ny && selocex(2,i) >= 500 && selocex(2,i) <= nx
        plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
%         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
    end
end

% plot(ndx, ndy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);


hold off

[nx, ny, nz] = size(imag_fe_topo);
p = 6;

change_color_of_STM_maps(imag_fe_topo,'no')


hold on 

for i=1:length(fe1locex(1,:))
    if fe1locex(1,i) >= 500 && fe1locex(1,i) <= ny && fe1locex(2,i) >= 500 && fe1locex(2,i) <= nx
        plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(fe2locex(1,:))
    if fe2locex(1,i) >= 500 && fe2locex(1,i) <= ny && fe2locex(2,i) >= 500 && fe2locex(2,i) <= nx
        plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(selocex(1,:))
    if selocex(1,i) >= 500 && selocex(1,i) <= ny && selocex(2,i) >= 500 && selocex(2,i) <= nx
        plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
%         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
    end
end

% plot(ndx, ndy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);


hold off

[nx, ny, nz] = size(ampl_fe_topo);
p = 6;

change_color_of_STM_maps(ampl_fe_topo,'no')


hold on 

for i=1:length(fe1locex(1,:))
    if fe1locex(1,i) >= 500 && fe1locex(1,i) <= ny && fe1locex(2,i) >= 500 && fe1locex(2,i) <= nx
        plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe1locex(1,i), fe1locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(fe2locex(1,:))
    if fe2locex(1,i) >= 500 && fe2locex(1,i) <= ny && fe2locex(2,i) >= 500 && fe2locex(2,i) <= nx
        plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
%         plot(fe2locex(1,i), fe2locex(2,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
    end
end

for i=1:length(selocex(1,:))
    if selocex(1,i) >= 500 && selocex(1,i) <= ny && selocex(2,i) >= 500 && selocex(2,i) <= nx
        plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
%         plot(selocex(1,i), selocex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
    end
end

% plot(ndx, ndy,'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);


hold off