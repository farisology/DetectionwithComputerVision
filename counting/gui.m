function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 20-Sep-2016 17:30:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function hAxis = createPanelAxisTitle(hFig, pos, axisTitle)
    hPanel = uipanel('parent',hFig,'Position',pos,'Units','Normalized');
    hAxis = axes('position',[0 0 1 1],'Parent',hPanel);
    hAxis.XTick = [];
    hAxis.YTick = [];
    hAxis.XColor = [1 1 1];
    hAxis.YColor = [1 1 1];
    titlePos = [pos(1)+0.02 pos(2)+pos(3)+0.3 0.3 0.07];
    uicontrol('style','text',...
        'String', axisTitle,...
        'Units','Normalized',...
        'Parent',hFig,'Position', titlePos,...
        'BackgroundColor',hFig.Color);



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[a,b] = uigetfile('*.mp4','All Files'); % get the video name
path = [b a];
v = VideoReader(path);
ref = readFrame(v); % this one used for references

%create an axis
hAxes.axis1 = createPanelAxisTitle(handles.figure1,[0.02 0.15 0.9 0.8],'Video');
%for every frame count how many persons and display it 
fltr1= fspecial('average');
fltr2= fspecial('motion');
while hasFrame(v)
    f = readFrame(v);
    count = countPersons(ref,f,fltr1,fltr2);    
    showFrameOnAxis(hAxes.axis1,f) 
    set(handles.text2,'String',int2str(count))
end
