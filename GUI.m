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

% --- Executes on button press in startButton.
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
    
    nombreArchivo = crearArchivo(fix(clock));
    archivo = fopen(nombreArchivo, 'a');
    
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
  warning('');
  while( strcmp(get(handles.statusText, 'String'), 'Leyendo') )
    try
      [izq, der] = anita(pArduino);
      %escribir información
      fprintf(archivo, '%.3f,\t', izq);
      fprintf(archivo, '%.3f\r\n', der*-1);
      
      dibuja(nombreArchivo);
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
  set(handles.pauseButton, 'String', 'Reanudar');
end

% --- Executes on button press in pauseButton.
function pauseButton_Callback(hObject, eventdata, handles)
  global placa;
  global archivo;
  global nombreArchivo;
  if(strcmp(get(handles.statusText, 'String'), 'Pausado'))
    set(handles.statusText, 'String', 'Leyendo');
    fopen(placa);
    reading(placa, archivo, nombreArchivo, handles);% como vuelvo a invocarla con todos sus parámetros?
    return;
  end
  set(handles.statusText, 'String', 'Pausado');
  fclose(placa);
end


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
  global placa;
  global archivo;
  %cerrar conexiones serial y de archivo
  fclose(archivo);
  fclose(placa);
  set(handles.statusText, 'Visible', 'off');
  set(handles.pauseButton, 'Enable', 'off');
  set(handles.startButton, 'Enable', 'on');
  set(handles.stopButton, 'Enable', 'off');
  clear global placa;
  clear global archivo;
  clear global nombreArchivo;
end


% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)
  set(handles.analizePanel, 'Visible', 'off');
  set(handles.plotPanel, 'Visible', 'on');
end

% --- Executes on button press in analizeButton.
function analizeButton_Callback(hObject, eventdata, handles)
  set(handles.analizePanel, 'Visible', 'on');
  set(handles.plotPanel, 'Visible', 'off');
end


function loadButton1_Callback(hObject, eventdata, handles)

end

function loadButton3_Callback(hObject, eventdata, handles)

end

function loadButton2_Callback(hObject, eventdata, handles)

end

function hide1_Callback(hObject, eventdata, handles)
  if(get(handles.hide1, 'Value'))
    set(handles.axes9, 'Visible', 'off')
  else
    set(handles.axes9, 'Visible', 'on')
  end
end

function hide2_Callback(hObject, eventdata, handles)
  if(get(handles.hide2, 'Value'))
    set(handles.axes10, 'Visible', 'off')
  else
    set(handles.axes10, 'Visible', 'on')
  end
end


function hide3_Callback(hObject, eventdata, handles)
  if(get(handles.hide3, 'Value'))
    set(handles.axes11, 'Visible', 'off')
  else
    set(handles.axes11, 'Visible', 'on')
  end
end

function hide4_Callback(hObject, eventdata, handles)
  if(get(handles.hide4, 'Value'))
    set(handles.axes12, 'Visible', 'off')
  else
    set(handles.axes12, 'Visible', 'on')
  end
end

function hide5_Callback(hObject, eventdata, handles)
  if(get(handles.hide5, 'Value'))
    set(handles.axes13, 'Visible', 'off')
  else
    set(handles.axes13, 'Visible', 'on')
  end
end

function hide6_Callback(hObject, eventdata, handles)
  if(get(handles.hide6, 'Value'))
    set(handles.axes14, 'Visible', 'off')
  else
    set(handles.axes14, 'Visible', 'on')
  end
end
