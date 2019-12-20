function newmap = fitted_to_viewer(map,llmatrix,background,e_array,name,peakarraymV)

method = background + 1;
ll = map;
ll.name = name;
ll.e = e_array;
ll.map = ll.map(:,:,1:length(e_array));
[nx,ny,nz] = size(ll.map);

ll.method = method;

[~,~,~,levels] = size(llmatrix);
llshifted = zeros(nx,ny,levels);


for x = 1:nx
    for y = 1:ny
        [shifted,~] = shift_peak_assignment(llmatrix,method,x,y,peakarraymV);
        llshifted(x,y,:) = shifted;
    end
end

%find offset from peakarraymV
[~,ind]=max(peakarraymV~=0);
offset = ind-1;

% average = mean(mean(llshifted,1));
% average = squeeze(squeeze(average));
% 
% 
% % prevent some values that are not assigned from being hijacked by zeros.
% checker = (abs(average-peakarraymV')<6);
% average = checker.*average + (1-checker).*peakarraymV';    

average = compared_average(llmatrix,method,peakarraymV,5);


% average
for k = 1:11
    div = 10;
    for level = offset+1:length(e_array)+offset
        if level>1
            div = (average(level)-average(level-1))/2;
        end
        for x = 1:nx
            for y = 1:ny
                if abs(llshifted(x,y,level)-average(level))>div
                    lsst = llmatrix(method,x,y,:);
                    %                 size(list)
                    [~,index] = min(abs(lsst-average(level)));
                    llshifted(x,y,level) = lsst(index);
                end

                if abs(llshifted(x,y,level)-average(level))>div
                    llshifted(x,y,level) = 0;
                end
            end
        end
    end
    average = compared_average(llmatrix,method,peakarraymV,4);
%     average = mean(mean(llshifted,1));
%     average = squeeze(squeeze(average));
%     checker = (abs(average-peakarraymV'))<3;
%     average = checker.*average + (1-checker).*peakarraymV';   

end

% for x = 1:nx
%     for y = 1:ny
%         


% initial_row_peakarray = peakarraymV;
% for x = 1:nx
%     peakarraymV = initial_row_peakarray;
%     for y = 1:ny
%         if y ~= 1
%             peakarraymV = temp_peakarray;
%         else
%             peakarraymV = initial_row_peakarray;
%         end
%         [shifted,~] = shift_peak_assignment(llmatrix,method,x,y,peakarraymV);
%         llshifted(x,y,:) = shifted;
%         temp_peakarray = modifypeakarray(peakarraymV,shifted);
%         if y == ny
%             initial_row_peakarray = temp_peakarray;
%         end
%     end
% end





for lay = 1:nz
    temp  = llshifted(:,:,lay+offset);
    ll.map(:,:,lay) = temp';
%     ll.map(:,:,lay) = llshifted(:,:,lay+offset)';
end

newmap = ll;

end



function newpeakarray = modifypeakarray(peakarraymV,shifted)
%filter = 1 at relevant peak indices
shifted = shifted';
filter_update = (shifted.*peakarraymV)~=0;
% newvalues = filter_update.*(shifted+peakarraymV)/2;
newvalues = filter_update.*(shifted);
oldvalues = (1-filter_update).*peakarraymV;
newpeakarray = newvalues + oldvalues;
end

function avg = compared_average(llmatrix,method,peakarraymV,div)
valid = squeeze(llmatrix(method,:,:,:));
siz = size(valid);
compare = zeros(siz)+1;
for k = 1:length(peakarraymV)
    compare(:,:,k) = peakarraymV(k);
end
val = abs(valid-compare) < div;
sum_valid = squeeze(sum(sum(val,1)));
% avg = peakarraymV;
sum_array = squeeze(sum(sum(valid.*val,1)));
avg = sum_array./sum_valid;

end
