function new_data = current_divide(Gdata,Idata)

zero_energy = find(Gdata.e == 0);
zero_energy = 1;
for i = 1:length(Gdata.e)
    new_map(:,:,i) = Gdata.map(:,:,i)./Idata.map(:,:,zero_energy);
end
    new_data = Gdata;
    new_data.map = new_map;
end