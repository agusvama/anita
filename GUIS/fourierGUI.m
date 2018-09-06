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
end


% --- Executes just before fourierGUI is made visible.
function fourierGUI_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.axes1, 'NextPlot', 'replacechildren');
set(handles.axes4, 'NextPlot', 'replacechildren');

xlabel(handles.axes1, 'Potencial Natural (mV)');
ylabel(handles.axes1, 'Lecturas realizadas');
set(handles.axes1, 'YLim', [0 10]);
set(handles.axes1, 'YTick', [0:1:10]);
set(handles.axes1, 'XLim', [0 10]);
set(handles.axes1, 'XTick', [0:1:10]);
set(handles.axes1, 'CameraUpVector', [0 -1 0]);
set(handles.axes1, 'FontSize', 12);
set(handles.axes1, 'FontWeight', 'bold');
set(handles.axes1, 'XColor', [1 1 1]);
set(handles.axes1, 'YColor', [1 1 1]);
set(handles.axes1, 'YAxisLocation', 'right');
set(handles.axes1, 'GridColor', [0 0 0]);
set(handles.axes1, 'XGrid', 'on');
set(handles.axes1, 'YGrid', 'on');

set(handles.axes4, 'FontName', 'MS Sans Serif');
ylabel(handles.axes4, 'Resistividad (Ohms)');
xlabel(handles.axes4, 'Lecturas realizadas');
set(handles.axes4, 'YLim', [0 10]);
set(handles.axes4, 'YTick', [0:1:10]);
set(handles.axes4, 'XLim', [0 10]);
set(handles.axes4, 'XTick', [0:1:10]);
set(handles.axes4, 'CameraUpVector', [-1 0 0]);
set(handles.axes4, 'FontSize', 12);
set(handles.axes4, 'FontWeight', 'bold');
set(handles.axes4, 'XColor', [1 1 1]);
set(handles.axes4, 'YColor', [1 1 1]);
set(handles.axes4, 'YAxisLocation', 'left');
set(handles.axes4, 'GridColor', [0 0 0]);
set(handles.axes4, 'XGrid', 'on');
set(handles.axes4, 'YGrid', 'on');

warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
handles.output = hObject;

guidata(hObject, handles);
end


% --- Outputs from this function are returned to the command line.
function varargout = fourierGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
global path;
global file;
[file, path] = uigetfile('.csv', 'Abrir archivo de datos');

dibujaPotencial(handles, strcat(path, file), getScale(get(handles.popV, 'Value')));
dibujaResistividad(handles, strcat(path, file), getScale(get(handles.popR, 'Value')));
set(handles.popV, 'Enable', 'on');
set(handles.popR, 'Enable', 'on');

figure('Name', 'Transformada de Fourier: Potencial Natural', 'Toolbar', 'None',...
      'NumberTitle', 'off', 'Menubar', 'None', 'position', [50, 120, 600, 500],...
      'color', [0.463, 0.153, 0.267], 'Tag', 'fourier1');
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
javaFrame = get(findobj('Tag', 'fourier1'),'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
transPotencial(strcat(path, file));

figure('Name', 'Transformada de Fourier: Resistividad', 'Toolbar', 'None',...
      'NumberTitle', 'off', 'Menubar', 'None', 'position', [700, 120, 600, 500],...
      'color', [0.463, 0.153, 0.267], 'Tag', 'fourier2');
transResistividad(strcat(path, file));
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
javaFrame = get(findobj('Tag', 'fourier2'),'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
end


% --- Executes on selection change in popV.
function popV_Callback(hObject, eventdata, handles)
% hObject    handle to popV (see GCBO)
global path;
global file;
dibujaPotencial(handles, strcat(path, file), getScale(get(handles.popV, 'Value')));
end

function popR_Callback(hObject, eventdata, handles)
% hObject    handle to popR (see GCBO)
global path;
global file;
dibujaResistividad(handles, strcat(path, file), getScale(get(handles.popR, 'Value')));
end

function dibujaPotencial(handles, archivo, escalaV)
    dataset = load(archivo);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);

    plot(handles.axes1, v, 1:filas);
    set(handles.axes1, 'XLim', [0 escalaV]);
    set(handles.axes1, 'YLim', [1 filas]);
    set(handles.axes1,'YTick', [1:fix(filas/20):filas]);
    set(handles.axes1, 'XTick', [0:escalaV/10:escalaV]);
    
end

function dibujaResistividad(handles, archivo, escalaR)
    dataset = load(archivo);
    [filas, columnas] = size(dataset);
    r = dataset(filas+1:end);    

    plot(handles.axes4, 1:filas, r, 'r');
    set(handles.axes4, 'XLim', [1 filas]);
    set(handles.axes4, 'YLim', [0 escalaR]);
    set(handles.axes4,'XTick', [1:fix(filas/20):filas]);
    set(handles.axes4, 'YTick', [0:escalaR/10:escalaR]); %esto dibuja los cuadritos
end

function popV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function popR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
