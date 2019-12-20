%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION:
%
% ALGORITHM: 
%
% CODE HISTORY
%
% 111018 MHH Created
function tmp = MNR_combinatoric(data,px_avg,comb_num,varargin)
Cu_index = data.Cu_index;
Ox_index1 = data.Ox_index1;
Ox_index2 = data.Ox_index2;
Oy_index1 = data.Oy_index1;
Oy_index2 = data.Oy_index2;

[nr nc nz] = size(data.map);
new_data = data;
new_data.map = zeros(nr,nc,nz);
map = data.map;
new_map = new_data.map;

exclude = 0;

if ~isempty(varargin)
    exclude = str2double(varargin{1});
end
exclude
m = px_avg;
if m > 1
    m = 1;
end
chk_sum = (2*m+1)^2;
count = 0;
count2 = 0;
h = waitbar(0,'Please wait...','Name','Nematic Analysis in Progress');
for n = 1:nz   
    layer = squeeze(map(:,:,n));
    normalization = 0;      
    for i = 48  %1:size(Cu_index,1)
        Ox_11 = Ox_index1(i,1); Ox_12 = Ox_index1(i,2); %(row,column) of Ox1
        Ox_21 = Ox_index2(i,1); Ox_22 = Ox_index2(i,2);
        Oy_11 = Oy_index1(i,1); Oy_12 = Oy_index1(i,2);
        Oy_21 = Oy_index2(i,1); Oy_22 = Oy_index2(i,2);
        Cu_1 = Cu_index(i,1); Cu_2 = Cu_index(i,2);
        
        if (Ox_11~=0 && Ox_21 ~=0 && Oy_11 ~= 0 && Oy_21~=0)
            % if the exclude option is included check that all the appropriate sites fulfill the condition
            % this means checks all pixels which would be involved in the
            % averaging;
            %count2 = count2 + 1
            count = count + 1;
            
            if (~isnan(exclude) &&...                        
              sum(sum(layer(Cu_1 -m:Cu_1 +m,Cu_2 -m:Cu_2 +m)~=exclude)) == chk_sum &&... 
              sum(sum(layer(Ox_11-m:Ox_11+m,Ox_12-m:Ox_12+m)~=exclude)) == chk_sum &&...
              sum(sum(layer(Ox_21-m:Ox_21+m,Ox_22-m:Ox_22+m)~=exclude)) == chk_sum &&...
              sum(sum(layer(Oy_11-m:Oy_11+m,Oy_12-m:Oy_12+m)~=exclude)) == chk_sum &&...
              sum(sum(layer(Oy_21-m:Oy_21+m,Oy_22-m:Oy_22+m)~=exclude)) == chk_sum)
              
                % indices of blocks around each of the Cu and O atoms
                %Cu_block  =  layer(Cu_1-1:Cu_1+1,Cu_2-1:Cu_2+1)          %A
                [Cu_blk1 Cu_blk2] = meshgrid(Cu_1-1:Cu_1+1,Cu_2-1:Cu_2+1);
                
                %Ox1_block =  layer(Ox_11-1:Ox_11+1,Ox_12-1:Ox_12+1); %B
                [Ox1_blk1 Ox1_blk2] = meshgrid(Ox_11-1:Ox_11+1,Ox_12-1:Ox_12+1);
                
                %Ox2_block =  layer(Ox_21-1:Ox_21+1,Ox_22-1:Ox_22+1); %C
                [Ox2_blk1 Ox2_blk2] = meshgrid(Ox_21-1:Ox_21+1,Ox_22-1:Ox_22+1);
                
                %Oy1_block =  layer(Oy_11-1:Oy_11+1,Oy_12-1:Oy_12+1); %D
                [Oy1_blk1 Oy1_blk2] = meshgrid(Oy_11-1:Oy_11+1,Oy_12-1:Oy_12+1);
                
                %Oy2_block =  layer(Oy_21-1:Oy_21+1,Oy_22-1:Oy_22+1); %E
                [Oy2_blk1 Oy2_blk2] = meshgrid(Oy_21-1:Oy_21+1,Oy_22-1:Oy_22+1);

                for A = 1:9
                    for B = 1:9
                        for C = 1:9
                            for D = 1:9
                                for E = 1:9
                                    count = count + 1
                                    tmp(count,2) = calc_MNR(layer,Ox1_blk1(A),Ox1_blk2(A),...
                                        Ox2_blk1(B),Ox2_blk2(B),Oy1_blk1(C),Oy1_blk2(C),...
                                        Oy2_blk1(D),Oy2_blk2(D),Cu_blk1(E),Cu_blk2(E),0);                                                                          
                                end
                            end
                        end
                    end
                end
                
                %new_map(Cu_1,Cu_2,n) = calc_MNR(layer,Ox_11,Ox_12,Ox_21,Ox_22,...
                 %                                     Oy_11,Oy_12, Oy_21,Oy_22,...
                  %                                    Cu_1,Cu_2,m);
                  
                  calc_MNR(layer,Ox_11,Ox_12,Ox_21,Ox_22,...
                                                      Oy_11,Oy_12, Oy_21,Oy_22,...
                                                     Cu_1,Cu_2,m)
            figure; plot(tmp(:,2),'x');       
            elseif (isnan(exclude))
                display('here');                                              
                new_map(Cu_1,Cu_2,n) = calc_MNR(layer,Ox_11,Ox_12,Ox_21,Ox_22,...
                                                      Oy_11,Oy_12,Oy_21,Oy_22,...
                                                      Cu_1,Cu_2,m);
            end
        end            
    end        
    
    %new_data.map(:,:,n) = new_data.map(:,:,n)/sqrt(normalization);
    waitbar(n / nz,h,[num2str(n/nz*100) '%']);
