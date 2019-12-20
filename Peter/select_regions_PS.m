function new_data = select_regions_PS(data)
load_color;
if isstruct(data)
    tmp_data = data.map;
    oldmap = data.map;
else
    tmp_data = data;
end
[nr nc nz] = size(tmp_data);

%% Option that allows you to create a mask that will be
%% multiplied with the data so that you can create selective FT and IFT
% button = questdlg('Do you want to select certain regions of the image and set the rest to zero, or vice versa, or both?',...
%     'Choose Inclusive, Exclusive or Cancel','Inclusive','Exclusive','Cancel','Cancel');
[iebs,iebv] = listdlg('PromptString','Do you want to select certain regions of the image and set the rest to zero, or vice versa, or both?',...
                    'SelectionMode','multiple',...
                    'ListString',{'Inclusive','Exclusive','Both'});

if iebs == 1 || iebs==2 || iebs ==3
    
    % Load the data to use for choosing regions of interest for the mask
    str = load_wrkspc_dialogue;
    if ~isempty(str)
        img_obj = evalin('base',str);
    end
    
    if isstruct(img_obj)
        [inx, iny, inz] = size(img_obj.map);
        if inz > 1
            for i=1:size((img_obj.e), 2)
                enstr{i} = num2str(img_obj.e(i));
            end
            % Choose the current layers to normalize the data to
            [s,v] = listdlg('PromptString','Select energy layers in meV to normalize to:',...
                        'SelectionMode','multiple',...
                        'ListString',enstr);
            img_plot2(img_obj.map(:,:,s),Cmap.Blue2);
        else
            tf = isfield(img_obj, 'topo1');
            if tf == 0
                img_plot2(img_obj.map,Cmap.Blue2);
            else
                img_plot3(img_obj.map);
            end
        end
    end
    
%     img_obj_viewer2(img_obj)

%     button3 = questdlg('Do you want to use single points or regions for mask?',...
%     'Choose Single Points, Regions or Cancel','Single Points','Regions','Cancel','Regions');
    [button3,button3v] = listdlg('PromptString',...
        'Do you want to use single points, free hand regions or circle for mask?',...
                    'SelectionMode','multiple',...
                    'ListString',{'Regions','Single Points','Circle'});
                
    if button3 == 1
        % Draw ROI, create binary ROI Mask
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
    elseif button3 == 2
        
        
        [button4,button4v] = listdlg('PromptString',...
        'Do you want to put in coordinates or manually select in image?',...
                    'SelectionMode','multiple',...
                    'ListString',{'coordinates','manual select'});
        if button4 ==1
            
            prompt = {'x:','y:'};
            dlg_title = 'Input';
            num_lines = 1;
            def = {'1','1'};
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            ans1 = str2num(answer{1,1});
            ans2 = str2num(answer{2,1});
            

            % get the position coordinates of the drawn region of interest and save
            % them into the cell structure pos
            pos{1} = [ans2 , ans1];
            clear h;

            % ask if you want to create more than one region of interest
            button2 = 'Yes';

            while strcmp(button2, 'Yes') == 1

                button2 = questdlg('Do you want to add another region?',...
                'Choose yes or no','Yes','No','Cancel','No');

                if strcmp(button2,'Yes')
                    
                    prompt = {'x:','y:'};
                    dlg_title = 'Input';
                    num_lines = 1;
                    def = {'1','1'};
                    answer = inputdlg(prompt,dlg_title,num_lines,def);
                    ans1 = str2num(answer{1,1});
                    ans2 = str2num(answer{2,1});
            
                    l = length(pos);
                    l = l+1;
                    pos{l} = [ans2, ans1];
                end
            end
        elseif button4 ==2
                
            % Draw ROI, create binary ROI Mask
            h = impoint;
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
                    h = impoint;
                    setColor(h,'r');
                    l = length(pos);
                    l = l+1;
                    pos{l} = getPosition(h);
                end
            end
        end


        % Initialize zero matrix for mask
        M = zeros(nr, nc, 1);
%         M((nr-1)/2+1-5:(nr-1)/2+1+5,(nr-1)/2+1-5:(nr-1)/2+1+5) = 1;

        % Create the mask for the individual regions of interest using the 
        % MATLAB program poly2mask and add them all together 
        for i=1:length(pos)
            ip = pos{i};
            ix = round(ip(:,1));
            iy = round(ip(:,2));
            M(iy,ix) = 1;
%             [X,Y]=meshgrid(1:1:nr,1:1:nr);
%             xdata(:,:,1)=X;
%             xdata(:,:,2)=Y;
%             xfit = [1, ix, nr/100, iy, nr/100, 0, 0];
%             F = twodgauss(xfit,xdata);
%             M = M+F;
        end
        
        

