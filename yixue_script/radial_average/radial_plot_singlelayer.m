% 2019-6-24 YXC
% radially plot FTmap

function [rad_avg2,q] = radial_plot_singlelayer(FTmap,startpix,endpix,startangle,endangle,layer,varargin)
if nargin>6
    plott = 0;
else
    plott = 1;
end

[nx,~,nz] = size(FTmap.map);
center = fix(nx/2)+1;
size_r = endpix-center+1;
rad_avg = zeros(size_r,nz);
% size(rad_avg)
for radius = startpix:size_r
    rad_avg(radius,:) = radial_average_mask(FTmap,radius,startangle,endangle);
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
data = FTmap;
q = linspace(data.r(center),data.r(endpix),length(rad_avg2));
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