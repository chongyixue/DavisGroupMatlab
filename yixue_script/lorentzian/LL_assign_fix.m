% 2019-6-21 YXC
% given llmap = fitted_to_viewer(map,llmatrix...)
% and specify which layer (of e_array) and pixels (x1,y1),(x2,y2)
% return llmapnew that fixes the wrongly assigned area
% option to add in v

function fixed_llmap = LL_assign_fix(llmap,llmatrix,targetmV,LL2fix,xlist,ylist)

[sx,sy,~] = size(llmap.map);
if length(xlist)==1
    if xlist(1) == sx
        xlist = [xlist(1),xlist(1)+1];
    else
        xlist = [xlist(1)-1,xlist(1)];
    end
end
if length(ylist)==1
    if ylist(1) == sy
        ylist = [ylist(1),ylist(1)+1];
    else
        ylist = [ylist(1)-1,ylist(1)];
    end
end

method = llmap.method;
fixed_llmap = llmap;
LL2fix_renorm = LL2fix/1000;
[~,layer] = min(abs(llmap.e-LL2fix_renorm));
matrix_tofix = fixed_llmap.map(ylist(1):ylist(end),xlist(1):xlist(end),layer);
% targetmV
if length(targetmV)>1
    peakmV_array = targetmV;
    [~,first_non0] = min(peakmV_array==0);
    relevant_mV = peakmV_array(first_non0:length(llmap.e)+first_non0-1);
    targetmV = relevant_mV(layer);
end


% if method is well defined
if method ~= 5
    
    subset_llmatrix = squeeze(llmatrix(method,ylist(1):ylist(end),xlist(1):xlist(end),:));
    diff = abs(subset_llmatrix-targetmV);
    [~,index] = min(diff,[],3);
    
    [nx,ny,~] = size(subset_llmatrix);
    
    newmatrix = zeros(nx,ny);
    for x = 1:nx
        for y = 1:ny
            newmatrix(x,y) = subset_llmatrix(x,y,index(x,y));
        end
    end
%     newmatrix
    newelementfilter = abs(matrix_tofix-targetmV)> abs(newmatrix-targetmV);
%     sum(sum(newelementfilter))
    matrix_tofix = matrix_tofix.*(1-newelementfilter)+newelementfilter.*(newmatrix);
    fixed_llmap.map(ylist(1):ylist(end),xlist(1):xlist(end),layer) = matrix_tofix;
    
else
    maptofix = llmap;
    
    for mthd = 1:3
        maptofix.method = mthd;
        maptofix = LL_assign_fix(maptofix,llmatrix,targetmV,LL2fix,xlist,ylist);
    end
    fixed_llmap.map = maptofix.map;
end






