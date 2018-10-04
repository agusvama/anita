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
imshow('logo/ipn.png','Parent', handles.axes32);
imshow('logo/ito2.png','Parent', handles.axes33);
imshow('logo/ciidir.png','Parent', handles.axes34);

set(handles.axes27, 'NextPlot', 'replacechildren');
set(handles.axes28, 'NextPlot', 'replacechildren');
xlabel(handles.axes27, 'Potencial Natural (mV)');
ylabel(handles.axes27, 'Lecturas realizadas');
set(handles.axes27, 'YLim', [0 10]);
set(handles.axes27, 'YTick', [0:1:10]);
set(handles.axes27, 'XLim', [0 10]);
set(handles.axes27, 'XTick', [0:1:10]);
set(handles.axes27, 'CameraUpVector', [0 -1 0]);
set(handles.axes27, 'FontSize', 12);
set(handles.axes27, 'FontWeight', 'bold');
set(handles.axes27, 'XColor', [1 1 1]);
set(handles.axes27, 'YColor', [1 1 1]);
set(handles.axes27, 'YAxisLocation', 'right');
set(handles.axes27, 'GridColor', [0 0 0]);
set(handles.axes27, 'XGrid', 'on');
set(handles.axes27, 'YGrid', 'on');

set(handles.axes28, 'FontName', 'MS Sans Serif');
ylabel(handles.axes28, 'Resistividad (Ohms)');
xlabel(handles.axes28, 'Lecturas realizadas');
set(handles.axes28, 'YLim', [0 10]);
set(handles.axes28, 'YTick', [0:1:10]);
set(handles.axes28, 'XLim', [0 10]);
set(handles.axes28, 'XTick', [0:1:10]);
set(handles.axes28, 'CameraUpVector', [-1 0 0]);
set(handles.axes28, 'FontSize', 12);
set(handles.axes28, 'FontWeight', 'bold');
set(handles.axes28, 'XColor', [1 1 1]);
set(handles.axes28, 'YColor', [1 1 1]);
set(handles.axes28, 'YAxisLocation', 'left');
set(handles.axes28, 'GridColor', [0 0 0]);
set(handles.axes28, 'XGrid', 'on');
set(handles.axes28, 'YGrid', 'on');

% handles    structure with handles and user data (see GUIDATA)
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
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
      warndlg('Conecte el módulo de adquisición de datos al puerto USB, si ya está conectado desconecte y vuelva a conectar.','Arduino no conectado');
      warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
      javaFrame = get(gcf,'JavaFrame');
      javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
      return;
    end
    
    mostrarFecha(handles, fix(clock));
    global horaInicio;
    horaInicio = datetime('now');
    
    set(handles.statusText, 'Visible', 'on');
    set(handles.statusText, 'String', 'Leyendo');
    
    %leer información
    set(handles.popV, 'Enable', 'on');
    set(handles.popR, 'Enable', 'on');
    reading(placa, archivo, nombreArchivo, handles);
end

function reading(pArduino, archivo, nombreArchivo, handles)
  set(handles.pauseButton, 'String', 'Pausar');
  set(handles.startButton, 'Enable', 'off');
  set(handles.pauseButton, 'Enable', 'on');
  set(handles.stopButton, 'Enable', 'on');
  set(handles.loadButton, 'Enable', 'off');
  set(handles.newButton, 'Enable', 'off');
  global bandera;
  bandera = 1;
  warning('');
  try
  while( strcmp(get(handles.statusText, 'String'), 'Leyendo') )
    %try
      [izq, der] = anita(pArduino); %es quien puede generar error y activar el catch
      if(bandera == getIntervalo(get(handles.popupmenu13, 'Value')))
        %escribir información
        escalaV = getScale(get(handles.popV, 'Value'));
        disV = 7.7;
        fprintf(archivo, '%.3f,\t', (disV - (izq - 4))*escalaV / disV);
      
        escalaR = getScale(get(handles.popR, 'Value'));
        disI = 15.2;
        fprintf(archivo, '%.3f\r\n', (disI - (der - 4))*escalaR / disI);
        bandera = 1;
      else
        bandera = bandera + 1;
      end
      
      dibujaPotencial(handles, nombreArchivo, escalaV);
      dibujaResistividad(handles, nombreArchivo, escalaR);
      pause(.1); %dibujar la gráfica cada .1 segundos
      %ajustar el tiempo transcurrido
      global horaInicio;
      set(handles.elapsedTimeField, 'String', char(diff([horaInicio datetime('now')])));
  end % end while
  disp('se ha detenido la lectura');
  catch
    disp('se ha desconectado el arduino');
    warndlg('Se ha desconectado el arduino, cierre la ventana, vuelva a conectar y abrir su archivo');
    warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    javaFrame = get(gcf,'JavaFrame');
    javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
    set(handles.pauseButton, 'Enable', 'off');
    set(handles.stopButton, 'Enable', 'off');
    
    global placa;
    global archivo;
    global nombreArchivo;
    
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
  set(handles.statusText, 'String', 'Detenido');
  set(handles.pauseButton, 'Enable', 'off');
  set(handles.startButton, 'Enable', 'off');
  set(handles.stopButton, 'Enable', 'off');
  
  set(handles.loadButton, 'Enable', 'on');
  set(handles.newButton, 'Enable', 'on');
end

function pdfButton_Callback(hObject, eventdata, handles)
  pdfGUI();
end

function fourierButton_Callback(hObject, eventdata, handles)
  fourierGUI();
end

function aboutButton_Callback(hObject, eventdata, handles)
  about();
end

