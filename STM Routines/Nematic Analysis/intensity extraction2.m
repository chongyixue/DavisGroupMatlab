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
Oy_index = zeros(size(Cu_index,1),2);
for i = 1:size(Cu_index,1)
    for n = 1:5        
        
        %sum(sum(Cu_Oy(r(i):r(i)+n,c(i):-1:c(i)-n)))
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)>= 360-4 || Cu_index(i,2) <= 4)
            break;
        elseif (sum(sum(Cu_Oy(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2):-1:Cu_index(i,2)-n))) > 1)
            [r_tmp c_tmp] = find(Cu_Oy(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2)-n:Cu_index(i,2)) == 3);
            Oy_index(i,1) = (Cu_index(i,1)+r_tmp - 1);
            Oy_index(i,2) = (Cu_index(i,2)-n +c_tmp - 1);
            break;
        end
    end
end
%% Find closest Ox atoms to each Cu site
Ox_index = zeros(size(Cu_index,1),2);
for i = 1:size(Cu_index,1)
    count = 1;
    for n = 1:5
        %sum(sum(Cu_Ox(r(i):r(i)+n,c(i):c(i)+n)))
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)>= 360-4 || Cu_index(i,2) >= 360-4)
            break;
        elseif (sum(sum(Cu_Ox(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2):Cu_index(i,2)+n))) > 1)
            [r_tmp c_tmp] = find(Cu_Ox(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2):Cu_index(i,2)+n) == 2);
            Ox_index(i,1) = (Cu_index(i,1)+r_tmp - 1);
            Ox_index(i,2) = (Cu_index(i,2)+c_tmp - 1);
            break;
        end
    end
end
        
%%
figure; plot (Ox_index(:,2),Ox_index(:,1),'b.');

hold on; plot(Oy_index(:,2),Oy_index(:,1),'g.');
hold on; plot(Cu_index(:,2),Cu_index(:,1),'r.'); axis off; axis equal
%%
%k = 2005;
%figure; plot(index_Cu(k,2),index_Cu(k,1),'r.');
%hold on; plot(index_Ox(k,2),index_Ox(k,1),'b.');
%hold on; plot(index_Oy(k,2),index_Oy(k,1),'g.');
figure;

 for k = 1:size(Cu_index,1)
    if (Oy_index(k,1) ~= 0 && Oy_index(k,2) ~= 0 && Ox_index(k,1) ~= 0 && Ox_index(k,2) ~= 0)
        plot(Cu_index(k,2),Cu_index(k,1),'go');hold on;
        hold on; plot([Cu_index(k,2) Ox_index(k,2)],[Cu_index(k,1) Ox_index(k,1)],'r');
        hold on; plot([Cu_index(k,2) Oy_index(k,2)],[Cu_index(k,1) Oy_index(k,1)],'b');
    end
 end
hold on; plot (Ox_index(:,2),Ox_index(:,1),'rx'); hold on; plot(Oy_index(:,2),Oy_index(:,1),'b.'); axis equal
%% Extract intensities at sites

INR1 = zeros(360,360,56);

for i = 1:size(Cu_index,1)
    if (Oy_index(i,1) ~= 0 && Oy_index(i,2) ~= 0 && Ox_index(i,1) ~= 0 && Ox_index(i,2) ~= 0)
        for n = 1:56
            INR1(Cu_index(i,1),Cu_index(i,2),n) =...
                (abs(I_cor2.map(Ox_index(i,1),Ox_index(i,2),n)) - abs(I_cor2.map(Oy_index(i,1),Oy_index(i,2),n)))/...
                sqrt((I_cor2.map(Ox_index(i,1),Ox_index(i,2),n))^2 + (I_cor2.map(Oy_index(i,1),Oy_index(i,2),n))^2);
        end
        
    end
end
img_plot2(INR1(:,:,21),Cmap.PurBlaCop,'INR positive');
%% correlation of opposite polarity INR layers
cor_trace2 = zeros(1,36);
INR_data = INR2.map;
for i = 1:36
    cor_trace2(i) = ncorr2(INR_data(:,:,i),INR_data(:,:,end-i+1));
end
figure; plot((I_disp.e(1:36))*1000,cor_trace2);
%% INR value at each layers
INR_tot = squeeze(sum(sum(INR2.map(:,:,:))));
figure; plot(INR2.e*1000,INR_tot);


        