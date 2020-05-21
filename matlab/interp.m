function varargout = interp(varargin)
% INTERP MATLAB code for interp.fig
%      INTERP, by itself, creates a new INTERP or raises the existing
%      singleton*.
%
%      H = INTERP returns the handle to a new INTERP or the handle to
%      the existing singleton*.
%
%      INTERP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERP.M with the given input arguments.
%
%      INTERP('Property','Value',...) creates a new INTERP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interp

% Last Modified by GUIDE v2.5 30-Sep-2017 17:15:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interp_OpeningFcn, ...
                   'gui_OutputFcn',  @interp_OutputFcn, ...
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


% --- Executes just before interp is made visible.
function interp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interp (see VARARGIN)

handles.updown = 'none';            % Mouse updown state
handles.plotbox = [0 0 1 1];        % Plot area parameters in pixels
handles.set1 = [0 0; 1 1];
handles.set2 = [0 0; 1 1];
handles.set3 = [0 0; 1 1];
handles.set4 = [0 0; 1 1];
handles.curve = 'set1';             % Structure name of selected curve
handles.cindex = 1;                 % Index of selected curve
handles.node = 0;                   % Index of selected control point
handles.below = 1;                  % Index of node below control point
handles.above = 2;                  % Index of node above control point
handles.smooth = [0;0;0;0];         % Curve smoothing states
handles.slope = [0;0;0;0];          % Curve end slope control states
handles.cdf = [0;0;0;0];            % Curve CDF states
handles.pdf = [0;0;0;0];            % Curve PDF states
handles.output = [];                % Output image handle
handles.df = [];                    % Input PDFs and CDFs
handles.colortype = 'rgb';          % Input image color space
handles.input = [];                 % Input image data
handles.imagemap = 1;               % Image map enable
handles.graybar = [];               % pseudo (gray) bar image
handles.colorbar = [];              % Color (hue) bar image


% Choose default command line output for interp
handles.output = hObject;

% Initialize GUI
grid(handles.curve_axes, 'on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in smooth_check.
function smooth_check_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject, 'Value')
    handles.smooth(handles.cindex) = 1;
    nodes = handles.(handles.curve);
    nodes = spreadout(nodes);
    handles = setfield(handles, handles.curve, nodes);
else
    handles.smooth(handles.cindex) = 0;
end
guidata(hObject, handles);
set(handles.interp, 'Pointer', 'watch');
graph(handles); % render(handles);
set(handles.interp, 'Pointer', 'arrow');

% --- Executes on button press in clampends_check.
function clampends_check_Callback(hObject, eventdata, handles)
% hObject    handle to clampends_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of clampends_check


% --- Executes on button press in showpdf_check.
function showpdf_check_Callback(hObject, eventdata, handles)
% hObject    handle to showpdf_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showpdf_check


% --- Executes on button press in showcdf_check.
function showcdf_check_Callback(hObject, eventdata, handles)
% hObject    handle to showcdf_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showcdf_check


% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset_all.
function reset_all_Callback(hObject, eventdata, handles)
% hObject    handle to reset_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.curve_axes, 'Units', 'pixels');
handles.plotbox = get(handles.curve_axes, 'Position');
set(handles.curve_axes, 'Units', 'normalized');
[inplot, x, y] = getCursor(hObject, handles);
if inplot
    nodes = handles.(handles.curve);
    below = find(x > nodes(:, 1), 1, 'last'); 
    above = min(below + 1, size(nodes, 1));
    if (x - nodes(below, 1)) > (nodes(above, 1) - x)
        node = above;
    else
        node = below;
    end
    deletenode = 0;
    
    switch get(hObject, 'SelectionType')
        case 'normal'   % Users click left mouse button
            if node == above 
                above = min(above + 1, size(nodes, 1));
            elseif node == below
                below = max(below - 1, 1);
            end
            if node == size(nodes, 1)
                below = above;
            elseif node == 1
                above = below;
            end
            if x > nodes(above, 1)
                x = nodes(above, 1);
            elseif x < nodes(below, 1)
                x = nodes(below, 1);
            end
            handles.node = node; handles.updown = 'down';
            handles.below = below; handles.above = above;
            nodes(node, :) = [x y];
        case 'extend'   % Shift-click left button
            if isempty(find(nodes(:, 1) == x, 1))
                nodes = [nodes(1:below, :); [x y]; nodes(above:end, :)];
                handles.node = above; handles.updown = 'down';
                handles.below = below;  handles.above = above + 1;
            end
        case 'alt'
            if (node ~= 1) && (node ~= size(nodes, 1))
                nodes(node,:) = []; deletenode = 1;
            end
            handles.node = 0;
            handles.input_text = '';
            handles.output_text = '';
    end
    handles.(handles.curve) = nodes;
    guidata(hObject, handles);
    graph(handles);
    if deletenode
        %render(handles);
    end