function loadButton_Callback(hObject, eventdata, handles)
  global nombreArchivo;
  global archivo;
  if(archivo >= 3) %identificador de archivo mayor o igual a 3, significan archivo OK
    fclose(archivo); %cerrar el viejo archivo
  end
  [file, path] = uigetfile('.csv', 'Abrir archivo de datos...');
  if(file == 0) %se hizo clic en cancelar
    return;
  end
  nombreArchivo = strcat(path, file);
  archivo = fopen(nombreArchivo, 'a');
  
  set(handles.startButton, 'enable', 'on');
  
  dibujaPotencial(handles, nombreArchivo, getScale(get(handles.popV, 'Value')));
  dibujaResistividad(handles, nombreArchivo, getScale(get(handles.popR, 'Value')));
  set(handles.popV, 'Enable', 'on');
  set(handles.popR, 'Enable', 'on');
end

function newButton_Callback(hObject, eventdata, handles)
  global nombreArchivo;
  global archivo;
  if(archivo >= 3) %identificador de archivo mayor o igual a 3, significan archivo OK
    fclose(archivo); %cerrar el viejo archivo
  end
  nombreArchivo = crearArchivo(); %es el nombre del archivo
  if(strcmp(nombreArchivo, ''))%se hizo clic en cancelar y por tanto no hay archivo creado
    return;
  end
  archivo = fopen(nombreArchivo, 'w');      %es el apuntador del archivo
  set(handles.startButton, 'enable', 'on');
    
  plot(handles.axes27, [0]);
  xlabel(handles.axes27, 'Potencial Natural (mV)');
  ylabel(handles.axes27, 'Lecturas realizadas');
  set(handles.axes27, 'YLim', [0 10]);
  set(handles.axes27, 'YTick', [0:1:10]);
  set(handles.axes27, 'XLim', [0 10]);
  set(handles.axes27, 'XTick', [0:1:10]);
  set(handles.axes27, 'CameraUpVector', [0 -1 0]);
  set(handles.axes27, 'FontSize', 12);
  set(handles.axes27, 'FontWeight', 'bold');
  set(handles.axes27, 'XColor', [1 1 1]);
  set(handles.axes27, 'YColor', [1 1 1]);
  set(handles.axes27, 'YAxisLocation', 'right');
  set(handles.axes27, 'GridColor', [0 0 0]);
  set(handles.axes27, 'XGrid', 'on');
  set(handles.axes27, 'YGrid', 'on');
  
  plot(handles.axes28, [0]);
  set(handles.axes28, 'FontName', 'MS Sans Serif');
  ylabel(handles.axes28, 'Resistividad (Ohms)');
  xlabel(handles.axes28, 'Lecturas realizadas');
  set(handles.axes28, 'YLim', [0 10]);
  set(handles.axes28, 'YTick', [0:1:10]);
  set(handles.axes28, 'XLim', [0 10]);
  set(handles.axes28, 'XTick', [0:1:10]);
  set(handles.axes28, 'CameraUpVector', [-1 0 0]);
  set(handles.axes28, 'FontSize', 12);
  set(handles.axes28, 'FontWeight', 'bold');
  set(handles.axes28, 'XColor', [1 1 1]);
  set(handles.axes28, 'YColor', [1 1 1]);
  set(handles.axes28, 'YAxisLocation', 'left');
  set(handles.axes28, 'GridColor', [0 0 0]);
  set(handles.axes28, 'XGrid', 'on');
  set(handles.axes28, 'YGrid', 'on');
end

% --- Executes on selection change in popV.
function popV_Callback(hObject, eventdata, handles)
  global nombreArchivo;  
  dibujaPotencial(handles, nombreArchivo, getScale(get(handles.popV, 'Value')));
end

% --- Executes during object creation, after setting all properties.
function popV_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in popR.
function popR_Callback(hObject, eventdata, handles)
  global nombreArchivo;
  dibujaResistividad(handles, nombreArchivo, getScale(get(handles.popR, 'Value')));
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

    plot(handles.axes27, v, 1:filas);
    set(handles.axes27, 'XLim', [0 escalaV]);
    
    if(filas == 0)
      plot(handles.axes27, [0]);
      return;
    end
    
    set(handles.axes27,'YTick', [1:fix(filas/20):filas]);
    set(handles.axes27, 'XTick', [0:escalaV/10:escalaV]);
    set(handles.axes27, 'YLim', [0 filas]);
    set(handles.maxV, 'String', sprintf('%.3f', max(v)) );
    set(handles.minV, 'String', sprintf('%.3f', min(v)) );
end

function dibujaResistividad(handles, archivo, escalaR)
    dataset = load(archivo);
    [filas, columnas] = size(dataset);
    r = dataset(filas+1:end);    
    
    if(filas == 0)
      plot(handles.axes28, [0]);
      return;
    end

    plot(handles.axes28, 1:filas, r, 'r');
    set(handles.axes28, 'XLim', [0 filas]);
    set(handles.axes28, 'YLim', [0 escalaR]);
    set(handles.axes28,'XTick', [1:fix(filas/20):filas]);
    set(handles.axes28, 'YTick', [0:escalaR/10:escalaR]); %esto dibuja los cuadritos
    
    set(handles.maxR, 'String', sprintf('%.3f', max(r)) );
    set(handles.minR, 'String', sprintf('%.3f', min(r)) );
end

% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
  global bandera;
  bandera = 1;
end

function popupmenu13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes when user attempts to close
function GUI_CloseRequestFcn(hObject, eventdata, handles)
  global archivo;
  if(archivo >= 3) %identificador de archivo mayor o igual a 3, significan archivo cargado
    fclose(archivo); %cerrar el viejo archivo
    disp('cerrando apuntador de archivo');
  end
  clear global placa;
  clear global archivo;
  clear global nombreArchivo;
  closereq;
end