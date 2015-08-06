function varargout = proto_gui(varargin)
% PROTO_GUI MATLAB code for proto_gui.fig
%      PROTO_GUI, by itself, creates a new PROTO_GUI or raises the existing
%      singleton*.
%
%      H = PROTO_GUI returns the handle to a new PROTO_GUI or the handle to
%      the existing singleton*.
%
%      PROTO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROTO_GUI.M with the given input arguments.
%
%      PROTO_GUI('Property','Value',...) creates a new PROTO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proto_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proto_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proto_gui

% Last Modified by GUIDE v2.5 30-Jul-2015 14:57:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proto_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @proto_gui_OutputFcn, ...
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


% --- Executes just before proto_gui is made visible.
function proto_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proto_gui (see VARARGIN)

% Choose default command line output for proto_gui

%preset values for scan id, sequence id, and modeling parameter inputs
handles.output = hObject;
handles.scani = NaN;
handles.seqi = NaN;
zf = 1;
handles.zf = zf;
handles.x0 = 0;
handles.y0 = 0;
handles.radius = 0;
handles.a = 0;
handles.windspeed = 0;
handles.birdspeed = 0;
set(handles.slider4, 'min', 0);
set(handles.slider4, 'max', 7);
set(handles.slider5, 'min', 0);
set(handles.slider5, 'max', 10);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proto_gui wait for user response (see UIRESUME)
end


% --- Outputs from this function are returned to the command line.
function varargout = proto_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a
%        double

%get x0 from user 
x0 = str2double(get(hObject,'String'));
handles.x0 = x0;
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

%get y0 from user 
y0 = str2double(get(hObject,'String'));
handles.y0 = y0;
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

%get radius from user
radius = str2double(get(hObject,'String'));
handles.radius = radius;
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

%get intensity a from user 
a = str2double(get(hObject,'String'));
handles.a = a;
guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
%guidata( handles.edit4, handles );

% data1 = guidata(handles.edit1);
% data2 = guidata(handles.edit2);
% data3 = guidata(handles.edit3);

%print out user-set bird and wind speed
handles.birdspeed
handles.windspeed
%axes4 is the left display, axes6 is the right display

if(~isnan(handles.scani) && ~isnan(handles.seqi))

%get actual roost,coordinate vectors, reflectivity and radial velocity
[roo,radar,DZ] = getRoost(handles.scani,handles.seqi);    
[x,y,Z] = getDisplay(radar);
VR = getVR(radar);
%get coordinate matrices (600x600)
[Y, X] = ndgrid(y,x);
%zf (zoom factor) is the amount of zoom in or out 
%border2 controls the limits of the display windows, based on the zoom
%factor (zf)
handles.zf = 1;
border2 = X < (roo.x+(roo.r+(roo.r))*(handles.zf)) & X > (roo.x-(roo.r+(roo.r))*(handles.zf)) & Y < roo.y+(roo.r+(roo.r))*(handles.zf) & Y > roo.y-(roo.r+(roo.r))*(handles.zf);
%display window limits
xlimit = [min(X(border2)) max(X(border2))];
ylimit = [min(Y(border2)) max(Y(border2))];
%code for drawing model and label circles
th = 0:pi/50:2*pi;
xu = roo.r * cos(th) + roo.x;
yu = roo.r * sin(th) + roo.y;
vrlim = [-15 15];
dzlim = [-5 30];

%%%%%%%%%%%%%reflectivity modeling%%%%%%%%%%%%%%%%%%



%display predicted roost 

% axes(handles.axes4);  
%     [x,y,pz] = genRoost(handles.x0, handles.y0, handles.radius, handles.a);
%     colormap(handles.axes4,parula);
%     imagesc(x, y, pz, dzlim); 
%     colorbar;
% 
% 
% %display actual roost
% 
% axes(handles.axes6)
%     imagesc(x, y, Z, dzlim);
%     colorbar;    
%     hold on; 
%     quiver(X,Y,UV,VV,2);
%find loss and display
%     border = X < (roo.x+(roo.r+(roo.r/2))) & X > (roo.x-(roo.r+(roo.r/2))) & Y < roo.y+(roo.r+(roo.r/2)) & Y > roo.y-(roo.r+(roo.r/2));
%     dbZ = DZ(border);
%     dbZ = dbZ(~isnan(dbZ));
%     Y2 = Y(border);
%     X2 = X(border);
%     Y2 = Y2(~isnan(dbZ));
%     X2 = X2(~isnan(dbZ));
%     loss = lossF2([handles.x0,handles.y0,handles.radius,handles.a],X2,Y2,dbZ);
%      set(handles.text14,'String',num2str(loss));
    % show the image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%velocity modeling%%%%%%%%%%%%%%%%%%

