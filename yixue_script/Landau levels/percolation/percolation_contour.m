% 2019-4-16 YXC
% takes in data processed from normalize.m (percolation folder)
% of 90415a00

percomap = map2;

% layer = e2lay(138.5);
% layerdata = flip(percomap.map(:,:,layer),1);
% figure,contour(layerdata)
% figure,contour(layerdata,[0.5 0.7])


% percomap.map = (isnan(percomap.map) == 0).*percomap.map;
[nx,~,nz] = size(percomap.map);
for k = 1:nz
    for x = 1:nx
        for y = 1:nx
            if isnan(percomap.map(y,x,k)) == 1
                percomap.map(y,x,k)= 0;
            end
        end
    end
end
img_obj_viewer_yxc(percomap)
percomap_binary = percomap;
percomap_binary.map = percomap.map>0.9;
percomap_binary.name = 'perco_binary';
img_obj_viewer_yxc(percomap_binary)

[~,~,nz] = size(percomap_binary.map);
en = percomap_binary.e;
circ_binary = en;
circ_all = en;
for layer = 1:nz
    circ = sum(sum(percomap_binary.map(:,:,layer)));
    circ2 = sum(sum(percomap.map(:,:,layer)));
    circ_all(layer) = circ2;
    circ_binary(layer) = circ;
end
circ_binary = circ_binary/(max(circ_binary));
circ_all = circ_all/(max(circ_all));

figure,plot(en,circ_binary,'r.','MarkerSize',10)
hold on
plot(en,circ_all,'k.','MarkerSize',10)
title('Normalized circumference')
legend("binary method conductance > 0.9","sum conductance")
ylim([0,1.1])

function lay = e2lay(energy)
layers = 131;
start = 80;
fin = 190;
div = (fin-start)/(layers-1);
lay = round((energy-start)/div)+1;
lay = lay-64;
end