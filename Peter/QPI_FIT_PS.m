function QPI_FIT_PS
% QPI_FIT_PS Load a LDOS map which will be Fourier transformed to display
% the QPI pattern. You can also analyze data that was manipulated with
% filters, shear correction, symmetrization etc. The gui allows you to fit
% the data semi-automatically subsequently.

%  Initialize and hide the GUI as it is being constructed.
gf = figure('Visible','off','Units','normalized','Position',[0.1,0.1,0.8,0.8]);

ra = 0.8/0.6;

%% Construct the components of the GUI

% Construct the six axes that will be used to depict the data
% sqra =  uicontrol('Style','text','String','QPI Raw','Units','normalized',...
%            'Position',[0.09,0.62,0.075,0.02]);  
cbqra =  uicontrol('Style','checkbox','Units','normalized','String','QPI Raw',...
           'Position',[0.08,0.62,0.09,0.02],'Max',1,'Min',0,'Value',1);  
qr_a = axes('Units','normalized','Position',[0.025,0.35,0.2,0.2*ra]); % qr_a = qpi raw
axis image;

% sqma =  uicontrol('Style','text','String','QPI Processed','Units','normalized',...
%            'Position',[0.09,0.95,0.075,0.02]);  
cbqma =  uicontrol('Style','checkbox','Units','normalized','String','QPI Processed',...
           'Position',[0.08,0.95,0.09,0.02],'Max',1,'Min',0,'Value',0); 
qm_a = axes('Units','normalized','Position',[0.025,0.51*ra,0.2,0.2*ra]); % qm_a = qpi processed
axis image;

% sqcra =  uicontrol('Style','text','String','Q-Cut Raw','Units','normalized',...
%            'Position',[0.29,0.62,0.075,0.02]); 
cbqcra =  uicontrol('Style','checkbox','Units','normalized','String','Q-Cut Raw',...
           'Position',[0.28,0.62,0.09,0.02],'Max',1,'Min',0,'Value',1);       
qcr_a = axes('Units','normalized','Position',[0.225,0.35,0.2,0.2*ra]); % qcr_a = momentum cut of raw data
axis image;

% sqcma =  uicontrol('Style','text','String','Q-Cut Processed','Units','normalized',...
%            'Position',[0.29,0.95,0.075,0.02]); 
cbqcma =  uicontrol('Style','checkbox','Units','normalized','String','Q-Cut Processed',...
           'Position',[0.28,0.95,0.09,0.02],'Max',1,'Min',0,'Value',0); 
qcm_a = axes('Units','normalized','Position',[0.225,0.51*ra,0.2,0.2*ra]); % qcm_a = momentum cut of processed data 
axis image;

secra =  uicontrol('Style','text','String','E-Cut Raw','Units','normalized',...
           'Position',[0.49,0.62,0.075,0.02]); 
ecr_a = axes('Units','normalized','Position',[0.425,0.35,0.2,0.2*ra]); % ecr_a = energy cut of raw data
axis image;

secma =  uicontrol('Style','text','String','E-Cut Processed','Units','normalized',...
           'Position',[0.49,0.95,0.075,0.02]); 
ecm_a = axes('Units','normalized','Position',[0.425,0.51*ra,0.2,0.2*ra]); % ecm_a = energy cut of processed data
axis image;


% Construct a table with the fit parameters, LL = Lower Limit, UL = Upper
% Limit
dat = zeros(1,6);
cnames = {'Peak-Pos.(PP)','LL-PP','UL-PP','Peak-Width (PW)','LL-PW','UL-PW'};
htable = uitable('Parent',gf,'Data', dat,'ColumnName',cnames,'Units','normalized','Position', [0.14,0.025,0.5,0.2]);

% Construct Buttons
% Three buttons for "Fit", "Add Peak", "Delete Peak"
hfit =  uicontrol('Style','pushbutton','String','Fit','Units','normalized',...
           'Position',[0.05,0.175,0.075,0.05]);
hap =  uicontrol('Style','pushbutton','String','Add Peak','Units','normalized',...
           'Position',[0.05,0.1,0.075,0.05]);
