function  [cu_data, o1_data, o2_data] = bssco_lattice_segregation(data, lf_topo, c1, sx,ex,sy,ey)
%% uses LF-corrected data to extract information for specific lattice sites.
%% input
% data = LF-corrected data of some sorts (G, I, T, R, Z, L,...)
% lf_topo = LF-corrected topograph
% c1 = [0,1,2,3,...] determines how many neighboring pixel on each side of
% a specific lattice site are included, for example 1 would turn it into a
% 3x3 pixel area.
% sx, ex = start and end point in x direction used to reduce area used for
% analysis
% sy, ey = start and end point in y direction used to reduce area used for
% analysis
%% output
% cu_data = Cu-lattice sites exclusive data
% o1_data = Oxygen 1 lattice site exclusive data
% o2_data = Oxygen 2 lattice site exclusive data

% intialize output data
cu_data = data;
o1_data = data;
o2_data = data;


% get the size of the STM data
[nx, ny, nz] = size(data.map);



% find the locations of the Cu- and O-atoms, using LF-corrected data
data_loc = lf_topo;
phase_map = data_loc.phase_map;
%% alternative method using exact double precision numbers, not very useful
%% as integer pixel coordinates are needed eventually 
% [culocap, culocex] =  atomic_pos_v2(phase_map,0,0, lf_topo);
% 
% [o1locap, o1locex] =  atomic_pos_v2(phase_map,pi,0, lf_topo);
% [o2locap, o2locex] =  atomic_pos_v2(phase_map,0,pi, lf_topo);


%% find the integer pixel coordinates of Cu and Oxygen atoms
culocap =  atomic_pos(phase_map,0,0);
o1locap =  atomic_pos(phase_map,pi,0);
o2locap =  atomic_pos(phase_map,0,pi);


cc = 1;
cc1 = 1;
cc2 = 1;

for i=1:nx
    for j=1:ny
        
        if culocap(i,j,1) == 1
            culocex(1, cc) = i;
            culocex(2, cc) = j;
            cc = cc+1;
        end
        
        if o1locap(i,j,1) == 1
            o1locex(1, cc1) = i;
            o1locex(2, cc1) = j;
            cc1 = cc1+1;
        end
        
        if o2locap(i,j,1) == 1
            o2locex(1, cc2) = i;
            o2locex(2, cc2) = j;
            cc2 = cc2+1;
        end
    end
end

%% Plot the position of the lattice sites on top of the topograph

% define non-standard colors
darkorange = [255, 140, 0] / 255;
royalblue = [0, 191, 255] / 255;

p = 5;
% allows you to adjust histogram and color scheme for your topo
change_color_of_STM_maps(lf_topo.map(:,:,:),'no')
hold on 

