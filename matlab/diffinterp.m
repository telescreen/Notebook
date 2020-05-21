function varargout = diffinterp(varargin)
% DIFFINTERP MATLAB code for diffinterp.fig
%      DIFFINTERP, by itself, creates a new DIFFINTERP or raises the existing
%      singleton*.
%
%      H = DIFFINTERP returns the handle to a new DIFFINTERP or the handle to
%      the existing singleton*.
%
%      DIFFINTERP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIFFINTERP.M with the given input arguments.
%
%      DIFFINTERP('Property','Value',...) creates a new DIFFINTERP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before diffinterp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to diffinterp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help diffinterp

% Last Modified by GUIDE v2.5 20-Aug-2017 23:23:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @diffinterp_OpeningFcn, ...
                   'gui_OutputFcn',  @diffinterp_OutputFcn, ...
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


% --- Executes just before diffinterp is made visible.
function diffinterp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to diffinterp (see VARARGIN)

load('f:\data\myhand.mat','x','y');
handles.x = x;
handles.y = y;
n = length(x);
s = (1:n)';
t = (1:.05:n)';
handles.piecelinu = piecelin(s, handles.x, t);
handles.piecelinv = piecelin(s, handles.y, t);
handles.polyinterpu = polyinterp(s, handles.x, t);
handles.polyinterpv = polyinterp(s, handles.y, t);
handles.splinetxu = splinetx(s, handles.x, t);
handles.splinetxv = splinetx(s, handles.y, t);
handles.pchiptxu = pchiptx(s, handles.x, t);
handles.pchiptxv = pchiptx(s, handles.y, t);

handles.piecelin_checked = 0;
handles.polyinterp_checked = 0;
handles.splinetx_checked = 0;
handles.pchiptx_checked = 0;

Draw(handles);

% Choose default command line output for diffinterp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes diffinterp wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = diffinterp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in piecelin_checkbox.
function piecelin_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to piecelin_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of piecelin_checkbox
handles.piecelin_checked = get(hObject, 'Value');
Draw(handles);
guidata(hObject, handles);

% --- Executes on button press in polyinterp_checkbox.
function polyinterp_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to polyinterp_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of polyinterp_checkbox
handles.polyinterp_checked = get(hObject, 'Value');
Draw(handles);
guidata(hObject, handles);

% --- Executes on button press in splinetx_checkbox.
function splinetx_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to splinetx_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of splinetx_checkbox
handles.splinetx_checked = get(hObject, 'Value');
Draw(handles);
guidata(hObject, handles);

% --- Executes on button press in pchiptx_spline.
function pchiptx_spline_Callback(hObject, eventdata, handles)
% hObject    handle to pchiptx_spline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pchiptx_checked = get(hObject, 'Value');
Draw(handles);
guidata(hObject, handles);

% --- Execute draw
function Draw(handles)
plot(handles.x, handles.y, 'bo', 'DisplayName', 'data');
hold on;
if handles.piecelin_checked == 1
    plot(handles.piecelinu, handles.piecelinv, '-', 'DisplayName', 'PieceLin');
end
if handles.polyinterp_checked == 1
    plot(handles.polyinterpu, handles.polyinterpv, '-', 'DisplayName', 'PolyInterp');
end
if handles.splinetx_checked == 1
    plot(handles.splinetxu, handles.splinetxv, '-', 'DisplayName', 'Spline');
end
if handles.pchiptx_checked == 1
    plot(handles.pchiptxu, handles.pchiptxv, '-', 'DisplayName', 'Pchip');
end
hold off;
axis([0.3 0.65 0 1]);
legend('show', 'location', 'southeast');
title('Hands Interpolation');