end
close(h);
new_data.map = new_map;
new_data.ave = [];
OPvsE = zeros(nz,1);
for i=1:size(Cu_index,1)
    OPvsE = OPvsE + squeeze(squeeze(new_data.map(Cu_index(i,1),Cu_index(i,2))));
end    
new_data.OPvsE = OPvsE;
new_data.type = 3;
new_data.var =  [new_data.var(1) '_MNR_lnorm'];
new_data.ops{end+1} = ['MNR order parameter map with ' num2str(m) ' pixel average radius with local normalization'];
end
function new_map_val = calc_MNR(lyr,Ox_11,Ox_12,Ox_21,Ox_22,Oy_11,Oy_12,Oy_21,Oy_22,Cu_1,Cu_2,m)
    %average over Cu site's two associated Oxygen-x sites
    Ix = (mean(mean(lyr(Ox_11-m:Ox_11+m,Ox_12-m:Ox_12+m))) +...
        mean(mean(lyr(Ox_21-m:Ox_21+m, Ox_22-m:Ox_22+m))))/2 ;
    %average over Cu site's two associated Oxygen-y sites
    Iy = (mean(mean(lyr(Oy_11-m:Oy_11+m, Oy_12-m:Oy_12+m))) +...
        mean(mean(lyr(Oy_21-m:Oy_21+m,Oy_22-m:Oy_22+m))))/2 ;                       

    % for normalization also add up all weight on the Cu sites
    ICu = mean(mean(lyr(Cu_1-m:Cu_1+m,Cu_2-m:Cu_2+m)));

    normalization = (abs(Ix) + abs(Iy)) + abs(ICu); %add up intensities at all O sites                               
    new_map_val= (abs(Ix) - abs(Iy))/normalization;
end
% function mnr_val = calc_MNR2(Ox1_val,Ox2_val,Oy1_val,Oy2_val,Cu_val)
%     Ix = 
%     (mean(mean(lyr(Ox_11-m:Ox_11+m,Ox_12-m:Ox_12+m))) +...
%         mean(mean(lyr(Ox_21-m:Ox_21+m, Ox_22-m:Ox_22+m))))/2 ;
%     %average over Cu site's two associated Oxygen-y sites
%     Iy = (mean(mean(lyr(Oy_11-m:Oy_11+m, Oy_12-m:Oy_12+m))) +...
%         mean(mean(lyr(Oy_21-m:Oy_21+m,Oy_22-m:Oy_22+m))))/2 ;                       
% 
%     % for normalization also add up all weight on the Cu sites
%     ICu = mean(mean(lyr(Cu_1-m:Cu_1+m,Cu_2-m:Cu_2+m)));
% 
%     normalization = (abs(Ix) + abs(Iy)) + abs(ICu); %add up intensities at all O sites                               
%     new_map_val= (abs(Ix) - abs(Iy))/normalization;
% 
% 
% end