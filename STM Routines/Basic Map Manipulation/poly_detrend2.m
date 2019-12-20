%%%%%%%
% CODE DESCRIPTION: Polydetrend is used to calculate the multinomial of
% best of specified degree and return a new map with this trend subtracted
%   
% CODE HISTORY
%
% 080120 MHH  Written with 0 and (0,1) order polynomial subtraction
%
%
%%%%%%%

function[new_data] = poly_detrend2(data,order)
new_data = data;
[sx,sy,sz] = size(new_data.map);

    if order == 0
        avg_map = squeeze(squeeze(mean(mean(data.map))));
        for i = 1:sz
            new_spectmap(:,:,i) = data.map(:,:,i)  - avg_map(i);            
        end
        new_data = data;
        new_data.map = new_spectmap;
        return;
    else    
    xy=nan(sx*sy,2);
    for j=1:sx
        xy((j-1)*sy+1:j*sy,1)=1:sy;
        xy((j-1)*sy+1:j*sy,2)=j;
    end
    for i=1:sz
        temp = reshape(new_data.map(:,:,i),sx*sy,1);
        po=polyfitn(xy,temp,...
        'constant, x, y');%, x*y, x*x, y*y, x*x*x, y*y*y'); %x*x, y*y, x*x*y, x*y*y
        temp = temp - polyvaln(po,xy);
        new_data.map(:,:,i) = reshape(temp,sx,sy);        
    end
end
    



