% a (sub)function to determine which surrounding pixels to average.
% mainly to deal with corners and edges
% radius is in terms of pixel, i.e. for corner, 1 gives 3pix, 2 gives 8pix
% maxpix is the maximum pixels (dimension of the map)

function [xlist,ylist] = surrounding_pixels(x_pix,y_pix,maxpix,radius)

xlist = [];
ylist = [];
l = 0;

for x = x_pix-radius:x_pix+radius
    if  x > 0 && x < maxpix+1 
        for y = y_pix-radius : y_pix+radius
            if y>0 && y < maxpix + 1 
                if y == y_pix && x == x_pix
                else
                    xlist(l+1) = x;
                    ylist(l+1) = y;
                    l = l + 1;
                end
            end
        end
    end
end

end
%%
%ignore the following, it is just stupid coding to manually determine
%surrounding pixels
% 
% if x_pix == 1
%     if y_pix == 1
%         xlist = [2,1,2];
%         ylist = [1,2,2];
%     elseif y_pix == pixels
%         xlist = [1,2,2];
%         ylist = [pixels-1,pixels-1,pixels];
%     else
%         xlist = [1,2,2,2,1];
%         ylist = [y_pix-1,y_pix-1,y_pix,y_pix+1,y_pix+1];
%     end
%     
% elseif y_pix == 1
%     if x_pix == pixels
%         xlist = [pixels-1,pixels-1,pixels];
%         ylist = [1,2,2];    
%     else
%         xlist = [x_pix-1,x_pix-1,x_pix,x_pix+1,x_pix+1];
%         ylist = [1,2,2,2,1];
%     end
%     
% elseif y_pix == pixels 
%     if x_pix == pixels
%         xlist = [pixels-1,pixels,pixels-1];
%         ylist = [pixels-1,pixels-1,pixels];
%     else
%         xlist = [x_pix-1,x_pix-1,x_pix,x_pix+1,x_pix+1];
%         ylist = [pixels,pixels-1,pixels-1,pixels-1,pixels];
%     end
%     
% elseif x_pix == pixels
%     xlist = [pixels,pixels-1,pixels-1,pixels-1,pixels];
%     ylist = [y_pix+1,y_pix+1,y_pix,y_pix+1,y_pix+1];
% 
% else 
%     xlist = [x_pix-1,x_pix,x_pix+1,x_pix-1,x_pix+1,x_pix-1,x_pix,x_pix+1];
%     ylist = [y_pix-1,y_pix-1,y_pix-1,y_pix,y_pix,y_pix+1,y_pix+1,y_pix+1,];
% end

