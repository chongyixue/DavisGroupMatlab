% YXC 2019-2-25
% get layer number based on energy

function layer = get_energy_index(map,energy)

divisions = map.e(2)-map.e(1);
start = map.e(1);
distance = (energy*0.001-start);
layer = round(distance/divisions)+1;

end
