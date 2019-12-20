function map=ns2volt(map)
factor=1/((0.005/10)/(2/100)*1.495*11);
map=factor*map; 