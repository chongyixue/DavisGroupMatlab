function topo_rec_comp_tet_sum = simulate_transition_lattice_layers(nr,ax,ay,maxangle,layers)


topo_rec_comp_tet_sum = simulate_transition_lattice(nr,ax,ay,0,98989);

for n = 1:layers
    angle = (n-1)*maxangle/(layers-1);
    topo = simulate_transition_lattice(nr,ax,ay,angle,989898);
    topo_rec_comp_tet_sum.map(:,:,n) = topo.map;

    topo_rec_comp_tet_sum.e(n) = angle/1000;

end

img_obj_viewer_yxc(topo_rec_comp_tet_sum)


end