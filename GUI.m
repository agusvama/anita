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
    try
      placa = iniciarArduino('COM3');
    catch
      warndlg('arduino no conectado');
      return;
    end
    
    d = fix(clock);
    nombreArchivo = strcat('projects/', int2str(d(1)), '-', int2str(d(2)), '-', ...
                    int2str(d(3)), '@', int2str(d(4)), '_', int2str(d(5)),...
                    '_', int2str(d(6)), '.csv');
    archivo = fopen(nombreArchivo, 'a');
    
    set(handles.text5, 'visible', 'on');
    reading(placa, archivo, nombreArchivo);
    set(handles.text5, 'visible', 'off');
    fclose(archivo);
end

function reading(pArduino, archivo, nombreArchivo)
  warning('');
  while(true)
    try
      [izq, der] = anita(pArduino);
      fprintf(archivo, '%.3f,\t', izq);
      fprintf(archivo, '%.3f\r\n', der);
      
      dibuja(nombreArchivo);
      pause(1);
      
      if( strcmp('Unsuccessful read: A timeout occurred before the Terminator was reached..', lastwarn) )
        fclose(placa);
        return;
      end
    
    catch
      disp('unplugged arduino');
      clear;
      return;
    end
  end
end

% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
  close all;
end
