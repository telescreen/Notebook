function varargout = ice(varargin)
% ICE MATLAB code for ice.fig
%      ICE, by itself, creates a new ICE or raises the existing
%      singleton*.
%
%      H = ICE returns the handle to a new ICE or the handle to
%      the existing singleton*.
%
%      ICE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICE.M with the given input arguments.
%
%      ICE('Property','Value',...) creates a new ICE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ice_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ice_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ice

% Last Modified by GUIDE v2.5 27-Aug-2017 16:46:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ice_OpeningFcn, ...
                   'gui_OutputFcn',  @ice_OutputFcn, ...
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


% --- Executes just before ice is made visible.
function ice_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ice (see VARARGIN)

handles.updown = 'none';
handles.plotbox = [0 0 1 1];
handles.set1 = [0 0; 1 1];
handles.set2 = [0 0; 1 1];
handles.set3 = [0 0; 1 1];
handles.set4 = [0 0; 1 1];
handles.curve = 'set1';
handles.cindex = 1;
handles.node = 0;
handles.below = 1;
handles.above = 2;
handles.smooth = [0; 0; 0; 0];
handles.slope = [0; 0; 0; 0];
handles.cdf = [0; 0; 0; 0];
handles.pdf = [0; 0; 0; 0];
handles.output = [];
handles.df = [];
handles.colortype = 'rgb';
handles.input = [];
handles.imagemap = 1;
handles.barmap = 1;
handles.graybar = [];
handles.colorbar = [];

% Process Property Name/Property Value input argument pairs
wait = 'on';
if (nargin > 3)
    for i = 1:2:(nargin - 3)
        if nargin - 3 == i
            break;
        end
        switch lower(varargin{i})
            case 'image'
                if ndims(varargin{i+1}) == 3
                    handles.input = varargin{i+1};
                else
                    handles.input = cat(3, varargin{i+1}, ...
                        varargin{i+1}, varargin{i+1});
                end
                handles.input = double(handles.input);
                inputmax = max(handles.input(:));
                if inputmax > 255
                    handles.input = handles.input / 65535;
                else
                    handles.input = handles.input / 255;
                end
                
            case 'space'
                handles.colortype = lower(varargin{i+1});
                switch handles.colortype
                    case 'cmy'
                        list = {'CMY' 'Cyan' 'Magenta' 'Yellow'};
                    case {'ntsc', 'yiq'}
                        list = {'YIQ' 'Luminance' 'Hue' 'Stauration'};
                        handles.colortype = 'ntsc';
                    case 'ycbcr'
                        list = {'YCbCr' 'Luminance' 'Blue' ...
                                'Difference' 'Red Difference'};
                    case 'hsv'
                        list = {'HSV' 'Hue' 'Saturation' 'Value'};
                    case 'hsi'
                        list = {'HSI' 'Hue' 'Saturation' 'Intensity'};
                    otherwise
                        list = {'RGB' 'Red' 'Green' 'Blue'};
                        handles.colortype = 'rgb';
                end
                set(handles.component_popup, 'String', list);
                
            case 'wait'
                wait = lower(varargin{i+1});
        end
    end
end

% Create a pseudo- and full-color mapping bars (grays and hues). Store a
% color space converted 1x128x3 line of each bar for mapping.
xi = 0:1/127:1; x = (0:1/6:1)';
y = [1 1 0 0 0 1 1; 
     0 1 1 1 0 0 0; 
     0 0 0 1 1 1 0]';
