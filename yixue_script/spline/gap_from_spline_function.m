% 2018-10-11
% YXC
% the gapmap 'energylayer' is avg,leftgap,rightgap and bad pixels respec.

function [gapmap,bad_x,bad_y] = gap_from_spline_function(map,maxgap,varargin)

gapmap = map;
gapmap.map = map.map(:,:,1:4);
% energy = map.e*1000;
gapmap.name = 'gapmapMODIFIED';
gapmap.e = [0,-0.001,0.001,0.609];

%for gap edge, pick min and max of first derivative
% spline_x = linspace(energy(1),energy(end),1001);
% [~,leftindex]=min(abs(spline_x+0.15));
% [~,rightindex]=min(abs(spline_x-0.15));
% middleindex = (leftindex+rightindex)/2;
pixels = size(map.map,2);

bad_x = [];
bad_y = [];

for x = 1:pixels
    for y = 1:pixels
        [~,~,~,leftgap,rightgap,badcheck] = spline_fit(map,x,y,0,maxgap,'noplot');
        gapmap.map(y,x,2) = leftgap;
        gapmap.map(y,x,3) = rightgap;
        gapmap.map(y,x,1) = (rightgap-leftgap)/2;
        
        if badcheck < 0
            bad_x(end+1) = x;
            bad_y(end+1 )= y;
            gapmap.map(y,x,4) = 10;
        else
            gapmap.map(y,x,4) = gapmap.map(y,x,1);
        end
    end
end

bad_percentage = length(bad_x)*100/(pixels*pixels)

img_obj_viewer_test(gapmap)




        