function varargout = BSCCO_gapmap_export(varargin)
% BSCCO_GAPMAP_EXPORT M-file for BSCCO_gapmap_export.fig
%      BSCCO_GAPMAP_EXPORT, by itself, creates a new BSCCO_GAPMAP_EXPORT or raises the existing
%      singleton*.
%
%      H = BSCCO_GAPMAP_EXPORT returns the handle to a new BSCCO_GAPMAP_EXPORT or the handle to
%      the existing singleton*.
%
%      BSCCO_GAPMAP_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BSCCO_GAPMAP_EXPORT.M with the given input arguments.
%
%      BSCCO_GAPMAP_EXPORT('Property','Value',...) creates a new BSCCO_GAPMAP_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BSCCO_gapmap_export_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BSCCO_gapmap_export_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BSCCO_gapmap_export

% Last Modified by GUIDE v2.5 09-Oct-2010 20:13:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BSCCO_gapmap_export_OpeningFcn, ...
                   'gui_OutputFcn',  @BSCCO_gapmap_export_OutputFcn, ...
                   'gui_LayoutFcn',  @BSCCO_gapmap_export_LayoutFcn, ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BSCCO_gapmap_export is made visible.
function BSCCO_gapmap_export_OpeningFcn(hObject, eventdata, handles,varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BSCCO_gapmap_export (see VARARGIN)

% Choose default command line output for BSCCO_gapmap_export
handles.output = hObject;
data = varargin{1};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BSCCO_gapmap_export wait for user response (see UIRESUME)
% uiwait(handles.bscco_gap);


% --- Outputs from this function are returned to the command line.
function varargout = BSCCO_gapmap_export_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in filt1.
function filt1_Callback(hObject, eventdata, handles)
% hObject    handle to filt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filt1


% --- Executes on button press in filt2.
function filt2_Callback(hObject, eventdata, handles)
% hObject    handle to filt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filt2


% --- Executes on button press in filt3.
function filt3_Callback(hObject, eventdata, handles)
% hObject    handle to filt3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filt3


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = get(handles.bscco_gap,'UserData');
1

close(handles.bscco_gap)



function filt1_txt_Callback(hObject, eventdata, handles)
% hObject    handle to filt1_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filt1_txt as text
%        str2double(get(hObject,'String')) returns contents of filt1_txt as a double


% --- Executes during object creation, after setting all properties.
function filt1_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filt1_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filt2_txt_Callback(hObject, eventdata, handles)
% hObject    handle to filt2_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filt2_txt as text
%        str2double(get(hObject,'String')) returns contents of filt2_txt as a double


% --- Executes during object creation, after setting all properties.
function filt2_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filt2_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pos_gap.
function pos_gap_Callback(hObject, eventdata, handles)
% hObject    handle to pos_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pos_gap


% --- Executes on button press in avg_gap.
function avg_gap_Callback(hObject, eventdata, handles)
% hObject    handle to avg_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of avg_gap


% --- Executes on button press in neg_gap.
function neg_gap_Callback(hObject, eventdata, handles)
% hObject    handle to neg_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg_gap


% --- Executes on selection change in start_energy.
function start_energy_Callback(hObject, eventdata, handles)
% hObject    handle to start_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns start_energy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from start_energy


% --- Executes during object creation, after setting all properties.
function start_energy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%data = varargin{1};
%set(hObject,'String',num2str(1000*data.e','%10.2f'));


% --- Executes on selection change in end_energy.
function end_energy_Callback(hObject, eventdata, handles)
% hObject    handle to end_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns end_energy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from end_energy


% --- Executes during object creation, after setting all properties.
function end_energy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Creates and returns a handle to the GUI figure. 
function h1 = BSCCO_gapmap_export_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', [], ...
    'slider', [], ...
    'radiobutton', 4, ...
    'uipanel', 6, ...
    'listbox', [], ...
    'popupmenu', 4, ...
    'checkbox', 8, ...
    'pushbutton', [], ...
    'togglebutton', [], ...
    'edit', 8, ...
    'text', 16), ...
    'override', 0, ...
    'release', 13, ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', [], ...
    'callbacks', [], ...
    'singleton', [], ...
    'syscolorfig', [], ...
    'blocking', 0, ...
    'lastSavedFile', 'C:\Analysis Code\MATLAB\STM Routines\Gap Map\BSCCO\BSCCO_gapmap_export.m', ...
    'lastFilename', 'C:\Analysis Code\MATLAB\STM Routines\Gap Map\BSCCO\BSCCO_gapmap.fig');
appdata.lastValidTag = 'bscco_gap';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'bscco_gap');

