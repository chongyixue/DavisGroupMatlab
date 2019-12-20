%% Finding neighbors to Cu atoms
Ox_ind = Ox*2;
Oy_ind = Oy*3;

Cu_Ox = Cu + Ox_ind;
Cu_Oy = Cu + Oy_ind;
%%
[Cu_index(:,1) Cu_index(:,2)] = find(Cu == 1);
%% Find Oy atoms to left of Cu site
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
%% find Oy atoms on right side of Cu
Oy_index2 = zeros(size(Cu_index,1),2);
for i = 1:size(Cu_index,1);
    for n = 1:5        
        i
        %sum(sum(Cu_Oy(r(i):r(i)+n,c(i):-1:c(i)-n)))
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)<=4 || Cu_index(i,2) >= 360-4 )
            break;
        elseif (sum(sum(Cu_Oy(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2):Cu_index(i,2)+n))) > 1)
            [r_tmp c_tmp] = find(Cu_Oy(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2):Cu_index(i,2)+n) == 3);
            Oy_index2(i,1) = (Cu_index(i,1) - n +r_tmp - 1);
            Oy_index2(i,2) = (Cu_index(i,2) + c_tmp - 1);
            break;
        end
    end
end
%% Find closest Ox on right side of Cu
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
%% find Ox atoms on left side of Cu
Ox_index2 = zeros(size(Cu_index,1),2);
for i = 1:size(Cu_index,1)    
    count = 1;
    for n = 1:5
        
        %sum(sum(Cu_Ox(r(i):r(i)+n,c(i):c(i)+n)))
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)<= 4 || Cu_index(i,2) <= 4)
            break;
        elseif (sum(sum(Cu_Ox(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2)-n:Cu_index(i,2)))) > 1)
            [r_tmp c_tmp] = find(Cu_Ox(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2)-n:Cu_index(i,2)) == 2);
            Ox_index2(i,1) = (Cu_index(i,1)+r_tmp - n - 1);
            Ox_index2(i,2) = (Cu_index(i,2)+c_tmp - n - 1);
            break;
        end
    end
end
%%
k = 1500;
figure; plot(Cu_index(:,2),Cu_index(:,1),'rx');
hold on; plot(Ox_index2(:,2),Ox_index2(:,1),'bo');
hold on; plot(Ox_index(:,2),Ox_index(:,1),'g+');
%hold on; plot(Oy_index2(:,2),Oy_index2(:,1),'gx');
%hold on; plot(Oy_index(:,2),Oy_index(:,1),'ro');

%%
figure;
 for k = 1:size(Cu_index,1)
    if (Oy_index2(k,1) ~= 0 && Oy_index2(k,2) ~= 0 && Ox_index2(k,1) ~= 0 && Ox_index2(k,2) ~= 0)
        plot(Cu_index(k,2),Cu_index(k,1),'go');hold on;
        hold on; plot([Cu_index(k,2) Ox_index2(k,2)],[Cu_index(k,1) Ox_index2(k,1)],'r');
        hold on; plot([Cu_index(k,2) Oy_index2(k,2)],[Cu_index(k,1) Oy_index2(k,1)],'b');
    end
 end
hold on; plot (Ox_index2(:,2),Ox_index2(:,1),'rx'); hold on; plot(Oy_index2(:,2),Oy_index2(:,1),'b.'); axis equal