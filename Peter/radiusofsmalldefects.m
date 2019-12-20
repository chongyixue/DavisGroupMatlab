function radiusofsmalldefects(tdata,dpos,radius,gdata)

topo = tdata.map;

[nx,ny,nz] = size(topo);

dmap = zeros(nx,ny,1);

for i=1:length(dpos(:,1))


    cm=circlematrix([nx,ny],radius,dpos(i,2),dpos(i,1));
    dmap = dmap + double(cm);


end

% 
% for i=1:nx
%     for j=1:ny
%         if dmap(i,j,1) > 0
%             dmap(i,j,1) = 1;
%         end
%     end
% end

dmap = im2bw(dmap,0);

lmap = bwlabel(dmap);

figure, img_plot5(dmap)

figure, img_plot5(dmap.*topo)

figure, img_plot4(dmap.*gdata.map(:,:,25));

test = 1;




end