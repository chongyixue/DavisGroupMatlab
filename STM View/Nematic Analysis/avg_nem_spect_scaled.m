%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION: The conductance/current map is studied based on the 
% domain structure set by the nematic domain domain image (usually obtained 
% from the INR map).  In regions of the same nematic sign the spectra on
% the Ox and Oy positions are averaged separately yielding the four output
% curves.  The pixels included in the average are only those whose nematic
% values is above and below some threshold limit. 

% INPUTS:   spct_obj -> the spectrum object contains the four associated
%                      spectra from each valid copper site, normalized by the
%                      averaged gap value for that unit cell.
%                      
%           nem_img -> the INR layer which demonstrates the nematic domains
%           pos_thresh -> a 1x2 vector giving the lower and upper limits of
%                         the nematic values to be considered from nem_img
%                         which have positive nematicity
%           neg_thresh -> a 1x2 vector giving the lower and upper limits of
%                         the nematic values to be considered from nem_img
%                         which have negative nematicity
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
% 100916 MHH Created (original did not use gap scaled spectra)
% 101029 MHH Modified to use gap scaled spectra.  Inputs have been modified

function graph_data = avg_nem_spect_scaled(spct_obj,nem_img,Cu_gap_map, pos_thresh,neg_thresh)

load_color;        
[nr nc nz] = size(spct_obj);
avg_spect_Ox_pos = zeros(nz,1);avg_spect_Oy_pos = zeros(nz,1);        
avg_spect_Ox_neg = zeros(nz,1);avg_spect_Oy_neg = zeros(nz,1);        
pos_count = 0;
neg_count = 0;
gap_neg_avg = 0;
gap_pos_avg = 0;
[Cu_index(:,1) Cu_index(:,2)] = find(Cu_gap_map ~=0);
for i =1:size(Cu_index,1)
    value = nem_img(Cu_index(i,1),Cu_index(i,2));
    if (value > pos_thresh(1) && value < pos_thresh(2))
        pos_count = pos_count + 1;
        pos_index(pos_count) = i;        
        gap_pos_avg = gap_pos_avg + Cu_gap_map(Cu_index(i,1),Cu_index(i,2));
    elseif (value < neg_thresh(1) && value > neg_thresh(2))
        neg_count = neg_count + 1;
        neg_index(neg_count) = i;
        gap_neg_avg = gap_neg_avg + Cu_gap_map(Cu_index(i,1),Cu_index(i,2));
        
    end
end
gap_pos_avg = gap_pos_avg/pos_count;
gap_neg_avg = gap_neg_avg/neg_count;
display(['Average Gap for Postive Nematic Points ' num2str(gap_pos_avg)]);
display(['Average Gap for Negative Nematic Points ' num2str(gap_neg_avg)]);
display(['Number of Postive Nematic Points ' num2str(pos_count)]);
display(['Number of Negative Nematic Points ' num2str(neg_count)]);
for i = 1:pos_count      
    spct_Ox1 = squeeze(squeeze(spct_obj.spct(pos_index(i),1,:)));
    spct_Ox2 = squeeze(squeeze(spct_obj.spct(pos_index(i),2,:)));
      
    avg_spect_Ox_pos = avg_spect_Ox_pos + (spct_Ox1 + spct_Ox2)/2;
    
    spct_Oy1 = squeeze(squeeze(spct_obj.spct(pos_index(i),3,:)));
    spct_Oy2 = squeeze(squeeze(spct_obj.spct(pos_index(i),4,:)));
    avg_spect_Oy_pos = avg_spect_Oy_pos + (spct_Oy1 + spct_Oy2)/2;
end
avg_spect_Oy_pos = avg_spect_Oy_pos/pos_count;
avg_spect_Ox_pos = avg_spect_Ox_pos/pos_count;
plot_avg_nem_spect(spct_obj.e*1000,avg_spect_Oy_pos,avg_spect_Ox_pos,...
              'Positive Nematicity Averaged Spectra - Ox & Oy');

for i = 1:neg_count
    
    spct_Ox1 = squeeze(squeeze(spct_obj.spct(neg_index(i),1,:)));
    spct_Ox2 = squeeze(squeeze(spct_obj.spct(neg_index(i),2,:)));
      
    avg_spect_Ox_neg = avg_spect_Ox_neg + (spct_Ox1 + spct_Ox2)/2;
    
    spct_Oy1 = squeeze(squeeze(spct_obj.spct(neg_index(i),3,:)));
    spct_Oy2 = squeeze(squeeze(spct_obj.spct(neg_index(i),4,:)));
    avg_spect_Oy_neg = avg_spect_Oy_neg + (spct_Oy1 + spct_Oy2)/2;
    
end
avg_spect_Oy_neg = avg_spect_Oy_neg/neg_count;
avg_spect_Ox_neg = avg_spect_Ox_neg/neg_count;
%plot results for negative domains
plot_avg_nem_spect(spct_obj.e*1000,avg_spect_Oy_neg,avg_spect_Ox_neg,...
              'Negative Nematicity Averaged Spectra - Ox & Oy');

%plot points use in averaging and also store them          
pos_site = zeros(pos_count,2);          
img_plot2(nem_img,Cmap.PurBlaCop); hold on;
for j = 1:pos_count
    plot(Cu_index(pos_index(j),2),Cu_index(pos_index(j),1),'r.'); hold on;
    pos_site(j,1) = Cu_index(pos_index(j),1);
    pos_site(j,2) = Cu_index(pos_index(j),2);
end
neg_site = zeros(neg_count,2);
for j = 1:neg_count
    plot(Cu_index(neg_index(j),2),Cu_index(neg_index(j),1),'bx'); hold on;
    neg_site(j,1) = Cu_index(neg_index(j),1);
    neg_site(j,2) = Cu_index(neg_index(j),2);    
end

graph_data.spct(:,1) = avg_spect_Ox_pos;
graph_data.spct(:,2) = avg_spect_Oy_pos;
graph_data.spct(:,3) = avg_spect_Ox_neg;
graph_data.spct(:,4) = avg_spect_Oy_neg;
graph_data.e = spct_obj.e*1000;
graph_data.pos_thresh = pos_thresh;
graph_data.neg_thresh = neg_thresh;
graph_data.gap_pos_avg = gap_pos_avg;
graph_data.gap_neg_avg = gap_neg_avg;
graph_data.pos_site = pos_site;
graph_data.neg_site = neg_site;

end
% function plot_avg_spect(x,y1,y2,main_title)
% figure; set(gcf,'Color',[1 1 1]);
% plot(x,y1,'b','LineWidth',2); hold on;
% plot(x,y2,'r','LineWidth',2);
% xlim([-1.5 1.5]);
% set(gca,'fontsize',16)
% title(main_title,'fontsize',16);
% xlabel('Energy (e)','fontsize',16);
% ylabel('Conductance (nS)','fontsize',16);
% leg = legend('O_y','O_x','Location','SouthEast');
% set(leg,'Interpreter','tex');
% 
% end
