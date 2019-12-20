function data = read_map_include_nanonis
%cd ('C:\Data');
%% include a question which STM the data was taken with since they use
%% different file-endings
%% Peter Sprau 01/02/2014
%% 2019-10-16 added option to open nanonis file (3ds)

fh = figure('Name','Choose STM',...
    'units','normalized', ...
    'Position',[0.3,0.3,0.15,0.15],...
    'Color',[0.6 0.6 0.6],...
    'MenuBar', 'none',...
    'NumberTitle', 'off',...
    'Resize','off');


STM1_but = uicontrol(fh,'Style','pushbutton',...
    'String','STM1',...
    'units','normalized',...
    'Position',[0.15 0.5 0.3 0.15],...
    'Callback',@STM1_Callback);

STM2_but = uicontrol(fh,'Style','pushbutton',...
    'String','STM2',...
    'units','normalized',...
    'Position',[0.15 0.2 0.3 0.15],...
    'Callback',@STM2_Callback);

nanonis_STM1_but = uicontrol(fh,'Style','pushbutton',...
    'String','Nanonis STM1',...
    'units','normalized',...
    'Position',[0.55 0.5 0.3 0.15],...
    'Callback',@nanonisSTM1_Callback);

    function data=loadfile(type,var,pathname,filename)
        if type < 0 
            data = '';
        end
        if type ==5 %nanonis map
            extension = filename(end-2:end);
            switch extension
                case '3ds'                
                    [~,~,~,~,~] = open_map_nanonis(pathname,filename,'plot');
                    
                case 'sxm'
                    [~,~] = open_topo_nanonis(pathname,filename,1);
%                     img_obj_viewer_test(topo)
                case 'dat'
                    open_point_spectrum(filename,pathname);
            end
            data = 'nanonis';
            
        elseif type ==4
            read_pointspectra3(filename)
        else
            
            
            fid = fopen([pathname filename],'r');
            % get image data
            start = 2112;
            fseek(fid,start,'bof');
            a = fread(fid,'uint16');
            
            % get additional params
            hs=read_map_extra_v1([pathname filename],fid);
            s = max(hs.irows,hs.icols);
            fclose(fid);
            
            %process image data into 3D matrix
            if type == 2 || type == 3
                a = a(1:s^2);
            else
                a = a(1:end-1300);
            end
            h = floor(length(a))/s^2;
            map = reshape(a,[s s h]);
            for k = 1:h
                map(:,:,k) = rot90(map(:,:,k),1);
                map(:,:,k) = flipud(map(:,:,k));
            end
            
            
            %********************************************************
            %   *HOW TO CONVERT DATA TO REAL WORLD UNITS (FROM V TO NS)*
            %   ********************************************************
            %   When the data was initially loaded, it was unsigned integers, ranging from
            %   0 to 65535=2^16-1.
            %   Within File_ReadTopoData.pro, the unsigned integers were converted to floats
            %   using DACtoWorld and DACtoWorldZero.
            %   Since the input of the ECU is always a voltage between -10V and +10V, and
            %   the DAC is always 16-bit = 65536, the conversion factors are the same
            %   for every dI/dV map:
            %   DACtoWorld = 0.000305180 = 20/65536
            %   DACtoWorldZero = -10
            %   But the DACtoWorld part has already been taken care of when the data was
            %   loaded from the file, so we don't need to worry about it now.
            %   What is left to worry about is sensitivity, driveamp, and attenuation:
            %   1100 takes care of the bias dividers
            %   (fsens/10)/driveamp turns it into nS except that due to high freq of data
            %   taking, driveamp is effectively attenuated (should actually be smaller
            %   number than that recorded).
            %   1.495 factor is approximate value of attenuation (scales the map curves
            %   onto the the single spectra curves which are taken at a lower frequency
            %   and are less attenuated).
            
            %convert bit data to volts: ECU discretizes -10->+10V in 16 bits
            %w_factor = 20V/2^16, w_zero = -10V
            
            map = map*hs.w_factor + hs.w_zero;
            if (type == 0)
                divider = 10; %voltage divider on bias line
                %convert LIA output to physical data signal using
                %output = (signal/sensitivity - offset)*expand*10V and inverting to
                %solve for signal which are the map values
                %hs.li_foffset = 0;
                map = (map./(hs.li_expand*10) + hs.li_foffset*(1/100))*hs.li_sens;
                % make dI/dV by dividing by bias modulation
                map = map/(hs.li_amp/(100*divider)); %100 comes form ECU divider
                hs.factor = 1;
                map = map*hs.factor;
            elseif (type == 1)
                % current data is not processed by LIA but has a correction factor
                % due to the ECU
                %hs.factor = 13.4808;
                hs.factor = -1; %inverting amplifier
                map = map*hs.factor;
            elseif (type == 2)
                hs.factor = 1;
                map = map*hs.factor;
            end
            
            % Check for the unit. If it's nm change into Angstroem and multiply by 10;
            xyunit = hs.xyunit;
            
            if strncmp(char(xyunit),'nm',2)
                hs.xyunit = 'Angstroem';
                hs.xdist = hs.xdist * 10;
                hs.ydist = hs.ydist * 10;
            else
                hs.xyunit = 'Angstroem';
            end
            
            % Ask at which temperature the data was taken, since the output of
            % x-y-piezos has to be corrected for 1.2 K (multiply by factor 1.16) and
            % for ~0.282 K (multiply by factor 1.12)
            
