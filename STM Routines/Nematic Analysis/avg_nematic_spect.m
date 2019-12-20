%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: The conductance/current map is studied based on the 
% domain structure set by the nematic domain domain image (usually obtained 
% from the INR map).  In regions of the same nematic sign the spectra on
% the Ox and Oy positions are averaged separately yielding the four output
% curves.  The pixels included in the average are only those whose nematic
% values is above and below some threshold limit.

% INPUTS:   img_obj -> the layered image from which the spectra are
%                      averaged
%           nem_img -> the INR layer which demonstrates the nematic domains
%           pos_thresh -> a 1x2 vector giving the lower and upper limits of
%                         the nematic values to be considered from nem_img
%                         which have positive nematicity
%           neg_thresh -> a 1x2 vector giving the lower and upper limits of
%                         the nematic values to be considered from nem_img
%                         which have negative nematicity
%           *_index -> position of the Cu and associated Oy and Ox sites.
%
% OUTPUTS: avg_spect_Ox_pos, avg_spect_Oy_pos -> spectra average over Oy
%                                                and Ox sites when the nematic 
%                                                value is positive
%          avg_spect_Ox_neg, avg_spect_Oy_neg -> spectra average over Oy
%                                                and Ox sites when the nematic 
%                                                value is positive

% ALGORITHM: 
%
% CODE HISTORY
%
% 100916 MHH Created

function [avg_spect_Ox_pos avg_spect_Oy_pos avg_spect_Ox_neg avg_spect_Oy_neg] =...
            avg_nematic_spect(img_obj,nem_img,pos_thresh,neg_thresh, Cu_index,...
           Ox_index,Ox_index2,Oy_index,Oy_index2)

load_color;        
[nr nc nz] = size(img_obj.map);
avg_spect_Ox_pos = zeros(nz,1);avg_spect_Oy_pos = zeros(nz,1);        
avg_spect_Ox_neg = zeros(nz,1);avg_spect_Oy_neg = zeros(nz,1);        
pos_count = 0;
neg_count = 0;
for i =1:size(Cu_index,1)
    value = nem_img(Cu_index(i,1),Cu_index(i,2));
    if (value > pos_thresh(1) && value < pos_thresh(2))
        pos_count = pos_count + 1;
        pos_index(pos_count) = i;        
    elseif (value < neg_thresh(1) && value > neg_thresh(2))
        neg_count = neg_count + 1;
        neg_index(neg_count) = i;
        
    end
end
display(['Number of Postive Nematic Points ' num2str(pos_count)]);
display(['Number of Negative Nematic Points ' num2str(neg_count)]);
for i = 1:pos_count    
    spct_Ox1 = squeeze(squeeze(img_obj.map(Ox_index(pos_index(i),1),Ox_index(pos_index(i),2),:)));
    spct_Ox2 = squeeze(squeeze(img_obj.map(Ox_index2(pos_index(i),1),Ox_index2(pos_index(i),2),:)));
    avg_spect_Ox_pos = avg_spect_Ox_pos + (spct_Ox1 + spct_Ox2)/2;
    
    spct_Oy1 = squeeze(squeeze(img_obj.map(Oy_index(pos_index(i),1),Oy_index(pos_index(i),2),:)));
    spct_Oy2 = squeeze(squeeze(img_obj.map(Oy_index2(pos_index(i),1),Oy_index2(pos_index(i),2),:)));
    avg_spect_Oy_pos = avg_spect_Oy_pos + (spct_Oy1 + spct_Oy2)/2;
end
avg_spect_Oy_pos = avg_spect_Oy_pos/pos_count;
avg_spect_Ox_pos = avg_spect_Ox_pos/pos_count;
figure; plot(img_obj.e*1000,avg_spect_Oy_pos); hold on;
plot(img_obj.e*1000,avg_spect_Ox_pos,'r');
title('Positive Nematicity Averaged Spectra - Ox & Oy');

for i = 1:neg_count
    
    spct_Ox1 = squeeze(squeeze(img_obj.map(Ox_index(neg_index(i),1),Ox_index(neg_index(i),2),:)));
    spct_Ox2 = squeeze(squeeze(img_obj.map(Ox_index2(neg_index(i),1),Ox_index2(neg_index(i),2),:)));
    avg_spect_Ox_neg = avg_spect_Ox_neg + (spct_Ox1 + spct_Ox2)/2;
    
    spct_Oy1 = squeeze(squeeze(img_obj.map(Oy_index(neg_index(i),1),Oy_index(neg_index(i),2),:)));
    spct_Oy2 = squeeze(squeeze(img_obj.map(Oy_index2(neg_index(i),1),Oy_index2(neg_index(i),2),:)));
    avg_spect_Oy_neg = avg_spect_Oy_neg + (spct_Oy1 + spct_Oy2)/2;
end
avg_spect_Oy_neg = avg_spect_Oy_neg/neg_count;
avg_spect_Ox_neg = avg_spect_Ox_neg/neg_count;
figure; plot(img_obj.e*1000,avg_spect_Oy_neg); hold on;
plot(img_obj.e*1000,avg_spect_Ox_neg,'r');
title('Negative Nematicity Averaged Spectra - Ox & Oy');


%pos_count
%neg_count
figure; img_plot2(nem_img,Cmap.PurBlaCop); hold on;
for j = 1:pos_count
    plot(Cu_index(pos_index(j),2),Cu_index(pos_index(j),1),'r.'); hold on;
end
for j = 1:neg_count
    plot(Cu_index(neg_index(j),2),Cu_index(neg_index(j),1),'bx'); hold on;
    
end


end

