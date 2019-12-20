% 2019-2-26
% ED_map 
clear map; clear LLmap;clear x; clear y;
% map = invert_map(obj_90407a00_G);
map = obj_90407a00_G;
map = subtract_background(map);

[nx,ny,nz] = size(map.map);

LLmap = map;
LLmap.name = 'LLmap2';

for x = 1:nx
    for y = 1:ny
        [LLmap.map(y,x,1), LLmap.map(y,x,2),LL_index,LL_energy] = extract_ED(map,x,y,'noplot');
        index = matching_index(LL_index,0);
        zero = LL_energy(index);
        index = matching_index(LL_index,1);
        one = LL_energy(index);
        LLmap.map(y,x,3) = one-zero;
        %"mass" below
        LLmap.map(y,x,4) = LLmap.map(y,x,1)-zero;
    end
end
img_obj_viewer_yxc(LLmap)


EDmap_val = reshape(LLmap.map(:,:,1),nx*ny,1);
% histograms

histogram(EDmap_val,2000);
hold on
xlim([130,151])
title('$E_D$ histogram','Interpreter','latex')
xlabel('$$E_D$$(mV)','Interpreter','latex')


% [c,d] = hist(EDmap_val,2000);
% figure,
% plot(b+172,a,'b');

function index = matching_index(list,value)
[~,index] = min(abs(list-value));
end
