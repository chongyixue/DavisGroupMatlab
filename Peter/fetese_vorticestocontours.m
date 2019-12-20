function [blmap,bmap,fperimeter] = fetese_vorticestocontours(vmap,nomagmap,magmap)

[ox, oy, oz] = size(vmap.map);

vmap.map = imresize(vmap.map,[ox/200*1024, oy/200*1024],'Cubic');



figure, img_plot4(vmap.map);

% fmap = medfilt2(vmap.map,[7,7],'indexed');

% fmap = medfilt2(vmap.map,[7,7]);

inpf = 1024/200;

fa = round(7 * inpf);

% fa = 7;

h = fspecial('average',[fa,fa]);
fmap = imfilter(vmap.map,h,'replicate');


[nx, ny, nz] = size(fmap);
% corr_data = norm_xcorr2d(fmap,fmap);
% 
% xg = round(nx/2);
% yg = round(ny/2);
% 
% [x,resnorm,residual]=complete_fit_2d_gaussian(corr_data(xg-25:xg+25,yg-25:yg+25,1));

figure, img_plot4(fmap);

% figure, img_plot4(corr_data);


bmap = zeros(nx, ny, nz);

blmap = zeros(nx, ny, nz);

lmap = zeros(nx, ny, nz);

% h = fspecial('gaussian',50,25);
% lmap = imfilter(fmap,h,'replicate');

sa = round(20 * inpf);

% sa = 20;

h = fspecial('average',[sa,sa]);
lmap = imfilter(vmap.map,h,'replicate');


figure, img_plot4(lmap);

lnmap = (fmap-lmap)./fmap;


% lnmap = fmap./lmap;



figure, img_plot4(lnmap);

tmp_layer = reshape(fmap,nx*ny,1);
tmp_std = std(tmp_layer);

thresh = mean(mean(fmap))+1.0*tmp_std;

t = 1;

for i=1:nx
    for j=1:ny
        
%         if fmap(i,j,1) > thresh
%             bmap(i,j,1) = 1;
%             t = t+1;
%         else
%             bmap(i,j,1) = 0;
%         end
        
        if lnmap(i,j,1) > 0.3 && lnmap(i,j,1) < inf
            blmap(i,j,1) = lnmap(i,j,1);
%             blmap(i,j,1) = 1;
            bmap(i,j,1) = 1;
%             bvec(t) = fmap(i,j,1);
%             t = t+1;
        else
            blmap(i,j,1) = 0;
            bmap(i,j,1) = 0;
        end
        
    end
end

figure, img_plot4(blmap);

% figure, img_plot4(blmap .* fmap);
% figure, img_plot4(bmap .* fmap);

% ntmap = blmap .* fmap;
% 
% tmp_std2 = std(bvec);
% 
% athresh = sum(sum(ntmap))/sum(sum(bmap)) + 0.1 * tmp_std;
% 
% for i=1:nx
%     for j=1:ny
%         if fmap(i,j,1) > athresh
%             bmap(i,j,1) = 1;
%         else
%             bmap(i,j,1) = 0;
%         end
%     end
% end



figure, img_plot5(bmap);


fperimeter = bwboundaries(bmap);

test = 1;


end