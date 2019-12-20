function new_data = interp_smooth(data,px_count)
% px_count specifies the factor increase in the number of pixels used to
% represent the data

[nr nc] = size(data);

[X,Y] = meshgrid(1:nc,1:nr);
[XI,YI] = meshgrid(1:1/px_count:nc,1:1/px_count:nr);
new_data = interp2(X,Y,data,XI,YI);
end