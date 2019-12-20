%% Cu site intensity extraction
Cu_int_pos = zeros(360,360);
Cu_int_pos(Cu_Cor) = I_pos_cor(Cu_Cor);

Cu_int_neg = zeros(360,360);
Cu_int_neg(Cu_Cor) = I_neg_cor(Cu_Cor);
%%
img_plot2(Cu_int_pos,Cmap.Sailing,'Cu Pos Intensity');
img_plot2(Cu_int_neg,Cmap.Sailing,'Cu Neg Intensity');

%% Oxygen Site intensity extraction
Ox_int = zeros(360,360);
Ox_int(Ox_Cor) = I_pos_cor(Ox_Cor); 

Oy_int = zeros(360,360);
Oy_int(Oy_Cor) = I_pos_cor(Oy_Cor);
%%
img_plot2(Ox_int,Cmap.Sailing,'Ox Intensity');
img_plot2(Oy_int,Cmap.Sailing,'Oy Intensity');
%%
img_plot2(Ox_int+Oy_int,Cmap.Sailing,'Ox + Oy Intensity');
%% Finding neighbors to Cu atoms
Ox_ind = Ox*2;
Oy_ind = Oy*3;

Cu_Ox = Cu + Ox_ind;
Cu_Oy = Cu + Oy_ind;
%%
[Cu_index(:,1) Cu_index(:,2)] = find(Cu == 1);
%% Find closest Oy atoms to each Cu site
index_Oy = zeros(length(r),2);
for i = 1:length(r)
    for n = 1:5        
        
        %sum(sum(Cu_Oy(r(i):r(i)+n,c(i):-1:c(i)-n)))
        r_tmp = 0; c_tmp = 0;
        if (r(i)>= 360-4 || c(i) <= 4)
            break;
        elseif (sum(sum(Cu_Oy(r(i):r(i)+n,c(i):-1:c(i)-n))) > 1)
            [r_tmp c_tmp] = find(Cu_Oy(r(i):r(i)+n,c(i)-n:c(i)) == 3);
            index_Oy(i,1) = (r(i)+r_tmp - 1);
            index_Oy(i,2) = (c(i)-n +c_tmp - 1);
            break;
        end
    end
end
%% Find closest Ox atoms to each Cu site
index_Ox = zeros(length(r),2);
for i = 1:length(r)
    count = 1;
    for n = 1:5
        %sum(sum(Cu_Ox(r(i):r(i)+n,c(i):c(i)+n)))
        r_tmp = 0; c_tmp = 0;
        if (r(i)>= 360-4 || c(i) >= 360-4)
            break;
        elseif (sum(sum(Cu_Oy(r(i):r(i)+n,c(i):c(i)+n))) > 1)
            [r_tmp c_tmp] = find(Cu_Ox(r(i):r(i)+n,c(i):c(i)+n) == 2);
            index_Ox(i,1) = (r(i)+r_tmp - 1);
            index_Ox(i,2) = (c(i)+c_tmp - 1);
            break;
        end
    end
end
        
%%
figure; plot (index_Ox(:,2),index_Ox(:,1),'b.');
hold on; plot(index_Oy(:,2),index_Oy(:,1),'g.');
hold on; plot(c,r,'r.'); axis off; axis equal
%%
%k = 2005;
%figure; plot(index_Cu(k,2),index_Cu(k,1),'r.');
%hold on; plot(index_Ox(k,2),index_Ox(k,1),'b.');
%hold on; plot(index_Oy(k,2),index_Oy(k,1),'g.');

hold on; 
 for k = 1:length(r)
    if (index_Oy(k,1) ~= 0 && index_Oy(k,2) ~= 0 && index_Ox(k,1) ~= 0 && index_Ox(k,2) ~= 0)
        plot(index_Cu(k,2),index_Cu(k,1),'go');hold on;
        hold on; plot([index_Cu(k,2) index_Ox(k,2)],[index_Cu(k,1) index_Ox(k,1)],'r');
        hold on; plot([index_Cu(k,2) index_Oy(k,2)],[index_Cu(k,1) index_Oy(k,1)],'b');
    end
 end
%hold on; plot (index_Ox(:,2),index_Ox(:,1),'rx'); hold on; plot(index_Oy(:,2),index_Oy(:,1),'b.');
%% Extract intensities at sites

INR_pos = zeros(360,360);
INR_neg = zeros(360,360);
for i = 1:length(r)
    if (index_Oy(i,1) ~= 0 && index_Oy(i,2) ~= 0 && index_Ox(i,1) ~= 0 && index_Ox(i,2) ~= 0)
        INR_pos(index_Cu(i,1),index_Cu(i,2)) = (I_pos_cor(index_Ox(i,1),index_Ox(i,2)) - I_pos_cor(index_Oy(i,1),index_Oy(i,2)))/sqrt(I_pos_cor(index_Ox(i,1),index_Ox(i,2))^2 + I_pos_cor(index_Oy(i,1),index_Oy(i,2))^2);
        INR_neg(index_Cu(i,1),index_Cu(i,2)) = (I_neg_cor(index_Ox(i,1),index_Ox(i,2)) - I_neg_cor(index_Oy(i,1),index_Oy(i,2)))/sqrt(I_neg_cor(index_Ox(i,1),index_Ox(i,2))^2 + I_neg_cor(index_Oy(i,1),index_Oy(i,2))^2);
    end
end
img_plot2(INR_pos,Cmap.CoBlPu,'INR positive');
img_plot2(INR_neg,Cmap.CoBlPu, 'INR negative');
        