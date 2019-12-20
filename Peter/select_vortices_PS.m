function new_data = select_vortices_PS(data,layer,color_lim,c_map)

load_color;
if isstruct(data)
    tmp_data = data.map;
else
    tmp_data = data;
end
[nr nc nz] = size(tmp_data);

img_plot2((tmp_data(:,:,layer)),c_map);               
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
    
%         % Multiply tmp_data with the mask
%         for i=1:nz
%             tmp_data(:,:,i) = tmp_data(:,:,i).*M;
% %           figure; img_plot3(tmp_data(:,:,i));
%         end
    

        
        if isstruct(data)
            new_data = data;
            
            tf = isfield(data, 'vortex_layer');
            if tf == 0
                new_data.vortex_pos{1} = pos;
                new_data.vortex_layer{1} = layer;
                new_data.vortex_mask = M;
            elseif tf == 1
                ll = length(data.vortex_layer);
                new_data.vortex_pos{ll+1} = pos;
                new_data.vortex_layer{ll+1} = layer;
                
                VM = new_data.vortex_mask + M;
                for i=1:nr
                    for j=1:nr
                        if VM(i,j) > 0
                            VM(i,j)=1;
                        end
                    end
                end
                new_data.vortex_mask = VM;
            end
            
            
            new_data.map = tmp_data;
            s = sum(sum(M));
            new_data.ave = squeeze(sum(sum(tmp_data)))/s;
            new_data.var = [new_data.var '_vortices'];
            new_data.ops{end+1} = ['vortices'];
            img_obj_viewer2(new_data);   
        else
            new_data = tmp_data;
            img_plot2(new_data,Cmap.Blue2,'vortices');
        end
    


    


end