hdp =  uicontrol('Style','pushbutton','String','Delete Peak','Units','normalized',...
           'Position',[0.05,0.025,0.075,0.05]);

% Five Buttons "Load Data", "Process Data", "Select Palette", "Adjust
% Histogram", "Invert Color"
hld =  uicontrol('Style','pushbutton','String','Load Data','Units','normalized',...
           'Callback',{@load_data_button_Callback},'Position',[0.63,0.9,0.07,0.05]);
       
hcolor = uicontrol('Style','pushbutton','String','Select Palette','Units','normalized',...
           'Position',[0.63,0.84,0.07,0.05],'Callback',{@sel_pal_Callback});
       
hhisto = uicontrol('Style','pushbutton','String','Adjust Histogram','Units','normalized',...
           'Position',[0.63,0.72,0.07,0.05]);
       
hinvert = uicontrol('Style','pushbutton','String','Invert Color','Units','normalized',...
           'Position',[0.63,0.78,0.07,0.05],'Callback',{@invert_color_Callback});
       
       
hfeenstra =  uicontrol('Style','pushbutton','String','Feenstra','Units','normalized',...
           'Position',[0.7,0.9,0.07,0.05],'Callback',{@feenstra_Callback}); 
     
holnorm =  uicontrol('Style','pushbutton','String','Single-I-layer-norm.','Units','normalized',...
           'Position',[0.7,0.84,0.07,0.05],'Callback',{@singlelayernorm_Callback}); 
       
hshear =  uicontrol('Style','pushbutton','String','Shear Correct','Units','normalized',...
           'Position',[0.7,0.78,0.07,0.05]); 
       
hcrop =  uicontrol('Style','pushbutton','String','Crop Data','Units','normalized',...
           'Position',[0.7,0.72,0.07,0.05],'Callback',{@crop_data_Callback}); 
       
hsymm =  uicontrol('Style','pushbutton','String','Symmetrize','Units','normalized',...
           'Position',[0.77,0.9,0.07,0.05]); 
     
hrmftc =  uicontrol('Style','pushbutton','String','Remove FT center','Units','normalized',...
           'Position',[0.77,0.84,0.07,0.05]);
       
hderiv =  uicontrol('Style','pushbutton','String','d/dE','Units','normalized',...
           'Position',[0.77,0.78,0.07,0.05],'Callback',{@energyderivative_Callback}); 
       
% One Pop-up menu to choose between a linear and a logarithmic scale for
% the cuts
spmh =  uicontrol('Style','text','String','Choose scale for plot of cut:','Units','normalized',...
           'Position',[0.265,0.3,0.125,0.02]);  
pmh = uicontrol(gf,'Style','popupmenu',...
                'String',{'Linear','Logarithmic'},'Units','normalized',...
                'Value',1,'Position',[0.28,0.25,0.075,0.05]);
       
       
% One Pushbutton "Create Cut" and for text entry fields for the start and
% end pixel of the cut, the angle and the thickness used in averaging for
% this cut
hcc =  uicontrol('Style','pushbutton','String','Create Cut','Units','normalized',...
           'Position',[0.63,0.515,0.075,0.05]);
       
sca =  uicontrol('Style','text','String','Angle','Units','normalized',...
           'Position',[0.63,0.49,0.075,0.02]);  
       
hca =  uicontrol('Style','edit','String','-','Units','normalized',...
           'Position',[0.63,0.46,0.075,0.025]);
       
sat =  uicontrol('Style','text','String','Ave. thickness','Units','normalized',...
           'Position',[0.73,0.49,0.075,0.02]); 
       
hat =  uicontrol('Style','edit','String','-','Units','normalized',...
           'Position',[0.73,0.46,0.075,0.025]);
       
ssp =  uicontrol('Style','text','String','Start Pixel','Units','normalized',...
           'Position',[0.63,0.6,0.075,0.02]);
       
hsp =  uicontrol('Style','edit','String','-','Units','normalized',...
           'Position',[0.63,0.57,0.075,0.025]); 

