%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE DESCRIPTION:
%
% ALGORITHM: 
%
% CODE HISTORY
%
% 111018 MHH Created
function new_data = MNR_combinatoric(data,px_avg,comb_num,varargin)
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
    for i = 1:size(Cu_index,1)
        if (Ox_index1(i,1)~=0 && Ox_index2(i,1) ~=0 && Oy_index1(i,1) ~= 0 && Oy_index2(i,1)~=0)
            % if the exclude option is included check that all the appropriate sites fulfill the condition
            % this means checks all pixels which would be involved in the
            % averaging;
            %count2 = count2 + 1
            if (~isnan(exclude) &&...                        
              sum(sum(layer(Cu_index(i,1) -m:Cu_index(i,1) +m,Cu_index(i,2) -m:Cu_index(i,2) +m)~=exclude)) == chk_sum &&... 
              sum(sum(layer(Ox_index1(i,1)-m:Ox_index1(i,1)+m,Ox_index1(i,2)-m:Ox_index1(i,2)+m)~=exclude)) == chk_sum &&...
              sum(sum(layer(Ox_index2(i,1)-m:Ox_index2(i,1)+m,Ox_index2(i,2)-m:Ox_index2(i,2)+m)~=exclude)) == chk_sum &&...
              sum(sum(layer(Oy_index1(i,1)-m:Oy_index1(i,1)+m,Oy_index1(i,2)-m:Oy_index1(i,2)+m)~=exclude)) == chk_sum &&...
              sum(sum(layer(Oy_index2(i,1)-m:Oy_index2(i,1)+m,Oy_index2(i,2)-m:Oy_index2(i,2)+m)~=exclude)) == chk_sum)
                         
                new_map(Cu_index(i,1),Cu_index(i,2),n) =...
                     calc_MNR(layer,Ox_index1(i,1),Ox_index1(i,2),...
                                 Ox_index2(i,1),Ox_index2(i,2),...
                                 Oy_index1(i,1),Oy_index1(i,2),...
                                 Oy_index2(i,1),Oy_index2(i,2),...
                                 Cu_index(i,1),Cu_index(i,2),m);
                   
            elseif (isnan(exclude))
                display('here');                                              
                new_map(Cu_index(i,1),Cu_index(i,2),n) =...
                    calc_MNR(layer,Ox_index1(i,1),Ox_index1(i,2),...
                                 Ox_index2(i,1),Ox_index2(i,2),...
                                 Oy_index1(i,1),Oy_index1(i,2),...
                                 Oy_index2(i,1),Oy_index2(i,2),...
                                 Cu_index(i,1),Cu_index(i,2),m);
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