% 2019-12-12 YXC
% opens up a GUI with the selected .dat file shown, with options to scroll
% through the folder.

function [struct,bias,conductance] = open_point_spectrum(filename,pathname,varargin)

% pathname = "C:\Users\chong\Documents\MATLAB\STMdata\Runc75\NbTip_on_NbSe2\";
% filename = "20191209_005.dat";

wholefilename = strcat(pathname,filename);

fid = fopen(wholefilename,'r');
A = fscanf(fid,'%c');

% 29 = '   ';30,31 = ' *newline* ';
tab = A(29);
newline = A(30);

pointer = 1;
nlines = 0;
lines = {};
channels = 1;
x = [];y=[];
pasteindex = 0;
pastedornot = 0;
files = {};
xtitle = "";
ytitle = "";
channel = [];
currentfile_i=1;

%% plot and stuff
data= getdata(pathname,filename);

f = figure(...
'Units','characters',...
'Color',[0.7 0.7 0.7],...
'MenuBar','none',...
'Name','Point Spectrum Viewer',...
'NumberTitle','off',...
'Position',[50 10 150 35],...% 'Resize','off',...
'Visible','on');

ax_spect_pos = [0.1,0.3,0.8,0.6];
ax_spect = subplot('Position',ax_spect_pos);

%% uicontrol to control what channels to plot
popupstring = '';
for i=1:length(channel)-1
    popupstring = append(popupstring,channel{i},'|');
end
popupstring = append(popupstring,channel{end});
    
dropdownx = uicontrol('Parent',f,...
    'Units','normalized',...
    'Style','popupmenu',...
    'Position',[0.1 0.1 0.2 0.1],...
    'BackgroundColor',[1 1 1],...
    'String',popupstring,...
    'Value',1,...
    'Callback',@updateplot);
dropdowny = uicontrol('Parent',f,'Style','popupmenu','Visible','on',...
    'Units','normalized','Position',[0.1,0.05,0.2,0.1],...
    'String',popupstring,'Value',channels,...
    'Callback',@updateplot);
annotation('textbox',[0.06,0.1,0.1,0.1],'String','x','LineStyle','none');
annotation('textbox',[0.06,0.05,0.1,0.1],'String','y','LineStyle','none');


%% plotline or dot
plotstyle = uibuttongroup(f,'Position',[0.87,0,0.1,0.13]);
methoddot = uicontrol(plotstyle,'Style','radiobutton',...
    'Position',[10,40,100,20],'Units','normalized',...
    'String','Dots','Callback',@updateplot);
methodline = uicontrol(plotstyle,'Style','radiobutton',...
    'Position',[10,10,100,20],'Units','normalized',...
    'String','line','Callback',@updateplot);


%% variables to hold values for pasted plots
% the format will be {filename(string),channelx(int),channely(int),en,spec}
pasted = {};

%% option to view other files in folder
foldercontent = dir(pathname);
filestring = '';
valid_n = 0;
for i=1:length(foldercontent)
   str = foldercontent(i).name;
   if length(str)>4 && str(end-3:end)==".dat"
       filestring = append(filestring,str,'|');
       valid_n = valid_n+1;
       files{valid_n} = str;
   end
   if length(str)==length(filename)
       if str==filename
           currentfile_i = valid_n;
       end
   end
end
filestring = filestring(1:end-1);

dropdownfiles = uicontrol('Parent',f,'Style','popupmenu','Units','normalized',...
    'Position',[0.4,0.05,0.3,0.1],...
    'String',filestring,'Value',currentfile_i,'Callback',@fileselect_callback);

showNchannels = annotation('textbox',[0.3,0.01,0.1,0.1],'String',num2str(channels));
annotation('textbox',[0.2,0.01,0.1,0.1],'String','#channels','LineStyle','none');

%% option to paste a spectrum and clear
pasteclear = uicontrol('Parent',f,'Units','normalized', 'Position',[0.7,0.1,0.1,0.05],...
    'Style','pushbutton','String','Paste','Callback',@pasteclear_callback);
clearall = uicontrol('Parent',f,'Units','normalized','Position',[0.7,0.05,0.1,0.05],...
    'Style','pushbutton','String','Clear all','Callback',@clearall_callback);

updateplot;
bias = x;
conductance=y;
%% callback functions
    function pasteclear_callback(~,~)
        pasted_checker;
        %         if pasteclear.String == "Clear"
        if pastedornot == 1
            pasteclear.String = "Paste";
            %             tobedeletedfile = files{dropdownfiles.Value};
            pasted(pasteindex)=[];
            %             for k = 1:length(pasted)
            %                if pasted{k}{1}==tobedeletedfile
%                    pasted(k)=[];
%                    break
%                end
%             end
        else %add data to 
            pasteclear.String = "Clear";
            num = length(pasted)+1;
