function topo = flipnanonistopo(oldtopo)
topo = oldtopo;
if isfield(oldtopo,'topo1')
    topo.topo1 = flipud(oldtopo.topo1);
end
topo.map = flipud(oldtopo.map);
end