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
assignin('base', 'flag', true);
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
    v = [];
    r = [];
  try
    placa = iniciarArduino('COM3');
    for i = 1:10
      [izq, der] = anita(placa);
      v(i) = izq;
      r(i) = der;
      dibuja(v, r);
      pause(1);
    end
  catch
    warndlg('Arduino no conectado');
    return;
  end
  disp('éxito');
end

% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
  close all;
end


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
  flag = false;
end
