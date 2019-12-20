function selectfeatures(topo1, topo2, fon)

if strcmp(fon,'ave')
    h = fspecial('average',[3,3]);
    topo1 = imfilter(topo1,h,'replicate');
    topo2 = imfilter(topo2,h,'replicate');
end
    
cpselect(topo2, topo1);
end