%             prompt = {'Rescale factor:'};
%             name='Rescale distances';
%             numlines=1;
%             defaultanswer={'1'};
%             xyrescale = inputdlg(prompt,name,numlines,defaultanswer);
%             
%             xyr = str2num(xyrescale{1});
            xyr = 1;
            
            hs.xdist = hs.xdist * xyr;
            hs.ydist = hs.ydist * xyr;
            
            % button = questdlg('At which temperature was data taken?',...
            %     'Choose temperature for correction of x-y-piezo output','0.3 K','1.2 K','4.2 K','4.2 K');
            % if strcmp(button,'0.3 K')==1
            %     hs.xdist = hs.xdist * 1.13;
            %     hs.ydist = hs.ydist * 1.13;
            % elseif strcmp(button,'1.2 K')==1
            %     hs.xdist = hs.xdist * 1.18;
            %     hs.ydist = hs.ydist * 1.18;
            % elseif strcmp(button,'4.2 K')==1
            %     hs.xdist = hs.xdist * 1;
            %     hs.ydist = hs.ydist * 1;
            % end
            
            %% don't delete any lines, sometimes necessary
            % %make all maps have odd pixel dimension (good for keeping FT image
            % %symmetric)
            % n = size(map,1);
            % if mod(n,2) == 0
            %        map = map(1:end-1,1:end-1,:);
            %        r = num_conv(linspace(0,hs.xdist,s)');
            %        r = r(1:end-1);
            % else
            %        r = num_conv(linspace(0,hs.xdist,s)');
            % end
            r = num_conv(linspace(0,hs.xdist,s)');
            %%
            
            name = filename(1:end-4);
            
            % for dI/dV and current map data
            if type== 0 || type == 1
                
                %Collect all useful into a structure
                data.map = map;
                data.type = type; %define data type (conductance, current, topo)
                data.ave = squeeze(sum(sum(map)))/s/s;
                data.name = name; %attach the file name to the structure
                data.r = r;
                data.coord_type = 'r'; %real space data is r, k space data is k;
                data.e =num_conv(linspace(hs.s_startvolt,hs.s_endvolt,hs.ilayers));
                data.info = hs;
                data.ops = '';
                data.var = var;
                
                
                %for topographic data
            elseif type == 2 || type == 3
                data.topo1 = map;
                data.map = prep_topo(map);
                data.e = 0;
                data.type = type;
                data.name = filename(1:end-4);
                data.r = r;
                data.coord_type = 'r';
                data.info = hs;
                data.ops = '';
                data.var = var;
                
            end
            
        end

    end
    function plotdata(data)
        if isempty(data)
            disp('Load Failed');
            return;
        end
        assignin('base',['obj_' data.name '_' data.var],data); % exports the data to the workspace
        img_obj_viewer_test(data);
        
    end
    function y = num_conv(x)
        %topometrix values are read in with some inherent error in the actual
        %value; e.g. 0.04V is read in as 0.039999999110000V
        %this function converts such number into doubles with 7 decimal place
        %accuracy which will round such numbers to the expected values.
        %digits(7);
        %tmp = vpa(x);
        %y = double(tmp);
        y = round(x*100000000)/100000000;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%Callback Functions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [var,type,pathname,filename] = STM1_Callback(hObject,eventdata)
        close(fh)
        [filen,pathname]=uigetfile('*','Select Data File(*.1FL,*.1fl,*.FFL,*.ffl, *.TFR, *.FFR, *.tfr)','MultiSelect','on');
        %         filename
        pathname
        
        if iscell(filen)==0
            filenames{1}=filen;
        else
            filenames = filen;
        end
        
        for i=1:length(filenames)
            filename = filenames{i};
            
            if filename == 0;
                data = [];
                return;
            end
            filetype = filename(end-2:end);
            cd (pathname);
            switch filetype
                case '1FL'     %conductance map
                    type = 0;
                    var = 'G';
                case '1fl'     %conductance map
                    type = 0;
                    var = 'G';
                case 'FFL'     %current map
                    type = 1;
                    var = 'I';
                case 'ffl'     %current map
                    type = 1;
                    var = 'I';
                case 'TFR'     %topo map
                    type = 2;
                    var = 'T';
                case 'tfr'     %topo map
                    type = 2;
                    var = 'T';
                case 'FFR'     % feedback current map
                    type = 3;
                    var = 'IF';
                case 'DI1'     % point spec
                    type = 4;
                    var = 'PS';
                otherwise
                    var = -1;
                    type = -1;
                    data = '';
                    disp('Invalid Data Type');
                    return;
            end
            data = loadfile(type,var,pathname,filename);
            plotdata(data)
            
        end
            
    end

    function [var,type,pathname,filename] = STM2_Callback(hObject,eventdata)
        close(fh)
        [filename,pathname]=uigetfile('*','Select Data File(*.2FL,*.1FL, *.TFR, *.1FR)');
        pathname
        if filename == 0;
            data = [];
        end
        filetype = filename(end-2:end);
        cd (pathname);
        switch filetype
            case '2FL'     %conductance map
                type = 0;
                var = 'G';
            case '1FL'     %current map
                type = 1;
                var = 'I';
            case 'TFR'     %topo map
                type = 2;
                var = 'T';
            case '1FR' % feedback current map
                type = 3;
                var = 'IF';
            case 'DI1'     % point spec
                type = 4;
                var = 'PS';
            otherwise
                data = '';
                disp('Invalid Data Type');
                return;
        end
        data = loadfile(type,var,pathname,filename);
        plotdata(data)
    end

    function [var,type,pathname,filename] = nanonisSTM1_Callback(hObject,eventdata)
        close(fh)
        [filename,pathname]=uigetfile('*','Select Data File(*.3ds,*.sxm)');
        pathname
        if filename == 0;
            data = [];
            return;
        end
        type = 5;var = 'dummy';

        data = loadfile(type,var,pathname,filename);

    end
end

