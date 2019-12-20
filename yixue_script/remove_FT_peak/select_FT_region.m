function new_data = select_FT_region(data,layer,color_lim,c_map,inverseornot)

load_color;
if isstruct(data)
    tmp_data = data.map;
else
    tmp_data = data;
end
[nr nc nz] = size(tmp_data);

img_plot2(amplitude_map(tmp_data(:,:,layer)),c_map);               
caxis(color_lim);



        % Draw ROI, create binary ROI Mask
        h = gcf;
        h = imfreehand;
        setColor(h,'r');
        
        % get the position coordinates of the drawn region of interest and save
        % them into the cell structure pos
        pos{1} = getPosition(h);
        clear h;

        % ask if you want to create more than one region of interest
        button2 = 'Yes';

        while strcmp(button2, 'Yes') == 1

            button2 = questdlg('Do you want to add another region?',...
            'Choose yes or no','Yes','No','Cancel','No');

            if strcmp(button2,'Yes')
                h = imfreehand;
                setColor(h,'r');
                l = length(pos);
                l = l+1;
                pos{l} = getPosition(h);
            end
        end


        % Initialize zero matrix for mask
        M = zeros(nr, nc, 1);

        % Create the mask for the individual regions of interest using the 
        % MATLAB program poly2mask and add them all together 
        for i=1:length(pos)
            ip = pos{i};
            ix = ip(:,1);
            iy = ip(:,2);
            BW = poly2mask(ix, iy, nr, nc);
            M = M + BW;
            clear BW;
        end
    
        
        % Plot the mask
        figure, imagesc(M);
        
        if inverseornot== 0  
            mask =1-M;
        else
            mask = M;
        end
        
        mask3D = zeros(nr,nc,nz);
        % Multiply tmp_data with the mask
        for i=1:nz
            mask3D(:,:,i) = mask;
%             tmp_data(:,:,i) = tmp_data(:,:,i).*(1-M);
%           figure; img_plot3(tmp_data(:,:,i));
        end
        tmp_data = tmp_data.*mask3D;
        if isstruct(data)
            data.cpx_map = data.cpx_map.*mask3D;
            data.rel_map = data.rel_map.*mask3D;
            data.img_map = data.img_map.*mask3D;
            data.apl_map = data.apl_map.*mask3D;
            data.pha_map = data.pha_map.*mask3D;
        end

        
        if isstruct(data)
            new_data = data;
 
            
            
            new_data.map = tmp_data;
            s = sum(sum(M));
            new_data.ave = squeeze(sum(sum(tmp_data)))/s;
            new_data.var = [new_data.var '_remove_qpeaks'];
            new_data.ops{end+1} = ['qpeaksRemoved'];
            img_obj_viewer2(amplitude_map(new_data));   
        else
            new_data = tmp_data;
            img_plot2(amplitude_map(new_data),Cmap.Blue2,'qpeaks_removed');
        end
    



end





