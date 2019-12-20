function data_loc=cuprate_atomic_site_gen(data)
data_loc = data;
phase_map = data_loc.phase_map;
data_loc.Cu =  atomic_pos(phase_map,0,0);
data_loc.Ox =  atomic_pos(phase_map,pi,0);
data_loc.Oy =  atomic_pos(phase_map,0,pi);
[Cu_index Ox_index1 Ox_index2 Oy_index1 Oy_index2] = BSCCO_Cu_O_index(data_loc.Cu,data_loc.Ox,data_loc.Oy);
data_loc.Cu_index = Cu_index;
data_loc.Ox_index1 = Ox_index1; data_loc.Ox_index2 = Ox_index2; 
data_loc.Oy_index1 = Oy_index1; data_loc.Oy_index2 = Oy_index2;