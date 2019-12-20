function extraction_viewer_tool3(in_data,fit_struct,QPInocore)

in_megadata.data = in_data;
in_megadata.fit = fit_struct;
in_megadata.QPInocore = QPInocore;
xx = 0.0193/(1.98*sqrt(2))*linspace(-128,128,257);
fh=figure('Name', ['Extraction tool'],...
    'units','normalized', ...
    'Position',[0.1,0.1,0.85,0.85],...
    'Color',[0.6 0.6 0.6],...
    'MenuBar', 'none',...
    'NumberTitle', 'off',...
    'Resize','on');
% color_map_path = 'C:\Users\feynman\Documents\MATLAB\Analysis Code\MATLAB\STM View\Color Maps\';  
color_map_path= 'C:\Users\Peter\Documents\MATLAB\STM\MATLAB\STM View\Color Maps\'; 
color_map = struct2cell(load([color_map_path 'Blue2.mat']));
color_map = color_map{1};

guidata(fh,in_megadata);
obj_energy = getfield(guidata(fh),'data','e');
angl = getfield(guidata(fh),'data','angles');
peaks = [1 2];
peaksv = [1 2 3];
qs = in_data.r(:,1);

axis off
bias = uicontrol('Style','text',...
    'String','Bias (mV)',...
    'Position',[3,25,80,20]);

