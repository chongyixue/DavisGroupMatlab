function index = energy_index(map,energy_mV)

array = map.e*1000;
new = abs(array-energy_mV);
[~,index] = min(new);

end


