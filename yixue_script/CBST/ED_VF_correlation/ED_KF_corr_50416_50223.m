% from peter analysis 50416a00 and 50223 
% save each llmap as llmap_50416 and llmap_50223
% yxc 2019-10-6

% first load the data from peter analysis
% index 4 is 0th LL

% %% 50416
% 
% [nx,ny,levels] = size(llmap_50416);
% ll_average_50416_1d = [114,126,140,196,228,246,260];
% 
% 
% llmap_50416_corrected = llmap_50416;
% for x = 1:nx
%     for y=1:ny
%         ll = squeeze(squeeze(llmap_50416(x,y,:)));
%         for lay = 1:levels
%             [~,index] = min(abs(ll-ll_average_50416_1d(lay)));
%             llmap_50416_corrected(x,y,lay) = ll(index);
%         end
%     end
% 
% end
% [llmapshow_50416,~,~,~,~] = ED_KF_corr_function(llmap_50416_corrected,obj_50416A00_G,4,0);


%% 50223a00

[llmappredict_50223,llmapDIFF_50223,llmapshow_50223] = predict_LL(llmap_50223,obj_50223A00_G,4,-1,-1,-1,-1);

[~,Del,VL,VH,Ed] = ED_KF_corr_function(llmap_50223,obj_50223A00_G,4,-1);
img_obj_viewer_test(Del)
img_obj_viewer_test(VL)
img_obj_viewer_test(VH)
img_obj_viewer_test(Ed)
% 
% img_obj_viewer_test(llmappredict_50223)
% img_obj_viewer_test(llmapDIFF_50223)
img_obj_viewer_test(llmapshow_50223)
ft = fourier_transform2d(polyn_subtract(llmapshow_50223,0,'noplot'),'sine','amplitude','ft');
[~,~,lay] = size(llmapshow_50223.map);

shiftup = 0;
figure,
for i=1:lay
    B = (i-1)/(lay-1);
    R = 1-B;
    [rad_avg,q] = radial_plot_singlelayer(ft,1,75,0,0,i,'noplot');
    plot(q,rad_avg+shiftup*(i-1),'Color',[R 0 B]);
    hold on    
end
xlabel('$q(\AA)$','Interpreter','latex')
ylabel('intensity')
ylim([0,400+shiftup*lay])
legend(num2str(ft.e'*1000))
title('Angular-averaged FT of Landau Level energy maps')


shiftup = 0;
figure,
layerstoshow = [-2,2];
lay = length(layerstoshow);
for i=1:lay
    B = (i-1)/(lay-1);
    R = 1-B;
    [rad_avg,q] = radial_plot_singlelayer(ft,1,75,0,0,i,'noplot');
    plot(q,rad_avg+shiftup*(i-1),'Color',[R 0 B]);
    hold on    
end
xlabel('$q(\AA)$','Interpreter','latex')
ylabel('intensity')
ylim([0,400+shiftup*lay])
legend(num2str(layerstoshow'))
title('Angular-averaged FT of Landau Level energy maps')

% %% 50406a00
% 
% [llmappredict_50406,llmapDIFF_50406,llmapshow_50406] = predict_LL(llmap_50406,obj_50406A00_G,2,0,0,0,0);
% 
% [~,Del,VL,VH,Ed] = ED_KF_corr_function(llmap_50406,obj_50406A00_G,2,0);
% img_obj_viewer_test(Del)
% img_obj_viewer_test(VL)
% img_obj_viewer_test(VH)
% img_obj_viewer_test(Ed)
% % 
% % img_obj_viewer_test(llmappredict_50223)
% % img_obj_viewer_test(llmapDIFF_50223)
% img_obj_viewer_test(llmapshow_50406)
% ft = fourier_transform2d(polyn_subtract(llmapshow_50406,0,'noplot'),'sine','amplitude','ft');
% [~,~,lay] = size(llmapshow_50406.map);

% [llmapshow_50223,Del,~,~,Ed] = ED_KF_corr_function(llmap_50223,obj_50223A00_G,4,0);
% [~,~,VF_lower,VF_higher,~] = ED_KF_corr_function(llmap_50223,obj_50223A00_G,4,-1);
% 
% img_obj_viewer_test(llmapshow_50223)
% 
% name = 'V_+1_EDDel_0';
% 
% VFL = VF_lower.map;
% VFH = VF_higher.map;
% ED = Ed.map;
% DEL = Del.map;
% 
% N3 = ED-sqrt(DEL.^2+3*VFL.^2);
% N2 = ED-sqrt(DEL.^2+2*VFL.^2);
% N1 = ED-sqrt(DEL.^2+1*VFL.^2);
% N0 = ED-DEL;
% P1 = ED+sqrt(DEL.^2+1*VFH.^2);
% P2 = ED+sqrt(DEL.^2+2*VFH.^2);
% P3 = ED+sqrt(DEL.^2+3*VFH.^2);
% P4 = ED+sqrt(DEL.^2+4*VFH.^2);
% P5 = ED+sqrt(DEL.^2+5*VFH.^2);
% P6 = ED+sqrt(DEL.^2+6*VFH.^2);
% 
% llmap_pred_50223 = llmapshow_50223;
% llmap_pred_50223.map(:,:,1) = N3;
% llmap_pred_50223.map(:,:,2) = N2;
% llmap_pred_50223.map(:,:,3) = N1;
% llmap_pred_50223.map(:,:,4) = N0;
% llmap_pred_50223.map(:,:,5) = P1;
% llmap_pred_50223.map(:,:,6) = P2;
% llmap_pred_50223.map(:,:,7) = P3;
% llmap_pred_50223.map(:,:,8) = P4;
% llmap_pred_50223.map(:,:,9) = P5;
% llmap_pred_50223.map(:,:,10) = P6;
% 
% llmap_pred_50223.name = strcat(llmap_pred_50223.name,'_pred_',name);
% img_obj_viewer_test(llmap_pred_50223)
% 
% llmapdiff = llmap_pred_50223;
% llmapdiff.map = llmap_pred_50223.map-llmap_50223;
% llmapdiff.name = strcat(llmapdiff.name,'DIFF');
% img_obj_viewer_test(llmapdiff)


% E2_pred = Ed;
% E2_pred.map = Ed.map+sqrt(Del.map.^2+2*VF.map.^2);
% E2_pred.name = 'LL2 pred';
% img_obj_viewer_test(E2_pred);
% E2diff = E2_pred;
% E2diff.map = E2_pred.map - llmapshow_50223.map(:,:,6);
% E2diff.name = 'LL2_diff_50223';
% img_obj_viewer_test(E2diff)




