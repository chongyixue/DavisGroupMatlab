% 2019-5-21 YXC
% radial plot noncenter version

function [rad_avg2,q,mask] = radial_plot_singlelayer_noncenter(map,cx,cy,totalpix,startangle,endangle,layer,varargin)
if nargin>8
    plott = 0;
else
    plott = 1;
end

[~,~,nz] = size(map.map);
rad_avg = zeros(totalpix,nz);
% size(rad_avg)
for radius = 1:totalpix
    [avg,mask] = radial_average_mask_noncenter(map,cx,cy,radius-1,startangle,endangle);
    rad_avg(radius,:) = avg;
end

rad_avg = rad_avg';
% figure,
% for layer = 1:nz
%     plot(rad_avg(:,layer));
%     hold on
% end
% size(rad_avg)
rad_avg2 = rad_avg(layer,:);
% size(rad_avg2)
data = map;
% if strcmp(map.coord_type,'r')
    q = map.r(1:length(rad_avg2));
% else
%     center = ceil((nx+1)/2);
%     q = linspace(data.r(center),data.r(endpix),length(rad_avg2));
% end
% q = data.r(fix(nx/2):endpix)
% size(q)
% size(q)
if plott == 1
    figure
    plot(q,rad_avg2)
    title('radial linecut');
    
    if contains(data.var,'ft_')==1
        %         xlabel('q [2\pi/a_{Fe}]','FontSize',16);
        xlabel('q [A^{-1}]','FontSize',16);
    else
        xlabel('r [A]','FontSize',16);
    end
    ylabel('E [meV]','FontSize', 16);
end

end