end


% User Define Fucntions
% --------------------------------------------------------------------%
function [inplot, x, y] = getCursor(h, handles)
    set(h, 'Units', 'pixels');
    p = get(h, 'CurrentPoint');
    x = (p(1,1) - handles.plotbox(1)) / handles.plotbox(3);
    y = (p(1,2) - handles.plotbox(2)) / handles.plotbox(4);
    if x > 1.05 || x < -0.05 || y > 1.05 || y < -0.05
        inplot = 0;
    else
        x = min(x, 1); x = max(x, 0);
        y = min(y, 1); y = max(y, 0);
        nodes = handles.(handles.curve);
        x = round(256*x)/256;
        inplot = 1;
        point_text = sprintf('Current Point: [%f %f]', x, y);
        set(handles.input_text, 'String', num2str(x, 3));
        set(handles.output_text, 'String', num2str(y, 3));
        set(handles.current_point, 'String', point_text);
        set(h, 'Units', 'normalized');
    end
    
% --------------------------------------------------------------------%
function graph(handles)
% Interpolate and plot mapping functions and optional reference
% PDF(s) or CDF(s)
nodes = handles.(handles.curve);
disp(nodes);
c = handles.cindex; dfx = 0:1/255:1;
colors = ['k' 'r' 'g' 'b'];
grid(handles.curve_axes, 'on');
% For piecewise linear interpolation, plot a map, map + PDF/CDF, or 
% map + 3 PDFs/CDFs.
if ~handles.smooth(handles.cindex)
    if (~handles.pdf(c) && ~handles.cdf(c)) || (size(handles.df, 2)==0)
        plot(handles.curve_axes, nodes(:, 1), nodes(:,2), 'b-',...
             nodes(:, 1), nodes(:, 2), 'ko');
    elseif c > 1
        i = 2 * c - 2 - handles.pdf(c);
        plot(handle.curve_axes, dfx, handles.df(i, :), [colors(c) '-'], ...
             nodes(:, 1), nodes(:, 2), 'k-', ...
             nodes(:, 1), nodes(:, 2), 'ko');
    elseif c == 1
        i = handles.cdf(c);
        plot(handle.curve_axes, dfx, handles.df(i+1, :), 'r-', ...
             dfx, handles.df(i+3, :), 'g-', ...
             dfx, handles.df(i+5, :), 'b-', ...
             nodes(:, 1), nodes(:,2), 'k-',...
             nodes(:, 1), nodes(:, 2), 'ko');
    end
else
    x = 0:0.01:1;
    if ~handles.slope(handles.cindex)
        y = spline(nodes(:, 1), nodes(:, 2), x);
    else
        y = spline(nodes(:, 1), [0; nodes(:, 2); 0], x);
    end
    y(y > 1) = 1;
    y(y < 0) = 0;
    if (~handles.pdf(c) && ~handles.cdf(c)) || (size(handles.df, 2)==0)
        plot(handle.curve_axes, nodes(:, 1), nodes(:, 2), 'ko', x,  y, 'b-');            
    elseif c > 1
        i = 2 * c - 2 - handles.pdf(c);
        plot(handles.curve_axes, dfx, handles.df(i, :), [colors(c) '-'], ...
              nodes(:, 1), nodes(:, 2), 'ko', x, y, 'k-');
    elseif c == 1
        i = handles.cdf(c);
        plot(handles.curve_axes, dfx, handles.df(i+1, :), 'r-', ...
             dfx, handles.df(i + 3, :), 'g-', ...
             dfx, handles.df(i + 5, :), 'b-', ...
             nodes(:, 1), nodes(:, 2), 'ko', x, y, 'k-');
    end
end
% Put legend if more than two curves are shown
s = handles.colortype;
if strcmp(s, 'ntsc')
    s = 'yiq';
end
if (c == 1) && (handles.pdf(c) || handles.cdf(c))
    s1 = ['-- ' upper(s(1))];
    if length(s) == 3
        s2 = ['-- ' upper(s(2))]; s3 = ['-- ' upper(s(3))];
    else
        s2 = ['-- ' upper(s(2)) s(3)]; s3 = ['-- ' upper(s(4)) s5];
    end
else
    s1 = ''; s2 = ''; s3 = '';
end
%set(handles.red_text, 'String', s1);
%set(handles.green_text, 'String', s2);
%set(handles.blue_text, 'String', s3);
