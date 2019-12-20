function [obj] = mat2STM_Viewer(mat,E_start,E_end,n_E,varargin)
%Function to view a matrix data in STM Viewer test
%INPUT: the matrix
s = size(mat);
if length(s)==3
    n_layers = s(3);
else
    n_layers = 1;
end
new_data = make_struct;
new_data.map = mat;
new_data.r = 1:s(1);
new_data.e = linspace(E_start,E_end,n_E);
if nargin>4
    new_data.name = varargin{1};
else
    new_data.name = 'matrix';
    img_obj_viewer_test(new_data);
end
new_data.type = 3;
new_data.var = '';
obj = new_data;