gb = repmat(xi, [1 1 3]);  cb = interp1(x,y,xi');
cb = reshape(cb, [1 128 3]);
if ~strcmp(handles.colortype, 'rgb')
    gb = eval(['rgb2' handles.colortype '(gb)']);
    cb = eval(['rgb2' handles.colortype '(cb)']);    
end
gb = round(255 * gb);  gb = max(0, gb);  gb = min(255, gb);
cb = round(255 * cb);  cb = max(0, cb);  cb = min(255, cb);
handles.graybar = gb;  handles.colorbar = cb;

% Do color space transforms, clamp to [0 255], compute histograms and
% cumulative distribution functions, and create output figure.
if size(handles.input, 1)
    if ~strcmp(handles.colortype, 'rgb')
        handles.input = eval(['rgb2' handles.colortype '(handles.input)']);        
    end
    handles.input = round(255 * handles.input);
    handles.input = max(0, handles.input);
    handles.input = min(255, handles.input);
    for i = 1:3
        color = handles.input(:,:,i);
        df = hist(color(:), 0:255);
        handles.df = [handles.df; df / max(df(:))];
        df = df / sum(df(:)); df = cumsum(df);
        handles.df = [handles.df; df];        
    end
    figure; handles.output = gcf;
end

% Compute screen position and display image/graph
set(0, 'Units', 'pixels');  ssz = get(0, 'Screensize');
set(handles.ice, 'Units', 'pixels');
uisz = get(handles.ice, 'Position');
if size(handles.input, 1)
    fsz = get(handles.output, 'Position');
    bc = (fsz(4) - uisz(4)) / 3;
    if bc > 0
        bc = bc + fsz(2);
    else
        bc = fsz(2) + fsz(4) - uisz(4) - 10;
    end
    lc = fsz(1) + (size(handles.input, 2) / 4) + (3 * fsz(3) / 4);
    lc = min(lc, ssz(3) - uisz(3) - 10);
    set(handles.ice, 'Position', [lc bc 463 391]);
else
    bc = round((ssz(4) - uisz(4)) / 2) - 10;
    lc = round((ssz(3) - uisz(3)) / 2) - 10;
    set(handles.ice, 'Position', [lc bc uisz(3) uisz(4)]);
end
set(handles.ice, 'Units', 'normalized');
graph(handles); render(handles);
% Choose default command line output for ice
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
if strcmpi(wait, 'on')
    uiwait(handles.ice)
end


% --- Outputs from this function are returned to the command line.
function varargout = ice_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if max(size(handles)) == 0
    figh = get(gcf);
    imageh = get(figh.Children);
    if max(size(imageh)) > 0
        image = get(imageh.Children);
        varargout{1} = image.CData;
    end
else
    varargout{1} = hObject;
end


% --- Executes on selection change in component_popup.
function component_popup_Callback(hObject, eventdata, handles)
% hObject    handle to component_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns component_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from component_popup


% --- Executes during object creation, after setting all properties.
function component_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to component_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in smooth.
function smooth_Callback(hObject, eventdata, handles)
% hObject    handle to smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of smooth


% --- Executes on button press in clampends.
function clampends_Callback(hObject, eventdata, handles)
% hObject    handle to clampends (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of clampends


% --- Executes on button press in showpdf.
function showpdf_Callback(hObject, eventdata, handles)
% hObject    handle to showpdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showpdf


% --- Executes on button press in showcdf.
function showcdf_Callback(hObject, eventdata, handles)
% hObject    handle to showcdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showcdf


% --- Executes on button press in resetCurve.
function resetCurve_Callback(hObject, eventdata, handles)
% hObject    handle to resetCurve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resetAll.
function resetAll_Callback(hObject, eventdata, handles)
% hObject    handle to resetAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%-------------------------------------------------------------------------%
function graph(handles)
% Interpolate and plot mapping functions and optional reference
% PDF or CDF
nodes = handles.curve;
c = handles.cindex; dfx = 0:1/255:1;
colors = ['k' 'r' 'g' 'b'];

if ~handles.smooth(handles.cindex)
    if (~handles.pdf(c) && ~handles.cdf(c)) || ...
            (size(handles.df, 2) == 0)
        plot(handles.curve_axes, nodes(:, 1), nodes(:, 2), 'b', ...
             nodes(:, 1), nodes(:, 2), 'ko')
    elseif c > 1
        i = 2 * c - 2 - handles.pdf(c);
        plot(handles.curve_axes, dfx, handles.df(i, :), [colors(c) '-'], ...
             nodes(:, 1), nodes(:, 2), 'k-', ...
             nodes(:, 1), nodes(:, 2), 'ko')
    elseif c == 1
        i = handles.cdf(c);
        plot(handles.curve_axes, ...
            dfx, handles.df(i+1, :), 'r-', ...
            dfx, handles.df(i + 3, :), 'g-', ...
            dfx, handles.df(i + 5, :), 'b-', ...
            nodes(:, 1), nodes(:, 2), 'k-', ...
            nodes(:, 1), nodes(:, 2), 'ko');
    end
else
    x = 0:0.01:1;
    if ~handles.slope(handles.cindex)
        y = spline(nodes(:, 1), nodes(:, 2), x);
    else
        y = spline(nodes(:, 1), [ 0; nodes(:, 2); 0], x);
    end
    y(y > 1) = 1;
    y(y < 0) = 0;
    if (~handles.pdf(c) && handles.cdf(c)) || ...
            (size(handles.df, 2) == 0)
        plot(handles.curve_axes, nodes(:,1), nodes(:,2), 'ko', x, y, 'b-');
    elseif c > 1
        i = 2*c - 2 - handles.pdf(c);
        plot(handles.curve_axes, dfx, handles.df(i,:), [colors(c) '-'], ...
             nodes(:, 1), nodes(:, 2), 'ko', x, y, 'k-');
    elseif c == 1
        i = handles.cdf(c);
        plot(handles.curve_axex, dfx, handles.df(i+1, :), 'r-', ...
            dfx, handles.df(i+3, :), 'g-', ...
            dfx, handles.df(i+5, :), 'b-', ...
            nodes(:,1), nodes(:,2), 'ko', x, y, 'k-');
    end
end

% Put legend if more than two curves are shown.
s = handles.colortype;
if strcmp(s, 'ntsc')
    s = 'yiq';
end
if (c == 1) && (handles.pdf(c) || handles.cdf(c))
    s1 = ['-- ' upper(s(1))];
    if length(s) == 3
        s2 = ['-- ' upper(s(2))]; s3 = ['-- ' upper(s(3))];
    else
        s2 = ['-- ' upper(s(2)) s(3)]; s3 = ['-- ' upper(s(4)) s(5)];        
    end
else
    s1 = ''; s2 = ''; s3 = '';
end
set(handles.red_text, 'String', s1);
set(handles.green_text, 'String', s2);
set(handles.blue_text, 'String', s3);

%------------------------------------------------------------------------%
function [inplot,x,y] = cursor(h, handles)
set(h, 'Units', 'pixels');
p = get(h, 'CurrentPoint');
x = (p(1,1) - handles.plotbox(1)) / handles.plotbox(3);
y = (p(1,2) - handles.plotbox(2)) / handles.plotbox(4);
if x > 1.05 || x < -0.05 || y > 1.05 || y < -0.05
    inplot = 0;
else
    x = min(x, 1); x = max(x, 0);
    y = min(y, 1); y = max(y, 0);
    x = round(256*x)/256;
    inplot = 1;
    set(handles.input_text, 'String', num2str(x, 3));
    set(handles.output_text, 'String', num2str(y, 3));
end
set(h, 'Units', 'normalized');
%------------------------------------------------------------------------%
function y = render(handles)
% Map the input image and bar components and convert them to RGB
set(handles.ice, 'Interruptible', 'off');
set(handles.ice, 'Pointer', 'watch');
ygb = handles.graybar;  ycb = handles.colorbar;
yi = handles.input;  mapon = handles.barmap;
imageon = handles.imagemap && size(handles.input, 1);
for i = 2:4
    nodes = getfields(handles, ['set' num2str(i)]);
    t = lut(nodes, handles.smooth(i), handles.slope(i));
    if imageon
        yi(:,:,i-1) = t(yi(:,:,i-1) + 1);
    end
    if mapon
        ygb(:,:,i-1) = t(ygb(:,:,i-1) + 1);
        ycb(:,:,i-1) = t(ycb(:,:,i-1) + 1);
    end
end
t = lut(handles.set1, handles.smooth(1), handles.slope(1));
if imageon
    yi = t(yi + 1);
end
if mapon
    ygb = t(ygb + 1); ycb = t(ycb + 1);
end
if ~strcmp(handles.colortype, 'rgb')
    if(size(handles.input, 1)
        yi = yi / 255;
        yi = eval([handles.colortype '2rgb(yi)'J);
        yi = uint8(255 * yi);
    end
    ygb = ygb / 255;  cb = ycb / 255;
    ygb = eval([handles.colortype '2rgb(ygb)']);
    ycb = eval([handles.colortype '2rgb(ycb)']);
    ygb = uint8(255 * ygb); ycb = uint8(255 * ycb);
else
    yi = uint8(yi); ygb = uint8(ygb); ycb = uint8(ycb);
end
if size(handles.input, 1)
    figure(handles.output); imshow(yi);
end
ygb = repmat(ygb, [32 1 I]); ycb = repmat(ycb, [32 1 I]);
axes(handles.gray-axes); imshow(ygb);
axes(handles.color-axes); irnshow(ycb);
figure(handles.ice); 
set(handles.ice, 'Pointer', 'arrow');
set(handles.ice, 'Interruptible', 'on');

%----------------------------------------------------------------------- %
function t = lut(nodes, smooth, slope)
% Create a 256 element mapping function from a set of control
% points. The output values are integers in the interval [O, 2551.
% Use piecewise linear or cubic spline with or without zero end
% slope interpolation.
t = 255 * nodes; i = 0:255;
if ~smooth
    t = [t; 256 2561; t = interp1(t(:, 1), t(:, 2), i');
else
    if ~slope
        t = spline(t(:, I), t(:, 2), i);
    else
        t = spline(t(:, I), [O; t(:, 2); 01, i);
    end
end
t = round(t); t = max(0, t); t = min(255, t);
%----------------------------------------------------------------------- %
function out = spreadout(in)
% Make all x values unique.
% Scan forward for non-unique x's and bump the higher indexed x--
% but don't exceed 1. Scan the entire range.
nudge = 1 1 256;
for i = 2:size(inJ 1) - 1
if in(i, 1) <= in(i - 1, 1)
in(i, 1) = min(in(i - 1, 1) + nudge, 1);
end
end
% Scan in reverse for non-unique x's and decrealje the lower indexed
% x -- but don't go below 0. Stop on the first non-unique pair.
if in(end, 1) == in(end - 1, 1)
for i = size(in, 1):-1 :2
if in(i, 1) <= in(i - 1, 1)
in(i - 1, 1) = max(in(i, 1) - nudge, 0);
else
break;
end
end
end
% If the first two x's are now the same, init the curve.
if in(1, 1) == in(2, 1)
in = [0 0; 1 I];
end
out = in; 