sep =  uicontrol('Style','text','String','End Pixel','Units','normalized',...
           'Position',[0.73,0.6,0.075,0.02]);
       
hep =  uicontrol('Style','edit','String','-','Units','normalized',...
           'Position',[0.73,0.57,0.075,0.025]);
       
% One pushbutton for creating cuts that average over a certain angular
% spread. To text entry fields for the start and end angle.
ssa =  uicontrol('Style','text','String','Start angle','Units','normalized',...
           'Position',[0.63,0.37,0.075,0.02]);  
       
hsa =  uicontrol('Style','edit','String','-','Units','normalized',...
           'Position',[0.63,0.34,0.075,0.025]); 
       
sea =  uicontrol('Style','text','String','End angle','Units','normalized',...
           'Position',[0.73,0.37,0.075,0.02]);  
       
hea =  uicontrol('Style','edit','String','-','Units','normalized',...
           'Position',[0.73,0.34,0.075,0.025]); 
       
hcac =  uicontrol('Style','pushbutton','String','Create radial ave. cut',...
           'Units','normalized','Position',[0.63,0.4,0.1,0.05]); 
       
% One slider to change between the energy layers
sslider =  uicontrol('Style','text','String','Change Energy','Units','normalized',...
           'Position',[0.0975,0.3,0.06,0.02]);  
hslider =  uicontrol('Style','slider', 'Callback',{@slider_Callback},...
           'Units','normalized','Max',100,'Min',0,'Value',0,...
                'SliderStep',[0.05 0.2],'Position',[0.09,0.27,0.075,0.025]); 
% static text entries for the min, max and current energy value of the qpi
% signal
ssenmin =  uicontrol('Style','text','String','Min. Energy','Units','normalized',...
           'Position',[0.05,0.3,0.04,0.02]);  
ssenmax =  uicontrol('Style','text','String','Max. Energy','Units','normalized',...
           'Position',[0.165,0.3,0.04,0.02]);  
ssencv =  uicontrol('Style','text','String','Current Value','Units','normalized',...
           'Position',[0.05,0.24,0.05,0.02]);   
       
ssenmine =  uicontrol('Style','text','String','-','Units','normalized',...
           'Position',[0.05,0.27,0.0375,0.02]);  
ssenmaxe =  uicontrol('Style','text','String','-','Units','normalized',...
           'Position',[0.1675,0.27,0.0375,0.02]);  
ssencve =  uicontrol('Style','text','String','-','Units','normalized',...
           'Position',[0.11,0.24,0.05,0.02]);           
    
F = [];
Fp = [];
setappdata(qr_a,'Fourier',F);
setappdata(qm_a,'Fourier',Fp);
       
%% Program the Callbacks for the various buttons, text entry fields,
%% sliders, tables, axes....

% load_data_button_Callback executes when the "Load Data"-button is pushed.
% It loads all 4 files (LDOS, Current, Current feedback and Topograph into
% the cell-structure datacell. Then it subtracts a constant fitted constant
% component of the LDOS (q=0 component), and calculates the FT. The first
% layer of this FT is displayed in the QPI-raw axes.
    function load_data_button_Callback(source,eventdata)
        % cell that contains (LDOS, Current, Current feedback and
        % Topograph)
        datacell = read_map_v3;
        % load LDOS into data;
        data = datacell{1};
        % Fit the q=0 component, and subtract it from the LDOS-layers
        data = polyn_subtract2(data,0);
        % claculate the amplitude of the FT of the raw LDOS-map
        F = fourier_transform2d(data,'none','amplitude','ft');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qr_a);
        img_plot4(F.map(:,:,1));
        % set the min, max and current value for the slider static text
        % entries
        set(ssenmine,'String',[num2str(data.e(1)*1000),' meV']);
        set(ssenmaxe,'String',[num2str(data.e(end)*1000),' meV']);
        set(ssencve,'String',[num2str(data.e(1)*1000),' meV']);
        % calculate the minimum slider step "slidmin" and set it, as well
        % as the min, max and current value of the slider
        slidmin = abs(data.e(1)-data.e(2))/abs(data.e(end)-data.e(1));
        set(hslider,'Max',data.e(end),'Min',data.e(1),'Value',data.e(1),...
        'SliderStep',[slidmin slidmin*10]);
        % Save the FT and the loaded data as application data into the two
        % handles "qr_a" and "hld"
        setappdata(qr_a,'Fourier',F);
        setappdata(hld,'LDOS',datacell);
        
        Fp = getappdata(qm_a,'Fourier');
        Fp = F;
        setappdata(qm_a,'Fourier',Fp);
        axes(qm_a);
        img_plot4(Fp.map(:,:,1));
    end

