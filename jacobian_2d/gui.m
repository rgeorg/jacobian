function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 04-Jun-2017 14:34:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_g(see VARARGIN)

% Do initial calculations
[handles.s, handles.d] = initialise();

% Get initial parameters from the GUI
handles.d.t1 = deg2rad(str2double(get(handles.t1_value,'String')));
handles.d.t2 = deg2rad(str2double(get(handles.t2_value,'String')));
handles.d.L1 = str2double(get(handles.L1_value,'String'));
handles.d.L2 = str2double(get(handles.L2_value,'String'));
handles.d.ddt_t1 = deg2rad(str2double(get(handles.ddt_t1_value,'String')));
handles.d.ddt_t2 = deg2rad(str2double(get(handles.ddt_t2_value,'String')));

% Set up figure
hold on;
axis equal;
grid on;
cameratoolbar('SetMode','orbit');
cameratoolbar('SetCoordSys','y')
xlim([-1 1]);
zlim([-1 1]);
ylim([0 1]);

% Plot robot arm
[handles.d] = updateArm(handles.s, handles.d);

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function t1_value_Callback(hObject, eventdata, handles)
% hObject    handle to t1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Delete old robot arm
delete(findall(gcf,'type','text'));
delete(findall(gcf,'type','line'));
delete(findall(gcf,'type','quiver'));

% Get new parameter
handles.d.t1 = deg2rad(str2double(get(hObject,'String')));

% Plot new robot arm
[handles.d] = updateArm(handles.s, handles.d);

% Save changes
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function t1_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function t2_value_Callback(hObject, eventdata, handles)
% hObject    handle to t2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(findall(gcf,'type','text'));
delete(findall(gcf,'type','line'));
delete(findall(gcf,'type','quiver'));
handles.d.t2 = deg2rad(str2double(get(hObject,'String')));
[handles.d] = updateArm(handles.s, handles.d);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function t2_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function L1_value_Callback(hObject, eventdata, handles)
% hObject    handle to L1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(findall(gcf,'type','text'));
delete(findall(gcf,'type','line'));
delete(findall(gcf,'type','quiver'));
handles.d.L1 = str2double(get(hObject,'String'));
[handles.d] = updateArm(handles.s, handles.d);
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of L1_value as text
%        str2double(get(hObject,'String')) returns contents of L1_value as a double


% --- Executes during object creation, after setting all properties.
function L1_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function L2_value_Callback(hObject, eventdata, handles)
% hObject    handle to L2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(findall(gcf,'type','text'));
delete(findall(gcf,'type','line'));
delete(findall(gcf,'type','quiver'));
handles.d.L2 = str2double(get(hObject,'String'));
[handles.d] = updateArm(handles.s, handles.d);
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of L2_value as text
%        str2double(get(hObject,'String')) returns contents of L2_value as a double


% --- Executes during object creation, after setting all properties.
function L2_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in s_sol.
function s_sol_Callback(hObject, eventdata, handles)
% hObject    handle to s_sol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
symbolicSolutions(handles.s);


% --- Executes on button press in d_sol.
function d_sol_Callback(hObject, eventdata, handles)
% hObject    handle to d_sol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
decimalSolutions(handles.s, handles.d);



function ddt_t1_value_Callback(hObject, eventdata, handles)
% hObject    handle to ddt_t1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.d.ddt_t1 = deg2rad(str2double(get(hObject,'String')));
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of ddt_t1_value as text
%        str2double(get(hObject,'String')) returns contents of ddt_t1_value as a double


% --- Executes during object creation, after setting all properties.
function ddt_t1_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddt_t1_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ddt_t2_value_Callback(hObject, eventdata, handles)
% hObject    handle to ddt_t2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.d.ddt_t2 = deg2rad(str2double(get(hObject,'String')));
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of ddt_t2_value as text
%        str2double(get(hObject,'String')) returns contents of ddt_t2_value as a double


% --- Executes during object creation, after setting all properties.
function ddt_t2_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ddt_t2_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