%             name = files{dropdownfiles.Value};
            xchoice = channel{dropdownx.Value};
            ychoice = channel{dropdowny.Value};
            pasted{num} = {filename,xchoice,ychoice,x,y};
        end
        updateplot;
        
    end
    function clearall_callback(~,~)
        pasteclear.String = 'Paste';
        pasted={};
        pasteindex = 0;
        pastedornot = 0;
        updateplot;
    end
    function fileselect_callback(~,~)
        fileID = dropdownfiles.Value;
        filename = files{fileID};
        data = getdata(pathname,filename);
        updatedropdown
        updateplot
        showNchannels.String = num2str(channels);
        
        pasted_checker;
        pasteclear.String = "Paste";
        if pastedornot == 1
            pasteclear.String = "Clear";
        end
    end
    function updatedropdown(~,~)
        %% uicontrol to control what channels to plot
        popupstring = '';
        for ii=1:length(channel)-1
            popupstring = append(popupstring,channel{ii},'|');
        end
        popupstring = append(popupstring,channel{end});
        
        dropdownx = uicontrol('Parent',f,...
            'Units','normalized',...
            'Style','popupmenu',...
            'Position',[0.1 0.1 0.2 0.1],...
            'BackgroundColor',[1 1 1],...
            'String',popupstring,...
            'Value',1,...
            'Callback',@updateplot);
        dropdowny = uicontrol('Parent',f,'Style','popupmenu','Visible','on',...
            'Units','normalized','Position',[0.1,0.05,0.2,0.1],...
            'String',popupstring,'Value',channels,...
            'Callback',@updateplot);
        
    end
    function updateplot(hobject,eventdata)
        if isempty(pasted)==0
            plotprevious;
        end
        if methoddot.Value == 1
            meth = 'b.';
        else
            meth = 'b-';
        end
        xtitle = channel{dropdownx.Value};
        ytitle = channel{dropdowny.Value};
        x = squeeze(data(dropdownx.Value,:));
        y = squeeze(data(dropdowny.Value,:));
        [x,ind] = sort(x);
        y = y(ind);
        plot(ax_spect,x,y,meth);
        hold on
        xlabel(xtitle);
        ylabel(ytitle);
        title(filename,'Interpreter','none');
        hold off
        
        assignin('base','Ebias',x);
        assignin('base','dIdV',y);
        
        pasted_checker;
        
        
    end    
    function pasted_checker(~,~)
        pastedornot = 0;
        if isempty(pasted)~=1
            for k = 1:length(pasted)
                if strcmp(pasted{k}{1},filename)==1

                    if strcmp(pasted{k}{2},xtitle)==1 && strcmp(pasted{k}{3},ytitle)==1
                        pastedornot=1;
                        pasteindex = k;
                    end
                end
            end
        end
        if pastedornot == 0
            pasteclear.String = "Paste";
        else
            pasteclear.String = "Clear";
        end
    end
    function plotprevious(~,~)
        legendholder = "";
        for k=1:length(pasted)
            leg = append("'",pasted{k}{1},"_",pasted{k}{3}," vs ",pasted{k}{2},"'");
            legendholder = append(legendholder,',',leg);
            plot(ax_spect,pasted{k}{4},pasted{k}{5});
            hold on
        end
        legendholder = append("{",legendholder,"}");
        evalstr = strcat("legend(ax_spect,",legendholder,",'Interpreter','none');");
        eval(evalstr);
%         legend(ax_spect,legendholder,'Interpreter','none');
    end
    function data = getdata(pathname,filename)
        wholefilename = strcat(pathname,filename);
        
        fid = fopen(wholefilename,'r');
        A = fscanf(fid,'%c');
        
        % 29 = '   ';30,31 = ' *newline* ';
        tab = A(29);
        newline = A(30);
        
        pointer = 1;
        nlines = 0;
        lines = {};
        for i=1:length(A)
            if A(i)==newline
                nlines = nlines+1;
                lines{nlines} = A(pointer:i-1);
                pointer = i+2;
            elseif A(i)=='['
                break
            end
        end
        
        header = A(1:i-1);
        data = A(i+8:end);
        
        
        %% deal with the header information by putting them into structures.
        for n=1:nlines-1
            l = lines{n};
            for j=1:length(l)
                switch l(j)
                    case ' '
                        l(j)='_';
                    case '('
                        l(j)='_';
                    case ')'
                        l(j)='_';
                    case '-'
                        l(j)='_';
                    case '>'
                        l(j)='_';
                    case '/'
                        l(j)='_';
                end
                
                if l(j)==tab
                    execute = strcat('struct.',l(1:j-1),'="',l(j+1:end-1),'";');
                    try
                        eval(execute);
                    catch
                        warning(strcat("line NOT recorded: ",execute));
                    end
                    break
                end
            end
        end
        
        datastring = data;
        clear data;
        
        endline = 0;
        pointer = 0;
        while endline == 0
            pointer = pointer + 1;
            if datastring(pointer)==newline
                endline=1;
            end
        end
        titlehead = datastring(1:pointer-1);
        datastring = datastring(pointer+1:end);
        
        %% get headings for channels (bias,current,conductance)
        channels = 1;
        pointer = 1;
        clear channel;
        for i=1:length(titlehead)
            if titlehead(i)==tab
                channel{channels} = titlehead(pointer:i-1);
                pointer = i+1;
                channels=channels+1;
            end
        end
        channel{channels} = titlehead(pointer:end);
        
        %% now deal with data itself, now that we know there is channles# of channels
        points = 0;
        pointer = 1;
        
        for i=1:length(datastring)
            if datastring(i)==newline
                points=points+1;
                l = datastring(pointer:i-1);
                pointer = i+2;
                
                smallpointer = 1;
                smallchannels = 1;
                for j=1:length(l)
                    if l(j)==tab
                        data(smallchannels,points)=str2double(l(smallpointer:j-1));
                        smallpointer = j+1;
                        smallchannels = smallchannels+1;
                    end
                end
                data(smallchannels,points) = str2double(l(smallpointer:end));
            end
        end
        
        
    end

end









    
    
    
    