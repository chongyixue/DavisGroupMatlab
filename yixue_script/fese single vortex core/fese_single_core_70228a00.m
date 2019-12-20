% 2019-5-30 YXC 
% 70228a00 FeSe single vortex core
% first crop 1,1 to 60,60 such that 30.5,30.5 = center


map = map_60pix;
%shift energy to 0.08mV lower
map.e = map.e - 0.08*0.001;
map = extract_layers(map,-2,2,'noplot');

%img_obj_viewer_test(map);

map2 = map;
%now we want to do away with the line of tip change
diffmap = map;
temp = diffmap.map;
temp2 = temp;
temp2(1,:,:) = temp(1,:,:);
temp2(2:end,:,:) = temp(1:end-1,:,:);
temp3 = temp2-temp;
diffmap.map = temp3;
%img_obj_viewer_test(diffmap)

map2.map(15,31,:) = (map2.map(15,30,:)+map2.map(15,32,:)+map2.map(16,31,:)+map2.map(14,31,:))/4;
map2.map(52,34,:) = (map2.map(51,34,:)+map2.map(53,34,:)+map2.map(52,33,:)+map2.map(52,35,:))/4;
for layer = 39:51
    map2.map(:,:,layer) = changeline(map2.map(:,:,layer),34,60,52);
end

for layer = 1:51
    map2.map(:,:,layer) = changebelow(map2.map(:,:,layer),1,60,53);
    map2.map(:,:,layer) = average_whole_line(map2.map(:,:,layer),52);
end


img_obj_viewer_test(map2)


%val = average_line(map2.map(:,:,1),3,5,1)

%this is when tip changed only for a line and revert back to previous settings
function mat2 = changeline(mat,pixx_start,pixx_end,pixy)
average = 0.5*(average_line(mat,pixx_start,pixx_end,pixy-1)+average_line(mat,pixx_start,pixx_end,pixy+1));
average_self = average_line(mat,pixx_start,pixx_end,pixy);
diff = average_self-average;
mat2 = mat;
mat2(pixy,pixx_start:pixx_end) = mat2(pixy,pixx_start:pixx_end)-diff;
end

%this is when the tip changed in a line and kept the changes
function mat2 = changebelow(mat,pixx_start,pixx_end,pixy)
average = average_line(mat,pixx_start,pixx_end,pixy-1);
average_self = average_line(mat,pixx_start,pixx_end,pixy);
average_below = average_line(mat,pixx_start,pixx_end,pixy+1);
above2 = average_line(mat,pixx_start,pixx_end,pixy-2);
below2 = average_line(mat,pixx_start,pixx_end,pixy+2);
expecteddiff = 0.5*(average_below+above2-average_self-below2);
diff = average_self-average;
truediff = diff-expecteddiff;
mat2 = mat;
mat2(pixy:end,pixx_start:pixx_end) = mat2(pixy:end,pixx_start:pixx_end)-truediff;
end


function mat2 = average_whole_line(mat,pixy)
above = mat(pixy-1,:);
below = mat(pixy+1,:);
mat2 = mat;
mat2(pixy,:) = (above+below)/2;
end

function avglist = running_average_change_line(mat,pixy,npix)
len = size(mat,2);
minn = npix;
maxx = len-npix;
avglist = mat;
for i = 1:len
    if i<minn
        temp = mat(pixy,1:i*2-1);
    elseif i>maxx
        temp = mat(pixy,2*i-len:len);
    else
        temp = mat(pixy,i-npix:i+npix);
    end
    avglist(pixy,i) = mean(temp);
end
end

function val = average_line(mat,pixx_start,pixx_end,pixy)
sub = mat(pixy,pixx_start:pixx_end);
summ = sum(mat(pixy,pixx_start:pixx_end));
val = summ/length(sub);
end