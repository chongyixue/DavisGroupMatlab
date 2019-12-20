function [mapcell, svec, evec] = cutupdata(data, cn)

map = data.map;
en = data.e;

[nx, ny, nz] = size(map);

dx = floor(nx / cn);


cc = 1;

for i=0:cn-1
    for j=0:cn-1
        svec(cc, 1) = 1 + i*dx;   
        svec(cc, 2) = 1 + j*dx;
        
        if (dx + i*dx) >= nx || i == cn-1
            evec(cc, 1) = nx;
            
            if (dx + j*dx) >= nx || j == cn-1
                evec(cc, 2) = nx;
            else
                evec(cc, 2) = dx + j*dx;
            end
        else
            evec(cc, 1) = dx + i*dx;
            
            if (dx + j*dx) >= nx || j == cn-1
                evec(cc, 2) = nx;
            else
                evec(cc, 2) = dx + j*dx;
            end
            
        end
        
        cc = cc+1;
    end
end
cc = cc - 1;


for i = 1:cc
    mapcell{i} = map(svec(i,1) : evec(i,1), svec(i,2) : evec(i,2), :);
    [mx, my, mz] = size(mapcell{i});
    spec = squeeze( reshape(mapcell{i}, mx*my, 1,mz) );
    avspcell{i} = squeeze(mean(spec));
    stdspcell{i} = std(spec);
end

figure, hold on

for i = 1:cc
    plot(en, avspcell{i},'o-','LineWidth', 2)
    legcell{i}=(num2str(i));
end
legend(legcell)
hold off

test = 1;

for i = 1:cc
    figure, imagesc(mapcell{i}(:,:,1))
end


ei = 1:1:length(en);

for i = 1:cc
    figure, plot(ei, avspcell{i},'o-','LineWidth', 2)
    legend(num2str(i));
    xlim([ei(1), ei(end)]);
    ylim([min(avspcell{i}), max(avspcell{i})]); 
end





end