energy_list = uicontrol('Style','popupmenu',...
    'String', num2str(1000*obj_energy','%10.2f'),...
    'Value', 1,...
    'Position',[3,0,80,25],...
    'Callback',{@plot_Callback});

angle_lbl = uicontrol('Style','text',...
    'String','Angle (deg)',...
    'Position',[100,25,80,20]);

angle_list = uicontrol('Style','popupmenu',...
    'String', num2str(angl','%10.2f'),...
    'Value', 1,...
    'Position',[100,0,80,25],...
    'Callback',{@plot_Callback});

q_label = uicontrol('Style','text',...
    'String','q',...
    'Position',[1100,25,80,20]);

q_list = uicontrol('Style','popupmenu',...
    'String', num2str(qs,'%10.3f'),...
    'Value', 1,...
    'Position',[1100,0,80,25],...
    'Callback',{@plot_Callback});

peak_lbl = uicontrol('Style','text',...
    'String','Peak',...
    'Position',[200,25,80,20]);

peak_list = uicontrol('Style','popupmenu',...
    'String', num2str(peaks','%i'),...
    'Value', 1,...
    'Position',[200,0,80,25],...
    'Callback',{@plot_Callback});

peakv_lbl = uicontrol('Style','text',...
    'String','Peak Vert',...
    'Position',[200,65,80,20]);

peakv_list = uicontrol('Style','popupmenu',...
    'String', num2str(peaksv','%i'),...
    'Value', 1,...
    'Position',[200,40,80,25],...
    'Callback',{@plot_Callback});

align([bias, energy_list],'Center','None');
align([angle_lbl, angle_list],'Center','None');

height_edit = uicontrol(fh,'Style','Edit',...
    'String',num2str(1000),...
    'Position',[300 0 80 25]);
width_edit = uicontrol(fh,'Style','Edit',...
    'String',num2str(0.1),...
    'Position',[400 0 80 25]);
location_edit = uicontrol(fh,'Style','Edit',...
    'String',num2str(0.3),...
    'Position',[500 0 80 25]);
offset_edit = uicontrol(fh,'Style','Edit',...
    'String',num2str(0),...
    'Position',[600 0 80 25]);
low_range_edit = uicontrol(fh,'Style','Edit',...
    'String',num2str(0.2),...
    'Position',[700 0 80 25]);
high_range_edit = uicontrol(fh,'Style','Edit',...
    'String',num2str(0.45),...
    'Position',[800 0 80 25]);

height_editv = uicontrol(fh,'Style','Edit',...
    'String',num2str(1000),...
    'Position',[300 40 80 25]);
width_editv = uicontrol(fh,'Style','Edit',...
    'String',num2str(0.1),...
    'Position',[400 40 80 25]);
location_editv = uicontrol(fh,'Style','Edit',...
    'String',num2str(0.3),...
    'Position',[500 40 80 25]);
offset_editv = uicontrol(fh,'Style','Edit',...
    'String',num2str(0),...
    'Position',[600 40 80 25]);
low_range_editv = uicontrol(fh,'Style','Edit',...
    'String',num2str(-2),...
    'Position',[700 40 80 25]);
high_range_editv = uicontrol(fh,'Style','Edit',...
    'String',num2str(5),...
    'Position',[800 40 80 25]);


height_label = uicontrol(fh,'Style','text',...
    'String','Height',...
    'Position',[300 25 80 20]);
width_label = uicontrol(fh,'Style','text',...
    'String','Width',...
    'Position',[400 25 80 20]);
location_label = uicontrol(fh,'Style','text',...
    'String','Location',...
    'Position',[500 25 80 20]);
offset_label = uicontrol(fh,'Style','text',...
    'String','Offset',...
    'Position',[600 25 80 20]);
low_range_label = uicontrol(fh,'Style','text',...
    'String','Lower Range',...
    'Position',[700 25 80 20]);
high_range_label = uicontrol(fh,'Style','text',...
    'String','Upper Range',...
    'Position',[800 25 80 20]);

height_labelv = uicontrol(fh,'Style','text',...
    'String','Height V',...
    'Position',[300 65 80 20]);
width_labelv = uicontrol(fh,'Style','text',...
    'String','Width V',...
    'Position',[400 65 80 20]);
location_labelv = uicontrol(fh,'Style','text',...
    'String','Location V',...
    'Position',[500 65 80 20]);
offset_labelv = uicontrol(fh,'Style','text',...
    'String','Offset V',...
    'Position',[600 65 80 20]);
low_range_labelv = uicontrol(fh,'Style','text',...
    'String','Lower Range V',...
    'Position',[700 65 80 20]);
high_range_labelv = uicontrol(fh,'Style','text',...
    'String','Upper Range V',...
    'Position',[800 65 80 20]);


fit_but = uicontrol(fh,'Style','pushbutton',...
    'String','Fit',...
    'Position',[900 0 80 20],...
    'Callback',(@fit_Callback));

fit_but2 = uicontrol(fh,'Style','pushbutton',...
    'String','Fit Vert',...
    'Position',[900 50 80 20],...
    'Callback',(@fit_Callback2));

save_but = uicontrol(fh,'Style','pushbutton',...
    'String','Save',...
    'Position',[900 25 80 20],...
    'Callback',(@save_Callback));

clear_but = uicontrol(fh,'Style','pushbutton',...
    'String','Clear H',...
    'Position',[1000 25 80 20],...
    'Callback',(@clear_Callback));

clear_but2 = uicontrol(fh,'Style','pushbutton',...
    'String','Clear V',...
    'Position',[1000 50 80 20],...
    'Callback',(@clear_Callback2));

points_check = uicontrol(fh,'Style','checkbox',...
    'String','Show Points',...
    'Position',[1000 0 80 20],...
    'Callback',(@plot_Callback));

    function fit_Callback(hObject,eventdata)
        
        h = str2double(get(height_edit,'String'));
        w = str2double(get(width_edit,'String'));
        loc = str2double(get(location_edit,'String'));
        offset = str2double(get(offset_edit,'String'));
        a = str2double(get(low_range_edit,'String'));
        b = str2double(get(high_range_edit,'String'));
        
        megadata = guidata(fh);
        data = megadata.data;
        layer=get(energy_list,'Value');
        angle=get(angle_list,'Value');
        pk_idx=get(peak_list,'Value');
        
        inds = find(data.r(:,angle)==0);
        if(numel(inds)>1)
            ind = inds(2)-1;
        else
            ind = length(data.r(:,angle));
        end
        
        [fit_spectrum,x_fit, p] = lorentzian_fit_v2(data.r(1:ind,angle),data.nocore(1:ind,layer,angle),a,b,[h loc w offset]);
        subplot(2,3,4);
        plot(data.r(1:ind,angle),data.nocore(1:ind,layer,angle),'.k',x_fit,fit_spectrum,'.r');
        c = coeffvalues(p);
        peak1 = c(2);
        hold on
        plot([peak1 peak1],ylim,'-g');
        hold off
        subplot(2,3,1);
        plot(data.r(1:ind,angle),data.wcore(1:ind,layer,angle),'.k');
        hold on
        plot([peak1 peak1],ylim,'-g');
        hold off
        h = c(1);
        w = c(3);
        loc = c(2);
        offset = c(4);
        set(height_edit,'String',num2str(h));
        set(width_edit,'String',num2str(w));
        set(location_edit,'String',num2str(loc));
        set(offset_edit,'String',num2str(offset));
        if(isempty(megadata.fit))
            nrows = numel(angl);
            ncols = numel(obj_energy);
            ncolsv = numel(data.r(:,angle));
            npeaks = numel(peaks);
            npeaksv = numel(peaksv);
            megadata.fit.h = zeros(nrows,ncols,npeaks);
            megadata.fit.w = zeros(nrows,ncols,npeaks);
            megadata.fit.loc = zeros(nrows,ncols,npeaks);
            megadata.fit.offset = zeros(nrows,ncols,npeaks);
            megadata.fit.a = zeros(nrows,ncols,npeaks);
            megadata.fit.b = zeros(nrows,ncols,npeaks);
            
            megadata.fit.hv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.wv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.locv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.offsetv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.av = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.bv = zeros(nrows,ncolsv,npeaksv);
        end
        megadata.fit.h(angle,layer,pk_idx)=h;
        megadata.fit.w(angle,layer,pk_idx)=w;
        megadata.fit.loc(angle,layer,pk_idx)=loc;
        megadata.fit.offset(angle,layer,pk_idx)=offset;
        megadata.fit.a(angle,layer,pk_idx)=a;
        megadata.fit.b(angle,layer,pk_idx)=b;
        
        %update guidata
        guidata(fh,megadata);     
    end

function fit_Callback2(hObject,eventdata)
        
        h = str2double(get(height_editv,'String'));
        w = str2double(get(width_editv,'String'));
        loc = str2double(get(location_editv,'String'));
        offset = str2double(get(offset_editv,'String'));
        a = str2double(get(low_range_editv,'String'));
        b = str2double(get(high_range_editv,'String'));
        
        megadata = guidata(fh);
        data = megadata.data;
        angle=get(angle_list,'Value');
        q_ind=get(q_list,'Value');
        pk_idx=get(peakv_list,'Value');
        
%         inds = find(data.r(:,angle)==0);
%         if(numel(inds)>1)
%             ind = inds(2)-1;
%         else
%             ind = length(data.r(:,angle));
%         end
        
        [fit_spectrum,x_fit, p] = lorentzian_fit_v2(1000*obj_energy',data.wcore(q_ind,:,angle)',a,b,[h loc w offset]);
        subplot(2,3,3);
        plot(1000*obj_energy,data.wcore(q_ind,:,angle),'.k',x_fit,fit_spectrum,'.r');
        c = coeffvalues(p);
        peak1 = c(2);
        hold on
        plot([peak1 peak1],ylim,'-g');
        hold off
        subplot(2,3,6);
        plot(1000*obj_energy,data.nocore(q_ind,:,angle),'.k');
        hold on
        plot([peak1 peak1],ylim,'-g');
        hold off
        h = c(1);
        w = c(3);
        loc = c(2);
        offset = c(4);
        set(height_editv,'String',num2str(h));
        set(width_editv,'String',num2str(w));
        set(location_editv,'String',num2str(loc));
        set(offset_editv,'String',num2str(offset));
         if(isempty(megadata.fit))
            nrows = numel(angl);
            ncols = numel(obj_energy);
            ncolsv = numel(data.r(:,angle));
            npeaks = numel(peaks);
            npeaksv = numel(peaksv);
            megadata.fit.h = zeros(nrows,ncols,npeaks);
            megadata.fit.w = zeros(nrows,ncols,npeaks);
            megadata.fit.loc = zeros(nrows,ncols,npeaks);
            megadata.fit.offset = zeros(nrows,ncols,npeaks);
            megadata.fit.a = zeros(nrows,ncols,npeaks);
            megadata.fit.b = zeros(nrows,ncols,npeaks);
            
            megadata.fit.hv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.wv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.locv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.offsetv = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.av = zeros(nrows,ncolsv,npeaksv);
            megadata.fit.bv = zeros(nrows,ncolsv,npeaksv);
         end
        megadata.fit.hv(angle,q_ind,pk_idx)=h;
        megadata.fit.wv(angle,q_ind,pk_idx)=w;
        megadata.fit.locv(angle,q_ind,pk_idx)=loc;
        megadata.fit.offsetv(angle,q_ind,pk_idx)=offset;
        megadata.fit.av(angle,q_ind,pk_idx)=a;
        megadata.fit.bv(angle,q_ind,pk_idx)=b;
%         
        %update guidata
        guidata(fh,megadata);     
    end

    function plot_Callback(hObject,eventdata)
        megadata = guidata(fh);
        data = megadata.data;
        QPInc = megadata.QPInocore;
        layer=get(energy_list,'Value');
        angle=get(angle_list,'Value');
        pk_idx=get(peak_list,'Value');
        pkv_idx=get(peakv_list,'Value');
        flag = get(points_check,'Value');
        qs = data.r(:,angle);
        set(q_list,'String',num2str(qs,'%10.3f'));
        q_ind = get(q_list,'Value');
        
        inds = find(data.r(:,angle)==0);
        if(numel(inds)>1)
            ind = inds(2)-1;
        else
            ind = length(data.r(:,angle));
        end
        
        %pcolor(data.map(:,:,layer));
        %imagesc((data.map(:,:,layer)));
        subplot(2,3,5);
        imagesc(data.r(1:ind,angle),1000*obj_energy,data.nocore(1:ind,:,angle)');
        set(gca,'YDir','normal');
        colormap(color_map); shading flat;
        hold on
        if(flag)
            %horizontal fits
            if(~isempty(megadata.fit))
                if(~(sum(sum(megadata.fit.h(angle,:,:)))==0))
                    for j =1:length(peaks)
                        for i=1:length(obj_energy)
                            if(~(megadata.fit.h(angle,i,j)==0))
                                loc = megadata.fit.loc(angle,i,j);
                                plot(loc,1000*obj_energy(i),'.r','MarkerSize',14);
                            end
                        end
                    end
                end
            end
            %vertical fits
            if(~isempty(megadata.fit))
                if(~(sum(sum(megadata.fit.hv(angle,:,:)))==0))
                    for j =1:length(peaksv)
                        for i=1:length(data.r(1:ind,angle))
                            if(~(megadata.fit.hv(angle,i,j)==0))
                                locv = megadata.fit.locv(angle,i,j);
                                if(j==1)
                                    plot(data.r(i,angle),locv,'.y','MarkerSize',14);
                                else if(j==2)
                                       plot(data.r(i,angle),locv,'.c','MarkerSize',14);
                                    else
                                        plot(data.r(i,angle),locv,'.g','MarkerSize',14);
                                    end
                                end
                            end
                        end
                    end
                end
            end
            plot(xlim,[1000*obj_energy(layer) 1000*obj_energy(layer)],'-g');
            plot([qs(q_ind) qs(q_ind)],ylim,'-g');
        end
        hold off
        
        subplot(2,3,6);
        plot(1000*obj_energy,data.nocore(q_ind,:,angle),'.k');
        
        subplot(2,3,3);
        plot(1000*obj_energy,data.wcore(q_ind,:,angle),'.k');
        if(~isempty(megadata.fit))
            if(~(megadata.fit.hv(angle,q_ind,pkv_idx)==0))
                h = megadata.fit.hv(angle,q_ind,pkv_idx);
                w = megadata.fit.wv(angle,q_ind,pkv_idx);
                loc = megadata.fit.locv(angle,q_ind,pkv_idx);
                offset = megadata.fit.offsetv(angle,q_ind,pkv_idx);
                a = megadata.fit.av(angle,q_ind,pkv_idx);
                b = megadata.fit.bv(angle,q_ind,pkv_idx);
                x = linspace(a,b,50);
                y = lorentzian_f(x,[h loc w offset]);
                hold on
                plot(x,y,'-r',[loc loc],ylim,'-g');
                hold off
                subplot(2,3,6);
                hold on
                plot([loc loc],ylim,'-g');
                hold off
                set(height_editv,'String',num2str(h));
                set(width_editv,'String',num2str(w));
                set(location_editv,'String',num2str(loc));
                set(offset_editv,'String',num2str(offset));
                set(low_range_editv,'String',num2str(a));
                set(high_range_editv,'String',num2str(b));
            end
        end
        
        
        subplot(2,3,1);
        plot(data.r(1:ind,angle),data.wcore(1:ind,layer,angle),'.k');
        
        subplot(2,3,4);
        plot(data.r(1:ind,angle),data.nocore(1:ind,layer,angle),'.k');
        if(~isempty(megadata.fit))
            if(~(megadata.fit.h(angle,layer,pk_idx)==0))
                h = megadata.fit.h(angle,layer,pk_idx);
                w = megadata.fit.w(angle,layer,pk_idx);
                loc = megadata.fit.loc(angle,layer,pk_idx);
                offset = megadata.fit.offset(angle,layer,pk_idx);
                a = megadata.fit.a(angle,layer,pk_idx);
                b = megadata.fit.b(angle,layer,pk_idx);
                x = linspace(a,b,50);
                y = lorentzian_f(x,[h loc w offset]);
                hold on
                plot(x,y,'-r',[loc loc],ylim,'-g');
                hold off
                subplot(2,3,1);
                hold on
                plot([loc loc],ylim,'-g');
                hold off
                set(height_edit,'String',num2str(h));
                set(width_edit,'String',num2str(w));
                set(location_edit,'String',num2str(loc));
                set(offset_edit,'String',num2str(offset));
                set(low_range_edit,'String',num2str(a));
                set(high_range_edit,'String',num2str(b));
            end
        end
        subplot(2,3,2);
        imagesc(xx,xx,QPInc.map(:,:,layer));
        colormap(color_map); axis off; axis equal; shading flat;
        hold on
        if(flag)
            if(~isempty(megadata.fit))
                if(~(sum(sum(megadata.fit.h(:,layer,:)))==0))
                    for j =1:length(peaks)
                        for i=1:length(angl)
                            if(~(megadata.fit.h(i,layer,j)==0))
                                loc = megadata.fit.loc(i,layer,j);
                                y1 = loc*cos(pi*angl(i)/180);
                                x1 = loc*sin(pi*angl(i)/180);
                                y_temp = [y1 x1];
                                x_temp = [x1 y1];
                                y_pts=[y_temp y_temp -y_temp -y_temp];
                                x_pts = [x_temp -x_temp x_temp -x_temp];
                                plot(x_pts,y_pts,'.r','MarkerSize',14);
                                
                            end
                        end
                    end
                end
            end
        end
        hold off
    end
    function save_Callback(hObject,eventdata)
        megadata = guidata(fh);
        fit = megadata.fit;
        save('D:/URU2Si2/G90314A13fit_struct.mat','fit');
    end
    function clear_Callback(hObject,eventdata)
        megadata = guidata(fh);
        layer=get(energy_list,'Value');
        angle=get(angle_list,'Value');
        pk_idx=get(peak_list,'Value');
        fit = megadata.fit;
        fit.h(angle,layer,pk_idx)=0;
        fit.w(angle,layer,pk_idx)=0;
        fit.loc(angle,layer,pk_idx)=0;
        fit.offset(angle,layer,pk_idx)=0;
        fit.a(angle,layer,pk_idx)=0;
        fit.b(angle,layer,pk_idx)=0;
        megadata.fit = fit;
        %update guidata
        guidata(fh,megadata); 
        plot_Callback();
    end
    function clear_Callback2(hObject,eventdata)
        megadata = guidata(fh);
        q_ind=get(q_list,'Value');
        angle=get(angle_list,'Value');
        pkv_idx=get(peakv_list,'Value');
        fit = megadata.fit;
        fit.hv(angle,q_ind,pkv_idx)=0;
        fit.wv(angle,q_ind,pkv_idx)=0;
        fit.locv(angle,q_ind,pkv_idx)=0;
        fit.offsetv(angle,q_ind,pkv_idx)=0;
        fit.av(angle,q_ind,pkv_idx)=0;
        fit.bv(angle,q_ind,pkv_idx)=0;
        megadata.fit = fit;
        %update guidata
        guidata(fh,megadata); 
        plot_Callback();
    end
end

