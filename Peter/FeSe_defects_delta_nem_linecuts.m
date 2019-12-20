function [ l_cut ] = FeSe_defects_delta_nem_linecuts( data, cpos, radius )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


[nx, ny, nz] = size (data.map);

l_cut = line_cut_topo_angle(data,topo,cpos,radius,angle,avg_px)


end

