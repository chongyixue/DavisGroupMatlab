function varargout = mahaem_guide(varargin)
% MAHAEM_GUIDE MATLAB code for mahaem_guide.fig
%      MAHAEM_GUIDE, by itself, creates a new MAHAEM_GUIDE or raises the existing
%      singleton*.
%
%      H = MAHAEM_GUIDE returns the handle to a new MAHAEM_GUIDE or the handle to
%      the existing singleton*.
%
%      MAHAEM_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAHAEM_GUIDE.M with the given input arguments.
%
%      MAHAEM_GUIDE('Property','Value',...) creates a new MAHAEM_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mahaem_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mahaem_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mahaem_guide

% Last Modified by GUIDE v2.5 08-May-2020 12:53:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mahaem_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @mahaem_guide_OutputFcn, ...
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


% --- Executes just before mahaem_guide is made visible.
function mahaem_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mahaem_guide (see VARARGIN)

% Choose default command line output for mahaem_guide
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mahaem_guide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mahaem_guide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
