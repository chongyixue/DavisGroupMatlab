function plot_histogram_dialogue(layer,histo,fig_handle,axis_handle)

                     
% % generate a histogram for each layer of data.  Will be used for setting
% % color axis limit.  Also include the dimensions of img_obj.
% n = 1000;
% for k = 1:nz
%     tmp_layer = reshape(data.map(:,:,k),nr*nc,1);
%     tmp_std = std(tmp_layer);
%     % pick a common number of bins based on the largest spread of values in
%     % one of the layers
%     n1 = abs((max(tmp_layer) - min(tmp_layer)))/(2*tmp_std)*1000;
%     n = max(n,floor(n1));    
% end
% clear tmp_layer n1 tmp_std
% 
% for k=1:nz
%     [histo.freq(k,1:n) histo.val(k,1:n)] = hist(reshape(data.map(:,:,k),nr*nc,1),n);
% end
% histo.size = [nr nc nz];


    
%store the original value of the caxis from the figure - will be used for
%undo
caxis_revert = get(fig_handle,'UserData');

c_min_revert = caxis_revert(layer,1);
c_max_revert = caxis_revert(layer,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
n = histo.freq(layer,:); x = histo.val(layer,:);
bar(x,n./sum(n),1,'k'); grid on;
hist_axis = gca;
xlim([c_min_revert c_max_revert]);
set(get(hist_axis,'XLabel'),'String','Value');
set(get(hist_axis,'YLabel'),'String','% Occurrence');
            

      
end