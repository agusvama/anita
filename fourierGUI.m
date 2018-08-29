function varargout = fourierGUI(varargin)
% FOURIERGUI MATLAB code for fourierGUI.fig
%      FOURIERGUI, by itself, creates a new FOURIERGUI or raises the existing
%      singleton*.
%
%      H = FOURIERGUI returns the handle to a new FOURIERGUI or the handle to
%      the existing singleton*.
%
%      FOURIERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIERGUI.M with the given input arguments.
%
%      FOURIERGUI('Property','Value',...) creates a new FOURIERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourierGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourierGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourierGUI

% Last Modified by GUIDE v2.5 27-Aug-2018 16:06:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourierGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @fourierGUI_OutputFcn, ...
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


% --- Executes just before fourierGUI is made visible.
function fourierGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourierGUI (see VARARGIN)

% Choose default command line output for fourierGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourierGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fourierGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
global path;
global file;
[file, path] = uigetfile('.csv', 'Abrir archivo de datos');
fourier(strcat(path, file), getScale(get(handles.popV, 'Value')), getScale(get(handles.popR, 'Value')));
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popV.
function popV_Callback(hObject, eventdata, handles)
% hObject    handle to popV (see GCBO)
global path;
global file;
fourier(strcat(path, file), getScale(get(handles.popV, 'Value')), getScale(get(handles.popR, 'Value')));
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popV contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popV


% --- Executes during object creation, after setting all properties.
function popV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popR.
function popR_Callback(hObject, eventdata, handles)
% hObject    handle to popR (see GCBO)
global path;
global file;
fourier(strcat(path, file), getScale(get(handles.popV, 'Value')), getScale(get(handles.popR, 'Value')));
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popR


% --- Executes during object creation, after setting all properties.
function popR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
