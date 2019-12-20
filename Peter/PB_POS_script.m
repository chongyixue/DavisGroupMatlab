%% load all sheets from the excel file
[pbnum1,pbtxt1,pbraw1] = xlsread('C:\Users\pspra\Downloads\BasuResearchMasterVersionC.xlsx', 1);
[pbnum2,pbtxt2,pbraw2] = xlsread('C:\Users\pspra\Downloads\BasuResearchMasterVersionC.xlsx', 2);
[pbnum3,pbtxt3,pbraw3] = xlsread('C:\Users\pspra\Downloads\BasuResearchMasterVersionC.xlsx', 3);

%% combine all 3 sheets into one cell for the complete structure and one matrix for the numeric values
[nx, ny] = size(pbnum1);

pbproc = pbraw1(1,:);
cc = 2;
for i=1:nx
    if ~isnan(pbnum1(i, 1))
        pbproc(cc,:) = pbraw1(i+1,:);
        pbnum(cc-1, :) = pbnum1(i, :);
        cc = cc+1;
    end
end

[nx, ny] = size(pbnum2);

for i=1:nx
    if ~isnan(pbnum2(i, 1))
        pbproc(cc,:) = pbraw2(i+1,:);
        pbnum(cc-1, :) = pbnum2(i, :);
        cc = cc+1;
    end
end

[nx, ny] = size(pbnum3);

for i=1:nx
    if ~isnan(pbnum3(i, 1))
        pbproc(cc,:) = pbraw3(i+1,:);
        pbnum(cc-1, :) = pbnum3(i, :);
        cc = cc+1;
    end
end

pbprocv2 = pbproc;

[nx, ny] = size(pbproc);

pbproc{1, ny+1} = 'Immunosuppressed';
pbproc{1, ny+2} = '# im. sup.';
pbproc{1, ny+3} = '# im. sup. w. compl.';
pbproc{1, ny+4} = '# im. sup. w/o compl.';

pbproc{1, ny+5} = '# im. comp.';
pbproc{1, ny+6} = '# im. comp. w. compl.';
pbproc{1, ny+7} = '# im. comp. w/o compl.';

imsupc = 0;
imsupcwc = 0;
imsupcwoc = 0;

imcompc = 0;
imcompcwc = 0;
imcompcwoc = 0;

for i=2:nx
    if strcmp(pbproc{i, 23}, 'No') && strcmp(pbproc{i, 24}, 'None')...
            && strcmp(pbproc{i, 25}, 'No') && strcmp(pbproc{i, 26}, 'None')
        pbproc{i, ny+1} = 'No';
        imcompc = imcompc + 1;
        
        if strcmp(pbproc{i, 27}, 'None')
            imcompcwoc = imcompcwoc+1;
        else
            imcompcwc = imcompcwc+1;
        end
        
    else
        pbproc{i, ny+1} = 'Yes';
        imsupc = imsupc +1;
        
        if strcmp(pbproc{i, 27}, 'None')
            imsupcwoc = imsupcwoc+1;
        else
            imsupcwc = imsupcwc+1;
        end
        
    end
    pbproc{i, ny+2} = imsupc;
    pbproc{i, ny+3} = imsupcwc;
    pbproc{i, ny+4} = imsupcwoc;
    
    pbproc{i, ny+5} = imcompc;
    pbproc{i, ny+6} = imcompcwc;
    pbproc{i, ny+7} = imcompcwoc;
end

xlswrite('C:\Users\pspra\Downloads\BasuResearchMasterVersionB_no_correction_for_immunechange.xlsx',pbproc,1);
%% instead of yes and no assign 1 and 0 for the new column immunosuppressed

[nx, ny] = size(pbprocv2);

pbprocv2{1, ny+1} = 'Immunosuppressed';

imsupc = 0;
imsupcwc = 0;
imsupcwoc = 0;

imcompc = 0;
imcompcwc = 0;
imcompcwoc = 0;

for i=2:nx
    if strcmp(pbprocv2{i, 23}, 'No') && strcmp(pbprocv2{i, 24}, 'None')...
            && strcmp(pbprocv2{i, 25}, 'No') && strcmp(pbprocv2{i, 26}, 'None')
        pbprocv2{i, ny+1} = 0;

    else
        pbprocv2{i, ny+1} = 1;

    end
    
end

%% next we need to search the data for patients who changed from immunocompetent to immunosuppressed

pbnumv2 = pbnum;

[nx, ny] = size(pbnum);

