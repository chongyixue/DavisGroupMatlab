function fetese_topomask(data)

topo = data.map;


[nx, ny, nz] = size(topo);

b1map = zeros(nx,ny,nz);
b2map = zeros(nx,ny,nz);
b3map = zeros(nx,ny,nz);
b4map = zeros(nx,ny,nz);



for i=1:nx
    for j=1:ny
        if topo(i,j,1) > -0.1
            b1map(i,j,1) = 1;
        else
            b1map(i,j,1) = 0;
        end
        if topo(i,j,1) > 0
            b2map(i,j,1) = 1;
        else
            b2map(i,j,1) = 0;
        end
        if topo(i,j,1) > 0.05
            b3map(i,j,1) = 1;
        else
            b3map(i,j,1) = 0;
        end
        if topo(i,j,1) > 0.1
            b4map(i,j,1) = 1;
        else
            b4map(i,j,1) = 0;
        end
    end
end

figure, img_plot5(b1map)
figure, img_plot5(b2map)
%% b3map (> 0.05) works best for 0.5 T to 6 T measurements
figure, img_plot5(b3map)
figure, img_plot5(b4map)

fperimeter = bwboundaries(b3map);
total = bwarea(b3map);

for i=1:length(fperimeter)
    dum1 = fperimeter{i};
    if length(dum1) > 2
        newperimeter{i} = dum1;
    end
end




end