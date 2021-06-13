% 2019-6-24 YXC
% radially plot FTmap

function [rad_avg,q] = radial_plot(FTmap,startpix,endpix,startangle,endangle,centerx,centery,varargin)
if nargin>7
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
% size_r = endpix-fix(nx/2);
size_r = round(maxdisttocorner(nx,[centerx,centery]));

size_r = min(size_r,endpix);

rad_avg = zeros(size_r,nz);

for radius = startpix:size_r % size_r is 6 if radius goes 0,1,2,3,4,5,6
    rad_avg(radius-startpix+1,:) = radial_average_mask(FTmap,radius,startangle,endangle,...
        'center',[centerx,centery]);
end

rad_avg = rad_avg';
% figure,
% for layer = 1:nz
%     plot(rad_avg(:,layer));
%     hold on
% end


data = FTmap;
% q = linspace(data.r(fix(nx/2)),data.r(fix(nx/2)+size_r),fix(size_r/2));
% q = linspace(0,data.r(fix(nx/2)+size_r)-data.r(fix(nx/2)),fix(size_r/2));
dq = data.r(2)-data.r(1);
q = 0:dq:dq*size_r;


assignin('base','rad_avg_tmp',rad_avg);
assignin('base','qr_tmp',q);

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

function d = maxdisttocorner(nx,px)
d1 = sqrt(sum((px-1).^2));
d2 = sqrt(sum((px-nx).^2));
d3 = sqrt(sum(px-[1,nx]).^2);
d4 = sqrt(sum(px-[nx,1]).^2);
d = max([d1,d2,d3,d4]);
end