% 2019-2-27 YXC
% recreate Peter's gapmap and ED_map
% using his pre-processed parameters
% that cuts map into 4 regions and have first guessing parameters

llfpar = llfpar_50217A00; % wrong map
[feat, para, regions] = size(llfpar);% 3 8 4


[llmap, llwmap, llamap, llarea, cbkg, lbkg, qbkg, qbkgc] = CBST_LL_fitting_revisited2016(obj_50217A00_G, mapcell, llfpar, svec, evec);


