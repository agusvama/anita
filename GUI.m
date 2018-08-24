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
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% handles    structure with handles and user data (see GUIDATA)
% Choose default command line output for GUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
  varargout{1} = handles.output;
end

function startButton_Callback(hObject, eventdata, handles)
    global placa;
    global nombreArchivo;
    global archivo;
    try
      placa = iniciarArduino('COM3');
    catch
      warndlg('arduino no conectado');
      return;
    end
    
    mostrarFecha(handles, fix(clock));
    set(handles.statusText, 'Visible', 'on');
    set(handles.statusText, 'String', 'Leyendo');
    
    %leer información
    reading(placa, archivo, nombreArchivo, handles);
end

function reading(pArduino, archivo, nombreArchivo, handles)
  set(handles.pauseButton, 'String', 'Pausar');
  set(handles.startButton, 'Enable', 'off');
  set(handles.pauseButton, 'Enable', 'on');
  set(handles.stopButton, 'Enable', 'on');
  set(handles.loadButton, 'Enable', 'off');
  set(handles.newButton, 'Enable', 'off');
  warning('');
  try
  while( strcmp(get(handles.statusText, 'String'), 'Leyendo') )
    try
      [izq, der] = anita(pArduino);
      %escribir información
      escalaV = getScale(get(handles.popV, 'Value'));
      disV = 7.7;
      fprintf(archivo, '%.3f,\t', (disV - (izq - 4))*escalaV / disV);
      
      escalaR = getScale(get(handles.popR, 'Value'));
      disI = 15.2;
      fprintf(archivo, '%.3f\r\n', (disI - (der - 4))*escalaR / disI);
      
      dibuja(nombreArchivo, escalaV, escalaR);
      pause(.1); %dibujar la gráfica cada .1 segundos
      
      if( strcmp('Unsuccessful read: A timeout occurred before the Terminator was reached..', lastwarn) )
        fclose(placa);
        return;
      end
    
    catch
      disp('fin de la sesión');
      clear;
      return;
    end
  end
  catch
  global placa;
  global archivo;
  global nombreArchivo;
  %salida por cierre inesperado
  fclose(archivo);
  fclose(placa);
  clear global placa;
  clear global archivo;
  clear global nombreArchivo;
  end
  set(handles.pauseButton, 'String', 'Reanudar');
end


function pauseButton_Callback(hObject, eventdata, handles)
  global placa;
  global archivo;
  global nombreArchivo;
  if(strcmp(get(handles.statusText, 'String'), 'Pausado'))
    set(handles.statusText, 'String', 'Leyendo');
    fopen(placa);
    reading(placa, archivo, nombreArchivo, handles);
    return;
  end
  set(handles.statusText, 'String', 'Pausado');
  fclose(placa);
end

function stopButton_Callback(hObject, eventdata, handles)
  global placa;
  global archivo;
  %cerrar conexiones serial y de archivo
  fclose(archivo);
  fclose(placa);
  set(handles.statusText, 'Visible', 'off');
  set(handles.pauseButton, 'Enable', 'off');
  set(handles.startButton, 'Enable', 'off');
  set(handles.stopButton, 'Enable', 'off');
  clear global placa;
  clear global archivo;
  clear global nombreArchivo;
  set(handles.loadButton, 'Enable', 'on');
  set(handles.newButton, 'Enable', 'on');
end

function pdfButton_Callback(hObject, eventdata, handles)
  pdfGUI();
end

function fourierButton_Callback(hObject, eventdata, handles)
  [file, path] = uigetfile('.csv', 'Abrir archivo de datos');
  fourier(strcat(path, file));
end

function loadButton_Callback(hObject, eventdata, handles)
  global nombreArchivo;
  global archivo;
  [file, path] = uigetfile('.csv', 'Abrir archivo de datos...');
  nombreArchivo = strcat(path, file);
  archivo = fopen(nombreArchivo, 'a');
  set(handles.startButton, 'enable', 'on');
  dibuja(nombreArchivo, 10, 10);
end

function newButton_Callback(hObject, eventdata, handles)
  global nombreArchivo;
  global archivo;
  nombreArchivo = crearArchivo(fix(clock)); %es el nombre del archivo
  archivo = fopen(nombreArchivo, 'w');      %es el apuntador del archivo
  set(handles.startButton, 'enable', 'on');
end

% --- Executes on selection change in popV.
function popV_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function popV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in popR.
function popR_Callback(hObject, eventdata, handles)

end

% --- Executes during object creation, after setting all properties.
function popR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
