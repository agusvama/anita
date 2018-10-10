function varargout = about(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @about_OpeningFcn, ...
                   'gui_OutputFcn',  @about_OutputFcn, ...
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

function about_OpeningFcn(hObject, eventdata, handles, varargin)
imshow('logo/big/bigipn.png','Parent', handles.axes1);
imshow('logo/big/bigito.png','Parent', handles.axes3);
imshow('logo/big/bigciidir.png','Parent', handles.axes2);

warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('logo/icon.png'));
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end
% --- Outputs from this function are returned to the command line.
function varargout = about_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
end