for i=1:length(o1locex(1,:))
        if o1locex(1,i) > sy && o1locex(1,i) < ey && o1locex(2,i) > sx && o1locex(2,i) < ex
    %         plot(o1locex(2,i), o1locex(1,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
            plot(o1locex(2,i), o1locex(1,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','b','MarkerFaceColor','b', 'LineWidth', 2);
        end
    end

    for i=1:length(o2locex(1,:))
        if o2locex(1,i) > sy && o2locex(1,i) < ey && o2locex(2,i) > sx && o2locex(2,i) < ex
    %         plot(o2locex(2,i), o2locex(1,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor','y','MarkerFaceColor','y', 'LineWidth', 2);
            plot(o2locex(2,i), o2locex(1,i),'Marker', '+', 'MarkerSize', p,'MarkerEdgeColor',royalblue,'MarkerFaceColor',royalblue, 'LineWidth', 2);
        end
    end

    for i=1:length(culocex(1,:))
        if culocex(1,i) > sy && culocex(1,i) < ey && culocex(2,i) > sx && culocex(2,i) < ex
    %         plot(culocex(2,i), culocex(1,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor','r','MarkerFaceColor','r', 'LineWidth', 2);
            plot(culocex(2,i), culocex(1,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
        end
    end
    


hold off

%% compute the lattice specific maps

% intialize zero maps both for the output and for the average maps that
% will be used to subtract the lattice average from the lattice sites
cu_data.map = zeros(nx,ny,nz);
cu_avg_map = zeros(nx, ny, nz);

o1_data.map = zeros(nx,ny,nz);
o1_avg_map = zeros(nx,ny,nz);

o2_data.map = zeros(nx,ny,nz);
o2_avg_map = zeros(nx,ny,nz);

% c1 =0;
o1_avg = [];
o2_avg = [];
cu_avg = [];

% this step only needed if you used alternative method to get double
% precision values of the lattice sites
culocex = round(culocex);
o1locex = round(o1locex);
o2locex = round(o2locex);

% loop through the energy layers of data
for k=1:nz

    % loop through the O1 sites
    for i=1:length(o1locex(1,:))
        if o1locex(1,i) > sy && o1locex(1,i) < ey && o1locex(2,i) > sx && o1locex(2,i) < ex
            
            % replace zeros with value at lattice site of map
            o1_data.map(o1locex(1,i)-c1:o1locex(1,i)+c1, o1locex(2,i)-c1:o1locex(2,i)+c1,k) = ...
                data.map(o1locex(1,i)-c1:o1locex(1,i)+c1, o1locex(2,i)-c1:o1locex(2,i)+c1,k);
            
            % replace zeros at lattice site with ones
            o1_avg_map(o1locex(1,i)-c1:o1locex(1,i)+c1, o1locex(2,i)-c1:o1locex(2,i)+c1,k) = 1;
            
            % add lattice site values to vector used to calculate lattice specific mean 
            o1_avg = [o1_avg, reshape(data.map(o1locex(1,i)-c1:o1locex(1,i)+c1, o1locex(2,i)-c1:o1locex(2,i)+c1,k), [1,(1+2*c1)^2]) ];
        end
    end
    
    % subtract lattice mean from the lattice sites
    o1_avg_map(:,:,k) = o1_avg_map(:,:,k) * mean(o1_avg);
    o1_data.map(:,:,k) = o1_data.map(:,:,k) - o1_avg_map(:,:,k);
    o1_avg = [];

    % loop through the O2 sites
    for i=1:length(o2locex(1,:))
        if o2locex(1,i) > sy && o2locex(1,i) < ey && o2locex(2,i) > sx && o2locex(2,i) < ex
            
            % replace zeros with value at lattice site of map
            o2_data.map(o2locex(1,i)-c1:o2locex(1,i)+c1, o2locex(2,i)-c1:o2locex(2,i)+c1,k) = ...
                data.map(o2locex(1,i)-c1:o2locex(1,i)+c1, o2locex(2,i)-c1:o2locex(2,i)+c1,k);
            
            % replace zeros at lattice site with ones
            o2_avg_map(o2locex(1,i)-c1:o2locex(1,i)+c1, o2locex(2,i)-c1:o2locex(2,i)+c1,k) = 1;
            
            % add lattice site values to vector used to calculate lattice specific mean 
            o2_avg = [o2_avg, reshape(data.map(o2locex(1,i)-c1:o2locex(1,i)+c1, o2locex(2,i)-c1:o2locex(2,i)+c1,k), [1,(1+2*c1)^2]) ];
        end
    end
    
    % subtract lattice mean from the lattice sites
    o2_avg_map(:,:,k) = o2_avg_map(:,:,k) * mean(o2_avg);
    o2_data.map(:,:,k) = o2_data.map(:,:,k) - o2_avg_map(:,:,k);
    o2_avg = [];

    % loop through the Cu sites
    for i=1:length(culocex(1,:))
        if culocex(1,i) > sy && culocex(1,i) < ey && culocex(2,i) > sx && culocex(2,i) < ex
            
            % replace zeros with value at lattice site of map
            cu_data.map(culocex(1,i)-c1:culocex(1,i)+c1, culocex(2,i)-c1:culocex(2,i)+c1,k) = ...
                data.map(culocex(1,i)-c1:culocex(1,i)+c1, culocex(2,i)-c1:culocex(2,i)+c1,k);
            
            % replace zeros at lattice site with ones
            cu_avg_map(culocex(1,i)-c1:culocex(1,i)+c1, culocex(2,i)-c1:culocex(2,i)+c1,k) = 1;
            
            % add lattice site values to vector used to calculate lattice specific mean 
            cu_avg = [cu_avg, reshape(data.map(culocex(1,i)-c1:culocex(1,i)+c1, culocex(2,i)-c1:culocex(2,i)+c1,k), [1,(1+2*c1)^2]) ];
        end
    end
    
    % subtract lattice mean from the lattice sites
    cu_avg_map(:,:,k) = cu_avg_map(:,:,k) * mean(cu_avg);
    cu_data.map(:,:,k) = cu_data.map(:,:,k) - cu_avg_map(:,:,k);
    cu_avg = [];
    
end
    
% plot the mask of Cu sites as a check
figureset_img_plot(cu_avg_map(:,:,1));
    
end