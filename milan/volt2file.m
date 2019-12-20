function [map,w_zero, w_factor]=volt2file(map)
% converts map from volts to file (uint16)
%world zeros and world factro are in program!



%float w_zero w_factor w_zero=-10; w_factor= 3.0518e-04;
w_zero=min(min(min(map)))
w_factor=(max(max(max(map)))-min(min(min(map))))/1e4

map=(map-w_zero)./w_factor;
map=round(map);