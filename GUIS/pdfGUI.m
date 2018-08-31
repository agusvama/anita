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


% --- Executes just before pdfGUI is made visible.
function pdfGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
mostrarFecha(handles, fix(clock));
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
% varargin   command line arguments to pdfGUI (see VARARGIN)

% Choose default command line output for pdfGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pdfGUI wait for user response (see UIRESUME)
% uiwait(handles.plotsFigure);


% --- Outputs from this function are returned to the command line.
function varargout = pdfGUI_OutputFcn(hObject, eventdata, handles) 
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
pdf(strcat(path, file), getScale(get(handles.popV, 'Value')), getScale(get(handles.popR, 'Value')));
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
  
  close('Gráficas');
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popV.
function popV_Callback(hObject, eventdata, handles)
global path;
global file;
% hObject    handle to popV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
pdf(strcat(path, file), getScale(get(handles.popV, 'Value')), getScale(get(handles.popR, 'Value')));
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
global path;
global file;
% hObject    handle to popR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
pdf(strcat(path, file), getScale(get(handles.popV, 'Value')), getScale(get(handles.popR, 'Value')));
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
