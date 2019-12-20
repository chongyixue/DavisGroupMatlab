function [averandom_topo, averandom_vortex] = randomhalovortices(vdata,tdata)


[nx, ny, nz] = size(vdata.map);



averandom_topo = zeros(41,41,1);
averandom_vortex = zeros(41,41,1);

% generate random spectra out of the map FOR TESTING PURPOSES
rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
if rn(1) < 21
    rn(1) = 21;
end
if rn(2) > 205
    rn(2) = 205;
end

nr=1000;

for i=1:nr
    
    rn = floor(nx*(random('unif', 0, 1, 1, 2)))+1;
    if rn(1) < 21
        rn(1) = 21;
    elseif rn(1) > 205
        rn(1) = 205;
    end
    if rn(2) > 205
        rn(2) = 205;
    elseif rn(2) < 21
        rn(2) =21;
    end
    
%     figure, img_plot5(tdata.map(rn(1)-20 : rn(1)+20,rn(2)-20:rn(2)+20,1));
%     figure, img_plot4(vdata.map(rn(1)-20 : rn(1)+20,rn(2)-20:rn(2)+20,1));
    
    averandom_topo = averandom_topo + tdata.map(rn(1)-20 : rn(1)+20,rn(2)-20:rn(2)+20,1);
    averandom_vortex = averandom_vortex + vdata.map(rn(1)-20 : rn(1)+20,rn(2)-20:rn(2)+20,1);
end



change_color_of_STM_maps(averandom_topo/nr,'no');

change_color_of_STM_maps(averandom_vortex/nr,'no');








end