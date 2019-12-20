map = cropmap;

pixels = size(map.map,3);
bad_percentage = length(bad_x)*100/(pixels*pixels)
% x = round(rand*length(bad_x));
% [~,~,~,leftgap,rightgap] = spline_fit(map,bad_x(x),bad_y(x),1,0.15);
% average_gap = (rightgap-leftgap)/2;

repeat = 1;
while repeat == 1
    x = round(rand*pixels);
    y = round(rand*pixels);
    
    for k = 1: length(bad_x)
        if bad_x(k)~=x && bad_y(k)~=y
            repeat = 0;
        end
    end
end
[~,~,~,leftgap,rightgap] = spline_fit(map,x,y,1,0.15);
average_gap = (rightgap-leftgap)/2