% Callback for the slider: Slider is used to change the energy layer of the
% QPI
    function slider_Callback(source,eventdata)
        % Get the current value of the slider and write it into the static
        % text field
        newcv = get(hslider,'Value');
        set(ssencve,'String',[num2str(newcv*1000),' meV']);
        % Get the raw FT from the application data, and display the current
        % energy layer in the raw QPI axes
        F = getappdata(qr_a,'Fourier');
        enva = round(abs(newcv-F.e(1))/abs(F.e(1)-F.e(2)));
        
        axes(qr_a);
        col_map = colormap(qr_a);
        
        img_plot4(F.map(:,:,1+enva),col_map);

        Fp = getappdata(qm_a,'Fourier');
        
        axes(qm_a);
        col_map1 = colormap(qm_a);
        img_plot4(Fp.map(:,:,1+enva),col_map1);

    end

    function sel_pal_Callback(source,eventdata)
        cf =gcf;
        col_map = colormap(qr_a);
        palette_sel_dialogue(cf,col_map); 
    end

    function invert_color_Callback(source,eventdata)
        set(gf,'CurrentAxes',qr_a);
        cf = gcf;
        c_map = get(cf,'Colormap');
        inv_cmap = c_map(end:-1:1,:);
        set(cf,'Colormap',inv_cmap);
    end

    function crop_data_Callback(source,eventdata)
        datacell = getappdata(hld,'LDOS');
        [nG, nI, nIF, nT] = crop_QPI_PS(datacell);
        datacell{1} = nG;
        datacell{2} = nI;
        datacell{3} = nIF;
        datacell{4} = nT;
        setappdata(hld,'LDOS',datacell);
        
        % Fit the q=0 component, and subtract it from the LDOS-layers
        data = polyn_subtract2(nG,0);
        % claculate the amplitude of the FT of the raw LDOS-map
        F = fourier_transform2d(data,'none','amplitude','ft');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qr_a);
        img_plot4(F.map(:,:,1));
        % set the min, max and current value for the slider static text
        % entries
        set(ssenmine,'String',[num2str(data.e(1)*1000),' meV']);
        set(ssenmaxe,'String',[num2str(data.e(end)*1000),' meV']);
        set(ssencve,'String',[num2str(data.e(1)*1000),' meV']);
        % Save the FT and the loaded data as application data into the two
        % handles "qr_a" and "hld"
        setappdata(qr_a,'Fourier',F);
        
        Fp = getappdata(qm_a,'Fourier');
        Fp = F;
        setappdata(qm_a,'Fourier',Fp);
        axes(qm_a);
        img_plot4(Fp.map(:,:,1));
    end

    function feenstra_Callback(source,eventdata)
       datacell = getappdata(hld,'LDOS');
       % Create the Feenstra data set and a string containing all energy
        % layers used in the listdlg that asks for the current layers used for
        % normalization
        nG = datacell{1};
        nI = datacell{2};
        nFG = nG;
        for i=1:size((nG.e), 2)
            str{i} = num2str(nG.e(i));
            nFG.map(:,:,i) = nFG.map(:,:,i)./nI.map(:,:,i);
        end
        datacellf = datacell;
        datacellf{1} = nFG;
        setappdata(hfeenstra,'LDOS',datacellf);
        % Fit the q=0 component, and subtract it from the LDOS-layers
        data = polyn_subtract2(nFG,0);
        % claculate the amplitude of the FT of the raw LDOS-map
        Fp = fourier_transform2d(data,'none','amplitude','ft');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qm_a);
        img_plot4(Fp.map(:,:,1));
        setappdata(qm_a,'Fourier',Fp);
        F = getappdata(qr_a,'Fourier');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qr_a);
        img_plot4(F.map(:,:,1));
        % set the min, max and current value for the slider static text
        % entries
        set(ssenmine,'String',[num2str(data.e(1)*1000),' meV']);
        set(ssenmaxe,'String',[num2str(data.e(end)*1000),' meV']);
        set(ssencve,'String',[num2str(data.e(1)*1000),' meV']);
    end

    function singlelayernorm_Callback(source,eventdata)
        datacell = getappdata(hld,'LDOS');
       % Create the Feenstra data set and a string containing all energy
        % layers used in the listdlg that asks for the current layers used for
        % normalization
        nG = datacell{1};
        nI = datacell{2};

        for i=1:size((nG.e), 2)
            str{i} = num2str(nG.e(i));
        end
        % Choose the current layers to normalize the data to
        [s,v] = listdlg('PromptString','Select energy layers in meV to normalize to:',...
                    'SelectionMode','multiple',...
                    'ListString',str);

        % Create the to one current layer normalized data
        nOLG = nG;

        if v ==1 
                for j=1:size((nG.e), 2)
                    olmap(:,:,j) = nG.map(:,:,j)./nI.map(:,:,s);
                end
                nOLG.map = olmap;
        end
        
        datacellsln = datacell;
        datacellsln{1} = nOLG;
        setappdata(hfeenstra,'LDOS',datacellsln);
        % Fit the q=0 component, and subtract it from the LDOS-layers
        data = polyn_subtract2(nOLG,0);
        % claculate the amplitude of the FT of the raw LDOS-map
        Fp = fourier_transform2d(data,'none','amplitude','ft');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qm_a);
        img_plot4(Fp.map(:,:,1));
        setappdata(qm_a,'Fourier',Fp);
        F = getappdata(qr_a,'Fourier');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qr_a);
        img_plot4(F.map(:,:,1));
        % set the min, max and current value for the slider static text
        % entries
        set(ssenmine,'String',[num2str(data.e(1)*1000),' meV']);
        set(ssenmaxe,'String',[num2str(data.e(end)*1000),' meV']);
        set(ssencve,'String',[num2str(data.e(1)*1000),' meV']);
        
    end

    function energyderivative_Callback(source,eventdata)
        datacell = getappdata(hld,'LDOS');
       % Create the Feenstra data set and a string containing all energy
        % layers used in the listdlg that asks for the current layers used for
        % normalization
        nG = datacell{1};
        prompt={'Specify Derivative Order'};
        name='Map Derivative in Energy';
        numlines=1;
        defaultanswer= {'1'};
        answer = inputdlg(prompt,name,numlines,defaultanswer); 
        der_order = str2double(answer);
        smooth_width = 1;
        nGD = map_deriv(nG,der_order,smooth_width);
        datacellsln = datacell;
        datacellsln{1} = nGD;
        setappdata(hfeenstra,'LDOS',datacellsln);
        % Fit the q=0 component, and subtract it from the LDOS-layers
        data = polyn_subtract2(nGD,0);
        % claculate the amplitude of the FT of the raw LDOS-map
        Fp = fourier_transform2d(data,'none','amplitude','ft');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qm_a);
        img_plot4(Fp.map(:,:,1));
        setappdata(qm_a,'Fourier',Fp);
        F = getappdata(qr_a,'Fourier');
        % plot the amplitude of the FT in the raw QPI axes
        axes(qr_a);
        img_plot4(F.map(:,:,1));
        % set the min, max and current value for the slider static text
        % entries
        set(ssenmine,'String',[num2str(data.e(1)*1000),' meV']);
        set(ssenmaxe,'String',[num2str(data.e(end)*1000),' meV']);
        set(ssencve,'String',[num2str(data.e(1)*1000),' meV']);
    end

    function adjust_histogram_Callback(source,eventdata)
        
    end

%Make the GUI visible
set(gf, 'Visible', 'on');
end