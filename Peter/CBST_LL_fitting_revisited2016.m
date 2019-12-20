function [llmap, llwmap, llamap, llarea, cbkg, lbkg, qbkg, qbkgc] = CBST_LL_fitting_revisited2016(data, mapcell, llfpar, svec, evec)

[nx, ny, dummy] = size(data.map);
nz = length(squeeze(llfpar(1,:,1)));
clear dummy;
cc = length(mapcell);



tic
for i=1:cc
%     i = 2;
    data.map = mapcell{i};
    %% 
%     avp = llfpar(1,:,i);
%     % flip avpw avpw2 because I misremembered after a year which one should
%     % be the bigger number
%     avpw = llfpar(3,:,i);
%     avpw2 = llfpar(2,:,i);
    %% use the mean so you don't get box effect in result at the end 05/18/2016
    avp = round( mean(llfpar(1,:,:),3));
    avpw = round( mean(llfpar(3,:,:),3));
    avpw2 = round( mean(llfpar(2,:,:),3));
    
    [llmapcell{i},llwmapcell{i},llamapcell{i},cbkgcell{i}...
        ,lbkgcell{i},qbkgcell{i},qbkgccell{i}, llareacell{i}]...
        = Landaulevelmap(data,avp,avpw,avpw2);
    toc
    test = 1;
end



llmap = zeros(nx, ny, nz);
llwmap = zeros(nx, ny, nz);
llamap = zeros(nx, ny, nz);
llarea = zeros(nx, ny, nz);
cbkg = zeros(nx, ny, nz);
lbkg = zeros(nx, ny, nz);
qbkg = zeros(nx, ny, nz);
qbkgc = zeros(nx, ny, nz);


for i = 1:cc
    
    llmap(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = llmapcell{i};
    llwmap(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = llwmapcell{i};
    llamap(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = llamapcell{i};
    llarea(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = llareacell{i};
    cbkg(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = cbkgcell{i};
    lbkg(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = lbkgcell{i};
    qbkg(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = qbkgcell{i};
    qbkgc(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :) = qbkgccell{i};
    
end


toc

end