%display actual radial velocity
axes(handles.axes6)
[uwind,vwind] = windshift(roo,handles.scani,handles.seqi,handles.windspeed);
[V,UV,VV,vr] = getVelocity(roo.x,roo.y,X,Y,uwind,vwind,handles.birdspeed);
colormap(handles.axes6,vrmap2(32));
imagesc(x,y,VR, vrlim); 
colorbar;

%display predicted radial velocity
axes(handles.axes4);
colormap(handles.axes4,vrmap2(32)); 
imagesc(x,y,vr,vrlim);
colorbar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    
    %set window limits and save circle dimensions 
    xlim(handles.axes6,xlimit);
    ylim(handles.axes6,ylimit);
    xlim(handles.axes4,xlimit);
    ylim(handles.axes4,ylimit);
    handles.roo = roo;
    handles.X = X;
    handles.Y = Y;
    handles.x = x;
    handles.y = y;
    handles.Z = Z;
    handles.xu = xu;
    handles.yu = yu;
    guidata(hObject,handles);

end
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns conxtents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

%get scan ID
scani = str2double(get(hObject,'String'));
handles.scani = scani;
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

%get sequence ID
seqi = str2double(get(hObject,'String'));
handles.seqi = seqi;
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%add predicted roost circle to both actual and predicted roost displays 
axes(handles.axes4); 
hold on;
plot(handles.x0,handles.y0, 'Marker', 'x', 'MarkerSize', 10, 'LineWidth', 5, 'color', 'red');
hold on;
th = 0:pi/50:2*pi;
xunit = handles.radius * cos(th) + handles.x0;
yunit = handles.radius * sin(th) + handles.y0;
plot(xunit, yunit,'LineWidth', 5,'color', 'red');
axes(handles.axes6);
hold on;
plot(handles.x0,handles.y0, 'Marker', 'x', 'MarkerSize', 10, 'LineWidth', 5, 'color', 'red');
th = 0:pi/50:2*pi;
xunit = handles.radius * cos(th) + handles.x0;
yunit = handles.radius * sin(th) + handles.y0;
plot(xunit, yunit,'LineWidth', 5,'color', 'red');
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%add labeled roost circle to actual roost display 
axes(handles.axes6);
hold on;
plot(handles.xu, handles.yu,'LineWidth', 3,'color', 'white'); 
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  
    handles.zf = handles.zf*(4/3);
    guidata(hObject,handles);
    roo = handles.roo;
    border2 = handles.X < (roo.x+(roo.r+(roo.r))*(handles.zf)) & handles.X > (roo.x-(roo.r+(roo.r))*(handles.zf)) & handles.Y < (roo.y+(roo.r+(roo.r))*(handles.zf)) & handles.Y > (roo.y-(roo.r+(roo.r))*(handles.zf));
       
if(-150000 < min(handles.X(border2)) && -150000 < min(handles.Y(border2)) && 150000 > max(handles.X(border2)) && 150000 > max(handles.Y(border2)))
    
    xlimit = [min(handles.X(border2)) max(handles.X(border2))];
    ylimit = [min(handles.Y(border2)) max(handles.Y(border2))];
    xlim(handles.axes6,xlimit);
    ylim(handles.axes6,ylimit);
    xlim(handles.axes4,xlimit);
    ylim(handles.axes4,ylimit);
else
    handles.zf = handles.zf*(3/4);
    guidata(hObject,handles);
    
end
end
    

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  handles.zf = handles.zf*.75;
    guidata(hObject,handles);
    roo = handles.roo;
    border2 = handles.X < (roo.x+(roo.r+(roo.r))*(handles.zf)) & handles.X > (roo.x-(roo.r+(roo.r))*(handles.zf)) & handles.Y < roo.y+(roo.r+(roo.r))*(handles.zf) & handles.Y > roo.y-(roo.r+(roo.r))*(handles.zf);

if(handles.zf > .1)
    
    xlimit = [min(handles.X(border2)) max(handles.X(border2))];
    ylimit = [min(handles.Y(border2)) max(handles.Y(border2))];
    xlim(handles.axes6,xlimit);
    ylim(handles.axes6,ylimit);
    xlim(handles.axes4,xlimit);
    ylim(handles.axes4,ylimit);
    guidata(hObject,handles);
else
    handles.zf = handles.zf*(4/3); 
    guidata(hObject,handles);
end
  
end
  


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.birdspeed = get(handles.slider4,'Value');
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.windspeed = get(handles.slider5,'Value');
guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end