%     xfit = [1, floor(nr/2)+1, nr/100, floor(nr/2)+1, nr/100, 0, 0];
%     F = twodgauss(xfit,xdata);
%     M = M+F;
    elseif button3 == 3
       [button4,button4v] = listdlg('PromptString',...
        'Do you want to put in coordinates or manually select in image?',...
                    'SelectionMode','multiple',...
                    'ListString',{'coordinates','manual select'});
        if button4 ==1
            
            prompt = {'x:','y:'};
            dlg_title = 'Input';
            num_lines = 1;
            def = {'1','1'};
            answer = inputdlg(prompt,dlg_title,num_lines,def);
            ans1 = str2num(answer{1,1});
            ans2 = str2num(answer{2,1});
            

            % get the position coordinates of the drawn region of interest and save
            % them into the cell structure pos
            pos{1} = [ans2 , ans1];
            clear h;

            % ask if you want to create more than one region of interest
            button2 = 'Yes';

            while strcmp(button2, 'Yes') == 1

                button2 = questdlg('Do you want to add another region?',...
                'Choose yes or no','Yes','No','Cancel','No');

                if strcmp(button2,'Yes')
                    
                    prompt = {'x:','y:'};
                    dlg_title = 'Input';
                    num_lines = 1;
                    def = {'1','1'};
                    answer = inputdlg(prompt,dlg_title,num_lines,def);
                    ans1 = str2num(answer{1,1});
                    ans2 = str2num(answer{2,1});
            
                    l = length(pos);
                    l = l+1;
                    pos{l} = [ans2, ans1];
                end
            end
        elseif button4 ==2
                
            % Draw ROI, create binary ROI Mask
            h = impoint;
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
                    h = impoint;
                    setColor(h,'r');
                    l = length(pos);
                    l = l+1;
                    pos{l} = getPosition(h);
                end
            end
        end


        % Initialize zero matrix for mask
        M = zeros(nr, nc, 1);
%         M((nr-1)/2+1-5:(nr-1)/2+1+5,(nr-1)/2+1-5:(nr-1)/2+1+5) = 1;

        % Create the mask for the individual regions of interest using the 
        % MATLAB program poly2mask and add them all together 
        for i=1:length(pos)
            ip = pos{i};
            ix = round(ip(:,1));
            iy = round(ip(:,2));
            
            cm=circlematrix([nr,nc],5,ix,iy);
            M = M+double(cm);
%             M(iy,ix) = 1;
%             [X,Y]=meshgrid(1:1:nr,1:1:nr);
%             xdata(:,:,1)=X;
%             xdata(:,:,2)=Y;
%             xfit = [1, iy, nr/50, ix, nr/50, 0, 0];
%             F = twodgauss(xfit,xdata);
%             M = M+F;
        end
        
%         for i=1:nr
%             for j=1:nc
%                 if M(i,j) > 0.1
%                     M(i,j) = 1;
%                 end
%             end
%         end
        
    end
    

    if iebs == 1
        
        % Plot the mask
        figure, imagesc(M);
    
        % Multiply tmp_data with the mask
%         for i=1:nz
            Mr = repmat(M,1,1,nz);
            tmp_data = tmp_data .* Mr;
            if isfield(data,'cpx_map')==1
                data.cpx_map = data.cpx_map .* Mr;
            end
            if isfield(data,'rel_map')==1
                data.rel_map = data.rel_map .* Mr;
            end
            if isfield(data,'img_map')==1
                data.img_map = data.img_map .* Mr;
            end
            if isfield(data,'apl_map')==1
                data.apl_map = data.apl_map .* Mr;
            end
            if isfield(data,'pha_map')==1
                data.pha_map = data.pha_map .* Mr;
            end
%           figure; img_plot3(tmp_data(:,:,i));
%         end
    
        if isstruct(data)
            new_data = data;
            new_data.map = tmp_data;
            new_data.oldmap = oldmap;
            new_data.regions = pos;
            new_data.iclmask = M;
            s = sum(sum(M));
            new_data.ave = squeeze(sum(sum(tmp_data)))/s;
            new_data.var = [new_data.var '_mulipl_by_mask_'];
            new_data.ops{end+1} = ['Multiplied with user created mask'];
            img_obj_viewer2(new_data);   
        else
            new_data = tmp_data;
            img_plot2(new_data,Cmap.Blue2,'Multiplied with user created mask');
        end
    
    elseif iebs == 2
        N = ones(nr, nc, 1);
        MN = abs(M-N);
        % Plot the mask
        figure, imagesc(MN);
    
        % Multiply tmp_data with the mask
