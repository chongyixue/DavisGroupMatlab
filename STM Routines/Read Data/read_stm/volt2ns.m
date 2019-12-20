function map=volt2ns(map)
factor=((0.01/10)/(2/100)*1.495*11);
map=factor*map; 