function varargout = pdfGUI(varargin)
% PDFGUI MATLAB code for pdfGUI.fig
%      PDFGUI, by itself, creates a new PDFGUI or raises the existing
%      singleton*.
%
%      H = PDFGUI returns the handle to a new PDFGUI or the handle to
%      the existing singleton*.
%
%      PDFGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PDFGUI.M with the given input arguments.
%
%      PDFGUI('Property','Value',...) creates a new PDFGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pdfGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pdfGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pdfGUI

% Last Modified by GUIDE v2.5 24-Aug-2018 17:53:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pdfGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @pdfGUI_OutputFcn, ...
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


% --- Executes just before pdfGUI is made visible.
function pdfGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
axes(handles.axes6);
image(imread('logo/header.png'));
set(handles.axes6, 'YTick', []);
set(handles.axes6, 'XTick', []);
set(handles.axes6, 'XColor', [1 1 1]);
set(handles.axes6, 'YColor', [1 1 1]);

set(handles.axes4, 'NextPlot', 'replacechildren');
set(handles.axes5, 'NextPlot', 'replacechildren');
xlabel(handles.axes4, 'Potencial Natural (mV)');
ylabel(handles.axes4, 'Lecturas realizadas');
set(handles.axes4, 'YLim', [0 10]);
set(handles.axes4, 'YTick', [0:1:10]);
set(handles.axes4, 'XLim', [0 10]);
set(handles.axes4, 'XTick', [0:1:10]);
set(handles.axes4, 'CameraUpVector', [0 -1 0]);
set(handles.axes4, 'FontSize', 12);
set(handles.axes4, 'XColor', [1 1 1]);
set(handles.axes4, 'YColor', [1 1 1]);
set(handles.axes4, 'YAxisLocation', 'right');
set(handles.axes4, 'GridColor', [0 0 0]);
set(handles.axes4, 'XGrid', 'on');
set(handles.axes4, 'YGrid', 'on');

set(handles.axes5, 'FontName', 'MS Sans Serif');
ylabel(handles.axes5, 'Resistividad (Ohms)');
xlabel(handles.axes5, 'Lecturas realizadas');
set(handles.axes5, 'YLim', [0 10]);
set(handles.axes5, 'YTick', [0:1:10]);
set(handles.axes5, 'XLim', [0 10]);
set(handles.axes5, 'XTick', [0:1:10]);
set(handles.axes5, 'CameraUpVector', [-1 0 0]);
set(handles.axes5, 'FontSize', 12);
set(handles.axes5, 'XColor', [1 1 1]);
set(handles.axes5, 'YColor', [1 1 1]);
set(handles.axes5, 'YAxisLocation', 'left');
set(handles.axes5, 'GridColor', [0 0 0]);
set(handles.axes5, 'XGrid', 'on');
set(handles.axes5, 'YGrid', 'on');
% hObject    handle to figure
mostrarFecha(handles, fix(clock));
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
% varargin   command line arguments to pdfGUI (see VARARGIN)

% Choose default command line output for pdfGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pdfGUI wait for user response (see UIRESUME)
% uiwait(handles.plotsFigure);
end


% --- Outputs from this function are returned to the command line.
function varargout = pdfGUI_OutputFcn(hObject, eventdata, handles) 
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
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
set(handles.pushbutton1, 'Visible', 'off');
set(handles.pushbutton3, 'Visible', 'off');
[file, path] = uiputfile('*.pdf', 'Guardar gráficas como...');
  
  if(~file)
    warndlg('introduzca un nombre de archivo')
    return;
  else
    print(findobj('Tag', 'plotsFigure'), strcat(path, file), '-dpdf');
    %print requiere como primer argumento un nombre para el archivo, por eso
    %se manda primero la ruta seleccionada previamente concatenada al nombre
    %del archivo elegido, estos comandos se pueden probar en consola para tener
    %un mejor entendimiento se sus salidas
  end
end


% --- Executes on selection change in popV.
function popV_Callback(hObject, eventdata, handles)
global path;
global file;
dibujaPotencial(handles, strcat(path, file), getScale(get(handles.popV, 'Value')));
end

% --- Executes during object creation, after setting all properties.
function popV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on selection change in popR.
function popR_Callback(hObject, eventdata, handles)
global path;
global file;
dibujaResistividad(handles, strcat(path, file), getScale(get(handles.popR, 'Value')));
end


% --- Executes during object creation, after setting all properties.
function popR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function dibujaPotencial(handles, archivo, escalaV)
    dataset = load(archivo);
    [filas, columnas] = size(dataset);
    v = dataset(1:filas);

    plot(handles.axes4, v, 1:filas);
    set(handles.axes4, 'XLim', [0 escalaV]);
    set(handles.axes4, 'YLim', [1 filas]);
    set(handles.axes4,'YTick', [1:fix(filas/20):filas]);
    set(handles.axes4, 'XTick', [0:escalaV/10:escalaV]);
end

function dibujaResistividad(handles, archivo, escalaR)
    dataset = load(archivo);
    [filas, columnas] = size(dataset);
    r = dataset(filas+1:end);    

    plot(handles.axes5, 1:filas, r, 'r');
    set(handles.axes5, 'XLim', [1 filas]);
    set(handles.axes5, 'YLim', [0 escalaR]);
    set(handles.axes5,'XTick', [1:fix(filas/20):filas]);
    set(handles.axes5, 'YTick', [0:escalaR/10:escalaR]); %esto dibuja los cuadritos
end
