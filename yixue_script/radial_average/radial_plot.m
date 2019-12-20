% 2019-6-24 YXC
% radially plot FTmap

function [rad_avg,q] = radial_plot(FTmap,startpix,endpix,startangle,endangle,varargin)
if nargin>5
    plott = 0;
else
    plott = 1;
end

% FTmap = ft;
% size_r = fix(nx/2-4);
% startpix = 50;

% center_x = 151;
% center_y = 151;
% x = linspace(1,300,300);
% [X,Y] = meshgrid(x);
% X = X-center_x;
% Y = Y-center_y;
% dist = sqrt(X.^2+Y.^2);
% FTmap.map(:,:,1) = dist;



[nx,~,nz] = size(FTmap.map);
size_r = endpix-fix(nx/2);
rad_avg = zeros(size_r,nz);


for radius = startpix:size_r
    rad_avg(radius,:) = radial_average_mask(FTmap,radius,startangle,endangle);
end
rad_avg = rad_avg';
% figure,
% for layer = 1:nz
%     plot(rad_avg(:,layer));
%     hold on
% end


data = FTmap;
% q = linspace(data.r(fix(nx/2)),data.r(fix(nx/2)+size_r),fix(size_r/2));
q = linspace(0,data.r(fix(nx/2)+size_r)-data.r(fix(nx/2)),fix(size_r/2));

if plott == 1
    ee = data.e.*1000;
    size(q)
    size(ee)
    size(rad_avg)
    figure,imagesc(q,ee,rad_avg)
    set(gca,'YDir','normal');
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