h1 = figure(...
'Units','characters',...
'Color',[0.87843137254902 0.874509803921569 0.890196078431373],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','BSCCO_gapmap',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[103.8 23.5384615384615 113.8 37.9230769230769],...
'Resize','off',...
'HandleVisibility','callback',...
'UserData',[],...
'Tag','bscco_gap',...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'filt2';

h2 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('filt2_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[5.60000000000001 11.9230769230769 23 2.38461538461538],...
'String','Peak out of Range',...
'Style','checkbox',...
'Tag','filt2',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'filt3';

h3 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('filt3_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[5.60000000000001 8.23076923076923 15 1.76923076923077],...
'String','Bad Pixel Replacement',...
'Style','checkbox',...
'Tag','filt3',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'ok';

h4 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('ok_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[58.8 1.38461538461538 13.8 1.69230769230769],...
'String','OK',...
'Tag','ok',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'cancel';

h5 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('cancel_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[42.6 1.38461538461538 13.8 1.69230769230769],...
'String','Cancel',...
'Tag','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel3';

h6 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Absolute Energyl Range to Look for Peaks:',...
'Tag','uipanel3',...
'Clipping','on',...
'Position',[3 21.2307692307692 77.2 5.61538461538462],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text1';

h7 = uicontrol(...
'Parent',h6,...
'Units','characters',...
'Position',[1 1.69230769230769 15.8 1.15384615384615],...
'String','Start Energy:',...
'Style','text',...
'Tag','text1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text2';

h8 = uicontrol(...
'Parent',h6,...
'Units','characters',...
'Position',[39.2 1.61538461538462 15.4 1.30769230769231],...
'String','End Energy:',...
'Style','text',...
'Tag','text2',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'end_energy';

h9 = uicontrol(...
'Parent',h6,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('end_energy_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[54.8 1.07692307692308 19 2],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',[],...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('end_energy_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','end_energy');

appdata = [];
appdata.lastValidTag = 'start_energy';

h10 = uicontrol(...
'Parent',h6,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('start_energy_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[16.8 1.07692307692308 19 2],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',[],...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('start_energy_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','start_energy');

appdata = [];
appdata.lastValidTag = 'uipanel4';

h11 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Maps to Make:',...
'Tag','uipanel4',...
'Clipping','on',...
'Position',[3 27.4615384615385 104.6 8.69230769230769],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pos_gap';

h12 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('pos_gap_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[1.6 0.999999999999998 19.8 1.76923076923077],...
'String','Positive Gap',...
'Style','checkbox',...
'Tag','pos_gap',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'avg_gap';

h13 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('avg_gap_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[1.6 3.07692307692308 19.4 2],...
'String','Average Gap',...
'Style','checkbox',...
'Tag','avg_gap',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'neg_gap';

h14 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('neg_gap_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[1.6 5.23076923076923 20.6 1.76923076923077],...
'String','Negavie Gap',...
'Style','checkbox',...
'Tag','neg_gap',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'edit4';

h15 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('edit4_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[86.2000000000001 6.15384615384615 9.8 1.53846153846154],...
'String',{  'Edit Text' },...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('edit4_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','edit4');

appdata = [];
appdata.lastValidTag = 'edit5';

h16 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('edit5_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[86.2000000000001 4.30769230769231 9.8 1.53846153846154],...
'String',{  'Edit Text' },...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('edit5_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','edit5');

appdata = [];
appdata.lastValidTag = 'edit6';

h17 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('edit6_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[86.2000000000001 2.46153846153846 9.8 1.53846153846154],...
'String',{  'Edit Text' },...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('edit6_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','edit6');

appdata = [];
appdata.lastValidTag = 'edit7';

h18 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('edit7_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[86.2000000000001 0.461538461538462 9.8 1.53846153846154],...
'String',{  'Edit Text' },...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('edit7_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','edit7');

appdata = [];
appdata.lastValidTag = 'text12';

h19 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'HorizontalAlignment','right',...
'Position',[68 4.53846153846154 16 1.07692307692308],...
'String','Fit Width',...
'Style','text',...
'Tag','text12',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text13';

h20 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'HorizontalAlignment','right',...
'Position',[68.2 2.69230769230769 15.8 1.07692307692308],...
'String','Smooth Width',...
'Style','text',...
'Tag','text13',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text14';

h21 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'HorizontalAlignment','right',...
'Position',[62.2 0.692307692307692 21.8 1.07692307692308],...
'String','Amplitude Threshold',...
'Style','text',...
'Tag','text14',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text15';

h22 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'HorizontalAlignment','right',...
'Position',[67.8 6.38461538461539 16.2 1.07692307692308],...
'String','Slope Threshold',...
'Style','text',...
'Tag','text15',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text8';

h23 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[36.6 9.3846153846154 69.2 4.84615384615385],...
'String','If no satisfactory peak is found, set gap energy to the location of maximum value in the range.  Without this option, the pixel value is set to 0, the error code.',...
'Style','text',...
'Tag','text8',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text9';

h24 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[36.6 7.76923076923079 68.8 2.30769230769231],...
'String','Wherever there is a bad pixel (i.e. no coherence peak found) set that pixel equal to the average of its nearest neighbors.',...
'Style','text',...
'Tag','text9',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel5';

h25 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Filters',...
'Tag','uipanel5',...
'Clipping','on',...
'Position',[3 4.07692307692308 105 16.5384615384615],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text11';

h26 = uicontrol(...
'Parent',h25,...
'Units','characters',...
'CData',[],...
'HorizontalAlignment','left',...
'Position',[33.4 11 67.4 2.53846153846154],...
'String','If the found peak has a nearby neightbor within x% in height, then this pixel is discarded.',...
'Style','text',...
'UserData',[],...
'Tag','text11',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text10';

h27 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Position',[28 31.0769230769231 10.4 1.07692307692308],...
'String','Method:',...
'Style','text',...
'Tag','text10',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'method';

h28 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('method_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[38.6 30.6923076923077 20.4 1.76923076923077],...
'String',{  'Peak Finder'; 'Polynomial'; 'Milan' },...
'Style','popupmenu',...
'Value',[],...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('method_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','method');

appdata = [];
appdata.lastValidTag = 'filt1_txt';

h29 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[],...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('filt1_txt_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'Position',[21.6 15.0769230769231 10.8 1.53846153846154],...
'String',{  'Edit Text' },...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)BSCCO_gapmap_export('filt1_txt_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'UserData',[],...
'Tag','filt1_txt');

appdata = [];
appdata.lastValidTag = 'text3';

h30 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',[],...
'Position',[8.80000000000001 15.2307692307692 12.2 1.15384615384615],...
'String','Percent(x):',...
'Style','text',...
'UserData',[],...
'Tag','text3',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'filt1';

h31 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback',@(hObject,eventdata)BSCCO_gapmap_export('filt1_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'Position',[5.60000000000001 16.8461538461538 23.6 1.76923076923077],...
'String','Skip Double Peaks',...
'Style','checkbox',...
'UserData',[],...
'Tag','filt1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );


hsingleton = h1;


% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   if isa(createfcn,'function_handle')
       createfcn(hObject, eventdata);
   else
       eval(createfcn);
   end
end


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)

gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error('MATLAB:gui_mainfcn:FieldNotFound', 'Could not find field %s in the gui_State struct in GUI M-file %s', gui_StateFields{i}, gui_Mfile);
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % BSCCO_GAPMAP_EXPORT
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % BSCCO_GAPMAP_EXPORT(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % BSCCO_GAPMAP_EXPORT('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % BSCCO_GAPMAP_EXPORT(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = true;
end

if ~gui_Create
    % In design time, we need to mark all components possibly created in
    % the coming callback evaluation as non-serializable. This way, they
    % will not be brought into GUIDE and not be saved in the figure file
    % when running/saving the GUI from GUIDE.
    designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~isa(handle(fig),'figure')
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || isprop(fig,'__GUIDEFigure');
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
    % evaluate the callback now
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    % Set serializable of objects created in the above callback to off in
    % design time. Need to check whether figure handle is still valid in
    % case the figure is deleted during the callback dispatching.
    if designEval && ishandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    % Check user passing 'visible' P/V pair first so that its value can be
    % used by oepnfig to prevent flickering
    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        % Recognize 'visible' P/V pair
        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.

    
    % Do feval on layout code in m-file if it exists
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    % this application data is used to indicate the running mode of a GUIDE
    % GUI to distinguish it from the design mode of the GUI in GUIDE. it is
    % only used by actxproxy at this time.   
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);

        % make figure invisible here so that the visibility of figure is
        % consistent in OpeningFcn in the exported GUI case
        if isempty(gui_VisibleInput)
            gui_VisibleInput = get(gui_hFigure,'Visible');
        end
        set(gui_hFigure,'Visible','off')

        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    if isappdata(0, genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]))
        rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));
    end

    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    % Singleton setting in the GUI M-file takes priority if different
    gui_Options.singleton = gui_State.gui_Singleton;

    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA. If there is
        % user set GUI data already, keep that also.
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    % Apply input P/V pairs other than 'visible'
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});

    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
        % Handle the default callbacks of predefined toolbar tools in this
        % GUI, if any
        guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure); 
        
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);

        % Call openfig again to pick up the saved visibility or apply the
        % one passed in from the P/V pairs
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        if isappdata(gui_hFigure,'InGUIInitialization')
            rmappdata(gui_hFigure,'InGUIInitialization');
        end

        % If handle visibility is set to 'callback', turn it on until
        % finished with OutputFcn
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end

function gui_hFigure = local_openfig(name, singleton, visible)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
if nargin('openfig') == 2
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    gui_hFigure = openfig(name, singleton, visible);
end

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end

function result = local_isInvokeHGCallback(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishandle(varargin{2}), 1) ...
             && (~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])) || ...
                ~isempty(strfind(varargin{1}, '_CreateFcn'))) );
catch
    result = false;
end


