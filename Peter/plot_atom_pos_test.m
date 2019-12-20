function plot_atom_pos_test(data)




data_loc = data;
phase_map = data_loc.phase_map;



[atom_locap, atom_locex] =  atomic_pos_v2(phase_map,0,0, data);


% get the size of the STM data
[nx, ny, nz] = size(atom_locap);




darkorange = [255, 140, 0] / 255;
royalblue = [0, 191, 255] / 255;

p = 10;
change_color_of_STM_maps(data.map,'no')
hold on 


   

    
    for i=1:length(atom_locex(1,:))
        if atom_locex(1,i) >= 1 && atom_locex(1,i) <= ny && atom_locex(2,i) >= 1 && atom_locex(2,i) <= nx
            plot(atom_locex(1,i), atom_locex(2,i),'Marker', 'x', 'MarkerSize', p,'MarkerEdgeColor',darkorange,'MarkerFaceColor',darkorange, 'LineWidth', 2);
        end
    end

hold off


end