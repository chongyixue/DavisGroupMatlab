%%%%%%%
% CODE DESCRIPTION: Given 3 boolean matrices marking the positions of the
%                   Cu, Ox, and Oy atomic locations, this program 
%                   1) finds their indices in 5 separate arrays (Cu,
%                   Ox1,Ox2,Oy1,Oy2)
%                   2) so that the arrays are ordered so that for each Cu atoms the
%                   four closest O atoms are indexed on the same row
%                   3) Ox1 and Ox2 give indices for Ox atoms above and
%                   below of the respective Cu atoms.  Equivalent for
%                   Oy1 and Oy2.
%
% 
%
% INPUT: 3 boolean matrices Cu, Ox, Oy giving positions of atomic sites
%
% OUTPUT: Cu_index, Ox_index1, Ox_index2, Oy_index1, Oy_index2, giving the
% indices of the Cu sites and the corresponding Ox and Oy sites to the left
% and right of the Cu sites.
%
% CODE HISTORY
%
% 131202 MHH  - Created (modified from scripts)
%%%%%%%%
function [Cu_index Ox_index1 Ox_index2 Oy_index1 Oy_index2] = BSCCO_Cu_O_index(Cu,Ox,Oy,varargin)
Ox_ind = Ox*2;
Oy_ind = Oy*3;
Cu_Ox = Cu + Ox_ind;
Cu_Oy = Cu + Oy_ind;
[Cu_index(:,1) Cu_index(:,2)] = find(Cu == 1);
figure; plot(Cu_index(:,2),Cu_index(:,1),'rx');

% Ox sites to the below of Cu site
Ox_index1 = zeros(size(Cu_index,1),2);
[nr nc] = size(Cu_Ox);
for i = 1:size(Cu_index,1);
    for n = 1:4               
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)<= 4 || Cu_index(i,2) >= nc-4 )
            break;
        elseif (sum(sum(Cu_Ox(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2):Cu_index(i,2)+n))) > 1)            
            [r_tmp c_tmp] = find(Cu_Ox(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2):Cu_index(i,2)+n) == 2);
            Ox_index1(i,1) = (Cu_index(i,1) - n +r_tmp - 1);
            Ox_index1(i,2) = (Cu_index(i,2) + c_tmp - 1);
            break;
        end
    end
end
clear r_tmp c_tmp i n nr nc

% Ox sites to the above of Cu site
Ox_index2 = zeros(size(Cu_index,1),2);
[nr nc] = size(Cu_Ox);
for i = 1:size(Cu_index,1)
    for n = 1:4                       
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)>= nr-4 || Cu_index(i,2) <= 4)
            break;
        elseif (sum(sum(Cu_Ox(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2):-1:Cu_index(i,2)-n))) > 1)            
            [r_tmp c_tmp] = find(Cu_Ox(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2)-n:Cu_index(i,2)) == 2);
            Ox_index2(i,1) = (Cu_index(i,1)+r_tmp - 1);
            Ox_index2(i,2) = (Cu_index(i,2)-n +c_tmp - 1);
            break;
        end
    end
end
clear r_tmp c_tmp i n nr nc

% Oy sites to the above of Cu site
Oy_index1 = zeros(size(Cu_index,1),2);
[nr nc] = size(Cu_Oy);
for i = 1:size(Cu_index,1)    
    for n = 1:4       
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)>= nr-4 || Cu_index(i,2) >= nc-4)
            break;
        elseif (sum(sum(Cu_Oy(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2):Cu_index(i,2)+n))) > 1)
            [r_tmp c_tmp] = find(Cu_Oy(Cu_index(i,1):Cu_index(i,1)+n,Cu_index(i,2):Cu_index(i,2)+n) == 3);
            Oy_index1(i,1) = (Cu_index(i,1)+r_tmp - 1);
            Oy_index1(i,2) = (Cu_index(i,2)+c_tmp - 1);
            break;
        end
    end
end
clear r_tmp c_tmp i n nr nc

% Oy sites to the below of Cu site
Oy_index2 = zeros(size(Cu_index,1),2);
for i = 1:size(Cu_index,1)        
    for n = 1:4              
        r_tmp = 0; c_tmp = 0;
        if (Cu_index(i,1)<= 4 || Cu_index(i,2) <= 4)
            break;
        elseif (sum(sum(Cu_Oy(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2)-n:Cu_index(i,2)))) > 1)
            [r_tmp c_tmp] = find(Cu_Oy(Cu_index(i,1)-n:Cu_index(i,1),Cu_index(i,2)-n:Cu_index(i,2)) == 3);
            Oy_index2(i,1) = (Cu_index(i,1)+r_tmp - n - 1);
            Oy_index2(i,2) = (Cu_index(i,2)+c_tmp - n - 1);
            break;
        end
    end
end

if nargin > 3
    img_r = varargin{1}; %real space coordinates - not pixel coordinates
    for i = 1:size(Cu_index,1)
        % also record the r-coordinate values of the Cu/Ox/Oy sites
        Cu_index(i,3) = img_r(Cu_index(i,1)); 
        Cu_index(i,4) = img_r(Cu_index(i,2)); 
        
        Ox_index1(i,3) = img_r(Ox_index1(i,1)); 
        Ox_index1(i,4) = img_r(Ox_index1(i,2)); 
        Ox_index2(i,3) = img_r(Ox_index2(i,1)); 
        Ox_index2(i,4) = img_r(Ox_index2(i,2)); 
        
        Oy_index1(i,3) = img_r(Oy_index1(i,1)); 
        Oy_index1(i,4) = img_r(Oy_index1(i,2)); 
        Oy_index2(i,3) = img_r(Oy_index2(i,1)); 
        Oy_index2(i,4) = img_r(Oy_index2(i,2));   
    end
end

hold on; plot(Ox_index1(:,2),Ox_index1(:,1),'bo'); axis equal;
hold on; plot(Ox_index2(:,2),Ox_index2(:,1),'g+'); axis equal;

hold on; plot(Oy_index2(:,2),Oy_index2(:,1),'gx'); axis equal;
hold on; plot(Oy_index1(:,2),Oy_index1(:,1),'go'); axis equal;

figure; 
 for k = 1:size(Cu_index,1)
    if (Oy_index2(k,1) ~= 0 && Oy_index2(k,2) ~= 0 && Ox_index2(k,1) ~= 0 && Ox_index2(k,2) ~= 0)
        plot(Cu_index(k,2),Cu_index(k,1),'go');hold on;
        hold on; plot([Cu_index(k,2) Ox_index2(k,2)],[Cu_index(k,1) Ox_index2(k,1)],'r');
        hold on; plot([Cu_index(k,2) Oy_index2(k,2)],[Cu_index(k,1) Oy_index2(k,1)],'b');
    end
 end
hold on; plot (Ox_index2(:,2),Ox_index2(:,1),'rx'); hold on; plot(Oy_index2(:,2),Oy_index2(:,1),'b.'); axis equal

end