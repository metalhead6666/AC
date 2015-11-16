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

% Last Modified by GUIDE v2.5 16-Nov-2015 10:41:43

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

% Initialize variables
handles.networkName = 'FeedForward';
handles.network = []; %Network not trained
handles.trainFunction = 'trainscg';
handles.performanceFunction = 'mse';
handles.activationFunction = 'hardlim';
handles.goal = 1e-6;
handles.epochs = 100;
handles.learningRate = 0.5;
handles.numberLayers = 3;
handles.hiddenLayersSizes = 30;
handles.classificationType = 'single';

handles.groupLimitOnes = 5;
handles.windowSize = 10;

handles.trainingFile = '../54802.mat';
handles.percentageTraining = 70;

handles.testFile = '../112502.mat';
handles.percentageTest = 30;

handles.trainingInput = [];
handles.trainingOutput = [];
handles.testInput = [];
handles.testOutput = [];

handles.characteristics = 29;


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
    
    [handles.trainingInput, handles.trainingOutput, handles.testInput, handles.testOutput] = prepareDataSets(handles);
    
    handles = train_network(handles);
    
    % Update handles structure
    guidata(hObject, handles);
% hObject    handle to train_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in trained_network.
function trained_network_Callback(hObject, eventdata, handles)
    
    [handles.trainingInput, handles.trainingOutput, handles.testInput, handles.testOutput] = prepareDataSets(handles);
    
    if(isempty(handles.network))
        handles = train_network(handles);
    end

    handles = trained_network(handles);
    
    % Update handles structure
    guidata(hObject, handles);
% hObject    handle to trained_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in trained_network.
%function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to trained_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in testDataList.
function testDataList_Callback(hObject, eventdata, handles)
% hObject    handle to testDataList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    contents = cellstr(get(hObject,'String')); %returns testDataList contents as cell array
    handles.testFile = strcat('../',contents{get(hObject,'Value')}); %returns selected item from testDataList

    % Update handles structure
    guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function testDataList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testDataList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function testDataCrysisP_Callback(hObject, eventdata, handles)
% hObject    handle to testDataCrysisP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of testDataCrysisP as text
    handles.percentageTest = str2double(get(hObject,'String')); %returns contents of testDataCrysisP as a double
    handles.percentageTraining = 100 - handles.percentageTest;
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function testDataCrysisP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testDataCrysisP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in trainingDataList.
function trainingDataList_Callback(hObject, eventdata, handles)
% hObject    handle to trainingDataList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    contents = cellstr(get(hObject,'String')); % returns trainingDataList contents as cell array
    handles.trainingFile = strcat('../',contents{get(hObject,'Value')}); %returns selected item from trainingDataList

    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function trainingDataList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainingDataList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trainingDataCrysisP_Callback(hObject, eventdata, handles)
% hObject    handle to trainingDataCrysisP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trainingDataCrysisP as text
    handles.percentageTraining = str2double(get(hObject,'String')); returns contents of trainingDataCrysisP as a double
    handles.percentageTest = 100 - handles.percentageTraining;
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function trainingDataCrysisP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainingDataCrysisP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in networkType.
function networkType_Callback(hObject, eventdata, handles)
% hObject    handle to networkType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    contents = cellstr(get(hObject,'String')); % returns networkType contents as cell array
    handles.networkName = contents{get(hObject,'Value')}; %returns selected item from networkType
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function networkType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to networkType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function goalField_Callback(hObject, eventdata, handles)
% hObject    handle to goalField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of goalField as text
    handles.goal = str2double(get(hObject,'String'));% returns contents of goalField as a double

    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function goalField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to goalField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epochsField_Callback(hObject, eventdata, handles)
% hObject    handle to epochsField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epochsField as text
    handles.epochs = str2double(get(hObject,'String')); % returns contents of epochsField as a double

    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function epochsField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epochsField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in trainFunction.
function trainFunction_Callback(hObject, eventdata, handles)
% hObject    handle to trainFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    contents = cellstr(get(hObject,'String')); % returns trainFunction contents as cell array
    handles.trainFunction = contents{get(hObject,'Value')}; % returns selected item from trainFunction
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function trainFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trainFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in performanceFunction.
function performanceFunction_Callback(hObject, eventdata, handles)
% hObject    handle to performanceFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    contents = cellstr(get(hObject,'String'));% returns performanceFunction contents as cell array
    handles.performanceFunction = contents{get(hObject,'Value')};% returns selected item from performanceFunction
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function performanceFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to performanceFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function learningRateField_Callback(hObject, eventdata, handles)
% hObject    handle to learningRateField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of learningRateField as text
    handles.learningRate = str2double(get(hObject,'String')); % returns contents of learningRateField as a double

    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function learningRateField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to learningRateField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function neuronsField_Callback(hObject, eventdata, handles)
% hObject    handle to neuronsField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of neuronsField as text
    handles.hiddenLayersSizes = str2double(get(hObject,'String')); % returns contents of neuronsField as a double
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function neuronsField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to neuronsField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function layersField_Callback(hObject, eventdata, handles)
% hObject    handle to layersField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of layersField as text
	handles.numberLayers = str2double(get(hObject,'String')); % returns contents of layersField as a double
    
    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function layersField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to layersField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in activationFunction.
function activationFunction_Callback(hObject, eventdata, handles)
% hObject    handle to activationFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    contents = cellstr(get(hObject,'String')); % returns activationFunction contents as cell array
    handles.activationFunction = contents{get(hObject,'Value')}; % returns selected item from activationFunction

    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function activationFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to activationFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function charField_Callback(hObject, eventdata, handles)
% hObject    handle to charField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of charField as text
    handles.characteristics = str2double(get(hObject,'String')); % returns contents of charField as a double

    % Update handles structure
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function charField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to charField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in classificationTypePanel.
function classificationTypePanel_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in classificationTypePanel 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    selected = get(eventdata.NewValue,'Tag');
    
    if(strcmp(selected, 'singleClassifButton'))
        handles.classificationType = 'single';
    else
        handles.classificationType = 'group';
    end
    
    % Update handles structure
    guidata(hObject, handles);
