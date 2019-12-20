function [avg_pos_Ox avg_pos_Oy avg_neg_Ox avg_neg_Oy] =...
            nem_dom_avg(img,nem_img,Cu_index,Ox_index1,Ox_index2,Oy_index1,Oy_index2,bins)

avg_pos_Ox = [];
avg_pos_Oy = [];
avg_neg_Ox = [];
avg_neg_Oy = [];
count_pos = 0;
count_neg = 0;


for i=1:length(Cu_index)
    if nem_img(Cu_index(i,1),Cu_index(i,2)) > 0
        count_pos = count_pos + 1;
        avg_pos_Ox(count_pos) = (img(Ox_index1(i,1),Ox_index1(i,2)) +...
            img(Ox_index2(i,1),Ox_index2(i,2)))/2; 
        
        avg_pos_Oy(count_pos) = (img(Oy_index1(i,1),Oy_index1(i,2)) +...
            img(Oy_index2(i,1),Oy_index2(i,2)))/2; 
        
    elseif nem_img(Cu_index(i,1),Cu_index(i,2)) < 0
        count_neg = count_neg + 1;
        avg_neg_Ox(count_neg) = (img(Ox_index1(i,1),Ox_index1(i,2)) +...
            img(Ox_index2(i,1),Ox_index2(i,2)))/2; 
        
        avg_neg_Oy(count_neg) = (img(Oy_index1(i,1),Oy_index1(i,2)) +...
            img(Oy_index2(i,1),Oy_index2(i,2)))/2; 
    end
        
end
mean(avg_pos_Ox)
mean(avg_pos_Oy)
histogram2(avg_pos_Ox,avg_pos_Oy,bins);
histogram2(avg_neg_Ox,avg_neg_Oy,bins);
mean(avg_neg_Ox)
mean(avg_neg_Oy)
end