%         for i=1:nz
%             tmp_data(:,:,i) = tmp_data(:,:,i).*MN;
            Mr = repmat(MN,1,1,nz);
            tmp_data = tmp_data .* Mr;
            if isfield(data,'cpx_map')==1
                data.cpx_map = data.cpx_map .* Mr;
            end
            if isfield(data,'rel_map')==1
                data.rel_map = data.rel_map .* Mr;
            end
            if isfield(data,'img_map')==1
                data.img_map = data.img_map .* Mr;
            end
            if isfield(data,'apl_map')==1
                data.apl_map = data.apl_map .* Mr;
            end
            if isfield(data,'pha_map')==1
                data.pha_map = data.pha_map .* Mr;
            end
%           figure; img_plot3(tmp_data(:,:,i));
%         end
    
        if isstruct(data)
            new_data = data;
            new_data.map = tmp_data;
            new_data.oldmap = oldmap;
            new_data.regions = pos;
            new_data.xclmask = MN;
            s = sum(sum(MN));
            new_data.ave = squeeze(sum(sum(tmp_data)))/s;
            new_data.var = [new_data.var '_mulipl_by_mask_'];
            new_data.ops{end+1} = ['Multiplied with user created mask'];
            img_obj_viewer2(new_data);   
        else
            new_data = tmp_data;
            img_plot2(new_data,Cmap.Blue2,'Multiplied with user created mask');
        end
        
    elseif iebs == 3
        N = ones(nr, nc, 1);
        MN = abs(M-N);
        
        Mr = repmat(M,1,1,nz);
        MNr = repmat(MN,1,1,nz);
        
        % Plot the mask
        figure, imagesc(M);
        figure, imagesc(MN);
        
        tmp_data_inc = tmp_data;
        tmp_data_exc = tmp_data;
        % Multiply tmp_data with the mask
        tmp_data_inc = tmp_data.*Mr;
        tmp_data_exc = tmp_data.*MNr;
%           figure; img_plot3(tmp_data(:,:,i));

        data_inc = data;
        data_exc = data;
        
            if isfield(data,'cpx_map')==1
                data_inc.cpx_map = data.cpx_map .* Mr;
            end
            if isfield(data,'rel_map')==1
                data_inc.rel_map = data.rel_map .* Mr;
            end
            if isfield(data,'img_map')==1
                data_inc.img_map = data.img_map .* Mr;
            end
            if isfield(data,'apl_map')==1
                data_inc.apl_map = data.apl_map .* Mr;
            end
            if isfield(data,'pha_map')==1
                data_inc.pha_map = data.pha_map .* Mr;
            end
        
            if isfield(data,'cpx_map')==1
                data_exc.cpx_map = data.cpx_map .* MNr;
            end
            if isfield(data,'rel_map')==1
                data_exc.rel_map = data.rel_map .* MNr;
            end
            if isfield(data,'img_map')==1
                data_exc.img_map = data.img_map .* MNr;
            end
            if isfield(data,'apl_map')==1
                data_exc.apl_map = data.apl_map .* MNr;
            end
            if isfield(data,'pha_map')==1
                data_exc.pha_map = data.pha_map .* MNr;
            end
        
        if isstruct(data)
            new_data = data_inc;
            new_data.map = tmp_data_inc;
            new_data.oldmap = oldmap;
            new_data.regions = pos;
            new_data.iclmask = M;
            s = sum(sum(M));
            new_data.ave = squeeze(sum(sum(tmp_data_inc)))/s;
            new_data.var = [new_data.var '_mulipl_by_mask_'];
            new_data.ops{end+1} = ['Multiplied with user created mask, incl.'];
            img_obj_viewer2(new_data); 
            
            new_data1 = data_exc;
            new_data1.map = tmp_data_exc;
            new_data1.oldmap = oldmap;
            new_data1.regions = pos;
            new_data1.xclmask = MN;
            s2 = sum(sum(MN));
            new_data1.ave = squeeze(sum(sum(tmp_data_exc)))/s2;
            new_data1.var = [new_data1.var '_mulipl_by_mask_'];
            new_data1.ops{end+1} = ['Multiplied with user created mask, excl.'];
            img_obj_viewer2(new_data1); 
        else
            new_data = tmp_data_inc;
            img_plot2(new_data,Cmap.Blue2,'Multiplied with user created mask, incl.');
            new_data1 = tmp_data_exc;
            img_plot2(new_data1,Cmap.Blue2,'Multiplied with user created mask, excl.');
        
        end
        
    end
    

    
end


end