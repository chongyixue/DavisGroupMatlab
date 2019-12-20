% 2019-2-26
% ED_map 
clear map; clear LLmap;clear x; clear y;
map = invert_map(obj_90306a00_G);
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
        LLmap.map(y,x,5) = zero;
        LLmap.map(y,x,6) = one;
        LLmap.map(y,x,7) = LL_energy(matching_index(LL_index,2));
        LLmap.map(y,x,8) = LL_energy(matching_index(LL_index,3));
        LLmap.map(y,x,9) = LL_energy(matching_index(LL_index,-1));
        LLmap.map(y,x,10) = LL_energy(matching_index(LL_index,-2));
    end
end
LLmap.e(5) = 0;
LLmap.e(6) = 0.001;
LLmap.e(7) = 0.002;
LLmap.e(8) = 0.003;
LLmap.e(9) = -0.001;
LLmap.e(10) = -0.002;

img_obj_viewer_yxc(LLmap)


EDmap_val = reshape(LLmap.map(:,:,1),nx*ny,1);
% histograms

histogram(EDmap_val,2000);
hold on
xlim([130,151])
title('$E_D$ histogram','Interpreter','latex')
xlabel('$$E_D$$(mV)','Interpreter','latex')

gap_val = reshape(LLmap.map(:,:,4),nx*ny,1);
histogram(gap_val,2000);
hold on
xlim([-2,1])
title('"Gap" histogram')
xlabel('gap (mV)')


zero = reshape(LLmap.map(:,:,5),nx*ny,1);
histogram(zero,500);
hold on
xlim([130,150])
title('0LL histogram')
xlabel('E (mV)')
hold off

one = reshape(LLmap.map(:,:,6),nx*ny,1);
histogram(one,500);
hold on
xlim([172,190])
title('1LL histogram')
xlabel('E (mV)')
hold off

two = reshape(LLmap.map(:,:,7),nx*ny,1);
histogram(two,500);
hold on
xlim([190,210])
title('2LL histogram')
xlabel('E (mV)')

three = reshape(LLmap.map(:,:,8),nx*ny,1);
histogram(three,100);
hold on
xlim([208,230])
title('3LL histogram')
xlabel('E (mV)')
hold off

%most data does not have -1 and -2
% minusone = reshape(LLmap.map(:,:,9),nx*ny,1);
% histogram(minusone,500);
% hold on
% title('-1 LL histogram')
% xlabel('E (mV)')
% hold off
% 
% minustwo = reshape(LLmap.map(:,:,10),nx*ny,1);
% histogram(minustwo,500);
% hold on
% title('-2 LL histogram')
% xlabel('E (mV)')
% hold off

% [c,d] = hist(EDmap_val,2000);
% figure,
% plot(b+172,a,'b');

function index = matching_index(list,value)
[~,index] = min(abs(list-value));
end
