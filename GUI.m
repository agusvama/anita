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
    
    fecha = fix(clock);
    nombreArchivo = strcat('projects/', int2str(fecha(1)), '-', ... %año
                                        int2str(fecha(2)), '-', ... %mes
                                        int2str(fecha(3)), '@', ... %dia
                                        int2str(fecha(4)), '_', ... %hora
                                        int2str(fecha(5)), '_', ... %minuto
                                        int2str(fecha(6)),      ... %segundo
                                        '.csv'                  ... %formato
                          );                                 
    archivo = fopen(nombreArchivo, 'a');
    %colocar fecha automáticamente
    set(handles.datefield, 'String', strcat(int2str(fecha(3)), '/', ...
                                            int2str(fecha(2)), '/', ...
                                            int2str(fecha(1))       ...
        ));
    if(fecha(5) <= 9)
      set(handles.timefield, 'String', strcat(int2str(fecha(4)), ':0', ...
                                              int2str(fecha(5))       ...
        ));
    else
      set(handles.timefield, 'String', strcat(int2str(fecha(4)), ':', ...
                                              int2str(fecha(5))       ...
        ));
    end
    set(handles.text5, 'visible', 'on');
    %leer información
    reading(placa, archivo, nombreArchivo);
    set(handles.text5, 'visible', 'off');
    fclose(archivo);
    delete(instrfind({'Port'},{'COM3'}));
end

function reading(pArduino, archivo, nombreArchivo)
  warning('');
  while(true)
    try
      [izq, der] = anita(pArduino);
      %escribir información
      fprintf(archivo, '%.3f,\t', izq);
      fprintf(archivo, '%.3f\r\n', der);
      
      dibuja(nombreArchivo);
      pause(.1);
      
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
