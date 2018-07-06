function varargout = GUI(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% handles    structure with handles and user data (see GUIDATA)
set(handles.saveButton,'enable','off');
% Choose default command line output for GUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function inputDepth_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)

if(isempty(get(handles.inputDepth,'String')))
  warndlg('Debe ingresar un valor en el campo profundidad');
  return;
else
  if(isnan(str2double(get(handles.inputDepth,'String'))))
    warndlg('Debe ingresar un valor numérico');
    return;
  else
    anita(str2double(get(handles.inputDepth,'String')));
  end
end

% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
close;

% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
%abre un cuadro de diálogo y usuario selecciona ruta para guardar su PDF
[file, path] = uiputfile('*.pdf', 'Guardar gráficas como...');
%te crea 2 variables, ...
%file -> es el nombre del archivo
%path -> es la ruta seleccionada

print(findobj('Tag', 'plotsFigure'), strcat(path, file), '-dpdf');
%print requiere como primer argumento un nombre para el archivo, por eso
%se manda primero la ruta seleccionada previamente concatenada al nombre
%del archivo elegido, estos comandos se pueden probar en consola para tener
%un mejor entendimiento se sus salidas

set(handles.saveButton, 'enable', 'off'); %bloquea el botón de guardado

