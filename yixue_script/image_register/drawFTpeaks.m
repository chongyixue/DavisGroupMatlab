% 2020-4-22 in effort to create GUI for lattice registering 
% YXC

function Bragg = drawFTpeaks(data,layer,color_lim,c_map)


load_color;
if isstruct(data)
    tmp_data = data.map;
else
    tmp_data = data;
end
% figure,imagesc(tmp_data)
% size(tmp_data)
[nr, nc ,~] = size(tmp_data);

img_plot2(amplitude_map(tmp_data(:,:,layer)),c_map);               
caxis(color_lim);



        % Draw ROI, create binary ROI Mask
        hfig = gcf;
        h = imfreehand;
        setColor(h,'r');
        
        % get the position coordinates of the drawn region of interest and save
        % them into the cell structure pos
        pos{1} = getPosition(h);
        clear h;

        % ask if you want to create more than one region of interest
        button2 = 'Yes';
        
        Narea = 1;
        while strcmp(button2, 'Yes') == 1

            button2 = questdlg('Do you want to add another region?',...
            'Choose yes or no','Yes','No','Cancel','No');

            if strcmp(button2,'Yes')
                Narea = Narea+1;
                h = imfreehand;
                setColor(h,'r');
                l = length(pos);
                l = l+1;
                pos{l} = getPosition(h);
            end
        end


        % Initialize zero matrix for mask
        M = zeros(nr, nr, Narea);

        % Create the mask for the individual regions of interest using the 
        % MATLAB program poly2mask and add them all together 
        for i=1:length(pos)
            ip = pos{i};
            ix = ip(:,1);
            iy = ip(:,2);
            BW = poly2mask(ix, iy, nr, nc);
            M(:,:,i) = BW;
            clear BW;
        end
    
        
        % Plot the mask
%         figure, imagesc(M);
        
%         if inverseornot== 0  
%             mask =1-M;
%         else
            mask = M;
%         end
        
 
        

        Bragg = zeros(Narea,2);
        for k=1:Narea
            filtered = mask(:,:,k).*tmp_data;
            [~,Bragg(k,1)] = max(max(filtered));
            [~,Bragg(k,2)] = max(max(filtered'));
        end
        

close(hfig);




end









