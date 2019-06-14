function varargout = daun_jambu(varargin)
% DAUN_JAMBU MATLAB code for daun_jambu.fig
%      DAUN_JAMBU, by itself, creates a new DAUN_JAMBU or raises the existing
%      singleton*.
%
%      H = DAUN_JAMBU returns the handle to a new DAUN_JAMBU or the handle to
%      the existing singleton*.
%
%      DAUN_JAMBU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAUN_JAMBU.M with the given input arguments.
%
%      DAUN_JAMBU('Property','Value',...) creates a new DAUN_JAMBU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before daun_jambu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to daun_jambu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help daun_jambu

% Last Modified by GUIDE v2.5 12-Jun-2019 19:43:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @daun_jambu_OpeningFcn, ...
                   'gui_OutputFcn',  @daun_jambu_OutputFcn, ...
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


% --- Executes just before daun_jambu is made visible.
function daun_jambu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to daun_jambu (see VARARGIN)

% Choose default command line output for daun_jambu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');
hback = axes('units','normalized','position',[0 0 1 1]);
uistack(hback,'bottom'); % menciptakan axes untuk tempat menampilkan gambar
% menampilkan background
[back map]=imread('daun_jambu.jpg');
image(back)
colormap(map)
background=imread('daun_jambu.jpg');
% set(handles.pan1,'CData',background);
% handlevisibility off agar axes tidak terlihat
% dan gambar background saja yang muncul.
set(hback,'handlevisibility','off','visible','off')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes daun_jambu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = daun_jambu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(daun_jambu);
identifikasi_tumbuhan;