for i=1 : nx-1
    if ~isnan(pbnum(i, 1))
        I = find(pbnum(i+1:end, 1) == pbnum(i,1));
        dicell{i, 1} = [i+1; I+i+1];
        if isempty(I)
            pbnum(i,1) = nan;
        else 
            pbnum(i,1) = nan;
            pbnum(I+i,1) = nan;
            %%%%%%%% stopped here - need to think about indexing
            decdum = 0;
            dum0 = [i+1; I+i+1];
            for k=1:length(dum0)
                decdum = decdum + pbprocv2{dum0(k), 28}; 
            end
            if decdum > 0 && decdum < length(dum0)
                
                for k=1:length(dum0)
                    if pbprocv2{dum0(k), 28} == 0
                        pbnumv2(dum0(k)-1, 1) = nan;
                    end
                end
            
            end
            dicell{i, 2} = decdum;
            test = 1;
        end
    end
    clear I;
    clear decdum;
end


% dummy0 = pbproc1(2:end, 3);
% dummy0 = cell2mat(dummy0);
% [dum1, dum1ind] = sort(dummy0);
%%

[nx, ny] = size(pbnumv2);

pbprocv3 = pbprocv2(1,:);
pbprocv4 = pbprocv2(1,:);
pbprocv4{1, end+1} = 'former row position';

cc = 2;
cc2 = 2;
for i=1:nx
    if ~isnan(pbnumv2(i, 1))
        pbprocv3(cc,:) = pbprocv2(i+1,:);
        pbnumv3(cc-1, :) = pbnumv2(i, :);
        cc = cc+1;
    else
        pbprocv4(cc2,1:end-1) = pbprocv2(i+1,:);
        pbprocv4{cc2, end} = i+1;
        cc2 = cc2+1;
    end
end



xlswrite('C:\Users\pspra\Downloads\BasuResearchMasterVersionB_discarded_cases.xlsx',pbprocv4,1);


%%

[nx, ny] = size(pbprocv3);

pbprocv3{1, ny+1} = 'Immunosuppressed Y/N';
pbprocv3{1, ny+2} = '# im. sup.';
pbprocv3{1, ny+3} = '# im. sup. w. compl.';
pbprocv3{1, ny+4} = '# im. sup. w/o compl.';

pbprocv3{1, ny+5} = '# im. comp.';
pbprocv3{1, ny+6} = '# im. comp. w. compl.';
pbprocv3{1, ny+7} = '# im. comp. w/o compl.';

imsupc = 0;
imsupcwc = 0;
imsupcwoc = 0;

imcompc = 0;
imcompcwc = 0;
imcompcwoc = 0;

for i=2:nx
    if strcmp(pbprocv3{i, 23}, 'No') && strcmp(pbprocv3{i, 24}, 'None')...
            && strcmp(pbprocv3{i, 25}, 'No') && strcmp(pbprocv3{i, 26}, 'None')
        pbprocv3{i, ny+1} = 'No';
        imcompc = imcompc + 1;
        
        if strcmp(pbprocv3{i, 27}, 'None')
            imcompcwoc = imcompcwoc+1;
        else
            imcompcwc = imcompcwc+1;
        end
        
    else
        pbprocv3{i, ny+1} = 'Yes';
        imsupc = imsupc +1;
        
        if strcmp(pbprocv3{i, 27}, 'None')
            imsupcwoc = imsupcwoc+1;
        else
            imsupcwc = imsupcwc+1;
        end
        
    end
    pbprocv3{i, ny+2} = imsupc;
    pbprocv3{i, ny+3} = imsupcwc;
    pbprocv3{i, ny+4} = imsupcwoc;
    
    pbprocv3{i, ny+5} = imcompc;
    pbprocv3{i, ny+6} = imcompcwc;
    pbprocv3{i, ny+7} = imcompcwoc;
end

xlswrite('C:\Users\pspra\Downloads\BasuResearchMasterVersionB_with_correction_for_immunechange.xlsx',pbprocv3,1);


%%

[nx, ny] = size(pbprocv3);
pbprocv5 = pbprocv3(1,:);
pbprocv6 = pbprocv3(1,:);

cc = 2;
cc2 = 2;
for i=2:nx
    
        if strcmp(pbprocv3{i, 27}, 'None')
        else
            if pbprocv3{i, 28}==1
                pbprocv5(cc,:) = pbprocv3(i,:);
                cc = cc+1;
            else
                pbprocv6(cc2,:) = pbprocv3(i,:);
                cc2 = cc2+1;
            end
        end
    
    
end

xlswrite('C:\Users\pspra\Downloads\BasuResearchMasterVersionB_immunosuppressed_with_complications.xlsx',pbprocv5,1);

xlswrite('C:\Users\pspra\Downloads\BasuResearchMasterVersionB_immunocompetent_with_complications.xlsx',pbprocv6,1);

