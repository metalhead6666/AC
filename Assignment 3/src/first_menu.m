function varargout = first_menu(varargin)
% FIRST_MENU MATLAB code for first_menu.fig
%      FIRST_MENU, by itself, creates a new FIRST_MENU or raises the existing
%      singleton*.
%
%      H = FIRST_MENU returns the handle to a new FIRST_MENU or the handle to
%      the existing singleton*.
%
%      FIRST_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRST_MENU.M with the given input arguments.
%
%      FIRST_MENU('Property','Value',...) creates a new FIRST_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before first_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to first_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help first_menu

% Last Modified by GUIDE v2.5 27-Oct-2015 15:17:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first_menu_OpeningFcn, ...
                   'gui_OutputFcn',  @first_menu_OutputFcn, ...
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


% --- Executes just before first_menu is made visible.
function first_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to first_menu (see VARARGIN)

% Choose default command line output for first_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes first_menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = first_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in train_network.
function train_network_Callback(hObject, eventdata, handles)
    train_network();
% hObject    handle to train_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in trained_network.
function trained_network_Callback(hObject, eventdata, handles)
    trained_network();
% hObject    handle to trained_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

