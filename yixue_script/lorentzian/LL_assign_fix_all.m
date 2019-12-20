% 2019-6-21 YXC
% given llmap = fitted_to_viewer(map,llmatrix...)
% and specify which layer (of e_array) and pixels (x1,y1),(x2,y2)
% return llmapnew that fixes the wrongly assigned area
% option to add in v

function fixed_llmap = LL_assign_fix_all(llmap,llmatrix,peakmV_array)

[nx,ny,~] = size(llmap.map);
xlist = [1,nx];
ylist = [1,ny];
LL2fix_array = llmap.e*1000;


for i = 1:length(LL2fix_array)
%     peakmV_array
    fixed_llmap = LL_assign_fix(llmap,llmatrix,peakmV_array,LL2fix_array(i),xlist,ylist);
end

end

