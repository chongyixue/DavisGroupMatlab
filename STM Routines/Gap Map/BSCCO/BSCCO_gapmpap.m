function varargout = BSCCO_gapmpap(varargin)
% BSCCO_GAPMPAP M-file for BSCCO_gapmpap.fig
%      BSCCO_GAPMPAP, by itself, creates a new BSCCO_GAPMPAP or raises the existing
%      singleton*.
%
%      H = BSCCO_GAPMPAP returns the handle to a new BSCCO_GAPMPAP or the handle to
%      the existing singleton*.
%
%      BSCCO_GAPMPAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BSCCO_GAPMPAP.M with the given input arguments.
%
%      BSCCO_GAPMPAP('Property','Value',...) creates a new BSCCO_GAPMPAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BSCCO_gapmpap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BSCCO_gapmpap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BSCCO_gapmpap

% Last Modified by GUIDE v2.5 29-Jul-2010 13:08:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BSCCO_gapmpap_OpeningFcn, ...
                   'gui_OutputFcn',  @BSCCO_gapmpap_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before BSCCO_gapmpap is made visible.
function BSCCO_gapmpap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BSCCO_gapmpap (see VARARGIN)

% Choose default command line output for BSCCO_gapmpap
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BSCCO_gapmpap wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BSCCO_gapmpap_OutputFcn(hObject, eventdata, handles) 
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


