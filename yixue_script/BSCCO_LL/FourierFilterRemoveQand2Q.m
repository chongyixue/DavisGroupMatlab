% 2019-9-25 YXC

% 
% figure,plot(en,average_spectrum_map(original),'b')
% hold on,plot(en,average_spectrum_map(remove2Q),'r')
% xlabel('mV')
% legend('original','2Q removed')
% title('Averaged Spectra')

masktype = 'Gauss';

% %% Only show center
% x = 263;y=263;
% [~,~,layers] = size(original.map);
% gw = [1,3,5,10];
% n_specs = length(gw);
% specmat = zeros(n_specs,layers);
% specmatcrop = zeros(n_specs,layers);
% en = original.e*1000;
% 
% for i=1:n_specs
%     inverse = keep_peak_coord(original,x,y,gw(i),masktype);
%     % removecentercrop = crop_center(removecenter,262,431,100);
% %     img_obj_viewer_test(inverse)
%     % figure,plot(en,average_spectrum_map(removecenter))
% %     img_obj_viewer_test(inverse)
%     inversecrop = crop_center(inverse,262,431,100);
%     inversecrop.name = 'inversecrop';
%     inverse.name = 'inverse';
%     specmat(i,:) = average_spectrum_map(inverse);
%     specmatcrop(i,:) = average_spectrum_map(inversecrop);
% end
% div = 1.5/(n_specs);
% figure,
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     plot(en,specmat(i,:),'Color',[R,0,B])
%     hold on
% end
% title(strcat('Averaged spec qspace-core with varying ',masktype, 'pixel width'))
% gwstr = num2str(gw');
% xlabel('mV')
% legend(gwstr)
% 
% figure,
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     spec = specmat(i,:);
%     m = mean(spec);
%     spec = spec - m;
%     fo = abs(fft(spec));
%     fo = fo/max(fo);
%     plot(0:(layers+1)/2-1,fo(1:(layers+1)/2)+(i-1)*0,'Color',[R,0,B])
%     hold on
% end
% title(strcat('Normalized FFT of Averaged spec qspace-core with varying ',masktype, ' pixel width'))
% gwstr = num2str(gw');
% legend(gwstr)
% 
% 
% figure,
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     plot(en,specmatcrop(i,:),'Color',[R,0,B])
%     hold on
% end
% title(strcat('Averaged spec qspace-core with varying ',masktype, ' pixel width (cropped FOV)'))
% gwstr = num2str(gw');
% xlabel('mV')
% legend(gwstr)
% 
% figure,
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     spec = specmatcrop(i,:);
%     m = mean(spec);
%     spec = spec - m;
%     fo = abs(fft(spec));
%     fo = fo/max(fo);
%     plot(0:(layers+1)/2-1,fo(1:(layers+1)/2)+(i-1)*0,'Color',[R,0,B])
% %     plot(spec)
%     hold on
% end
% title(strcat('Normalized FFT of average spec qspace-core with varying ',masktype, ' pixel width (cropped FOV)'))
% gwstr = num2str(gw');
% legend(gwstr)

% masktype = 'Circle';
% %% remove 2Q vary gaussian width
% [~,~,layers] = size(original.map);
% gw = [5,6,7,8,9,10,11,12,13,14];
% n_specs = length(gw);
% specmat = zeros(n_specs,layers);
% en = original.e*1000;
% for i = 1:n_specs
%     remove2Q = remove_peak_coord(original,[278,278],[248,278],gw(i),masktype);
%     remove2Q = crop_center(remove2Q,262,431,100);
%     specmat(i,:) = average_spectrum_map(remove2Q);
% end
% div = 1.5/(n_specs);
% figure,
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     plot(en,specmat(i,:),'Color',[R,0,B])
%     hold on
% end
% title(strcat('Averaged spectra of 2Q filtered data with varying ',masktype, ' width (cropped FOV)'))
% gwstr = num2str(gw');
% legend(gwstr)

masktype = 'Gauss';
%% keep 2Q vary gaussian width
[~,~,layers] = size(original.map);
gw = [5,6,7,8,9,10,11,12,13,14];
n_specs = length(gw);
specmat = zeros(n_specs,layers);
en = original.e*1000;
for i = 1:n_specs
    remove2Q = keep_peak_coord(original,[278,278],[248,278],gw(i),masktype);
    remove2Q = crop_center(remove2Q,262,431,100);
    specmat(i,:) = average_spectrum_map(remove2Q);
end
div = 1.5/(n_specs);
figure,
for i = 1:n_specs
    R = max(0,(i-n_specs/2)*div);
    B = max(0,1-div*i);
    plot(en,specmat(i,:),'Color',[R,0,B])
    hold on
end
title(strcat('Averaged spectra of 2Q data with varying ',masktype, ' width (cropped FOV)'))
gwstr = num2str(gw');
legend(gwstr)

% %% remove Q vary gaussian width
% x = [270,270];y=[256,270];
% [~,~,layers] = size(original.map);
% gw = [1,2,3,4,5,6,7,8,9];
% n_specs = length(gw);
% specmat = zeros(n_specs,layers);
% en = original.e*1000;
% for i = 1:n_specs
%     remove2Q = remove_peak_coord(original,x,y,gw(i),masktype);
% %     remove2Q = crop_center(remove2Q,262,431,100);
%     specmat(i,:) = average_spectrum_map(remove2Q);
% end
% div = 1.5/(n_specs);
% figure,
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     plot(en,specmat(i,:),'Color',[R,0,B])
%     hold on
% end
% title(strcat('Averaged spectra of Q filtered data with varying',masktype,'  width'))
% gwstr = num2str(gw');
% legend(gwstr)


% %% remove Center vary gaussian width
% x = [263];y=[263];
% [~,~,layers] = size(original.map);
% gw = [0,1,3,5,7,9];
% n_specs = length(gw);
% specmat = zeros(n_specs,layers);
% specmatnocrop = zeros(n_specs,layers);
% 
% en = original.e*1000;
% for i = 1:n_specs
%     remove2Q = remove_peak_coord(original,x,y,gw(i),masktype);
% %     img_obj_viewer_test(remove2Q)
%     specmatnocrop(i,:) = average_spectrum_map(remove2Q);
%     remove2Q = crop_center(remove2Q,262,431,100);
%     specmat(i,:) = average_spectrum_map(remove2Q);
% end
% div = 1.5/(n_specs);
% 
% figure,
% % for i = 1:n_specs
% %     R = max(0,(i-n_specs/2)*div);
% %     B = max(0,1-div*i);
% %     plot(en,specmat(i,:),'Color',[R,0,B])
% %     hold on
% % end
% 
% for i = 1:n_specs
%     R = max(0,(i-n_specs/2)*div);
%     B = max(0,1-div*i);
%     plot(en,specmatnocrop(i,:),'Color',[R,0,B],'LineStyle','--')
%     hold on
% end
% 
% title(strcat('Averaged spectra of core filtered data with varying',masktype,'  width (cropped FOV)'))
% gwstr = num2str(gw');
% legend(gwstr)
% hold on

% %% remove center
% x = 263;y=263;
% [~,~,layers] = size(original.map);
% gw = 1;
% n_specs = length(gw);
% specmat = zeros(n_specs,layers);
% en = original.e*1000;
% 
% removecenter = remove_peak_coord(original,x,y,gw,masktype);
% removecentercrop = crop_center(removecenter,262,431,100);
% img_obj_viewer_test(removecenter)
% figure,plot(en,average_spectrum_map(removecenter))
% 
% inverse = removecenter;
% inverse.map = original.map-removecenter.map;
% img_obj_viewer_test(inverse)

% figure,plot(en,average_spectrum_map(sub12Q),'b')
% hold on,plot(en,average_spectrum_map(sub22Q),'r')
% xlabel('mV')
% legend('original','2Q removed')
% title('Averaged Spectra 100px centering (262,431)')

% figure,plot(en,average_spectrum_map(original),'b')
% hold on,plot(en,average_spectrum_map(remove2Q),'r')
% hold on,plot(en,average_spectrum_map(removeQ),'r--')
% 
% xlabel('mV')
% legend('original','2Q removed','Q removed')
% title('Averaged Spectra')



