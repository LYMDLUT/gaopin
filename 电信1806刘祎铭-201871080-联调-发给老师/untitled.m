function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 16-Dec-2020 18:15:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

resource_name='USB0::0x1AB1::0x04B0::DS2F210800030::INSTR';
resource_named='USB0::0x1AB1::0x0641::DG4E183950102::INSTR';
handles.MSO2000A = visa('ni',resource_name);
handles.dg = dgConnect(resource_name);
handles.ddg = dgConnect(resource_named);
%enterBurstMode(dg, 1, 3, 'CENTER', 'MANUAL');
%dgDisconnect(dg);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);
set(handles.radiobutton3,'value',0);
writeCommand(handles.dg,sprintf(':CHANnel1:COUPling DC'));

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton2,'value',1);
set(handles.radiobutton1,'value',0);
set(handles.radiobutton3,'value',0);
writeCommand(handles.dg,sprintf(':CHANnel1:COUPling AC'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton3,'value',1);
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',0);
writeCommand(handles.dg,sprintf(':CHANnel1:COUPling GND'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton4,'value')
writeCommand(handles.dg,sprintf(':CHANnel1:DISPlay ON'));
else
writeCommand(handles.dg,sprintf(':CHANnel1:DISPlay OFF'));    
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton5,'value')
writeCommand(handles.dg,sprintf(':CHANnel2:DISPlay ON'));
else
writeCommand(handles.dg,sprintf(':CHANnel2:DISPlay OFF'));    
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton6,'value',1);
set(handles.radiobutton7,'value',0);
set(handles.radiobutton8,'value',0);
writeCommand(handles.dg,sprintf(':CHANnel2:COUPling DC'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton7,'value',1);
set(handles.radiobutton6,'value',0);
set(handles.radiobutton8,'value',0);
writeCommand(handles.dg,sprintf(':CHANnel2:COUPling AC'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton8,'value',1);
set(handles.radiobutton6,'value',0);
set(handles.radiobutton7,'value',0);
writeCommand(handles.dg,sprintf(':CHANnel2:COUPling GND'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':CLEar'));

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':AUToscale'));

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

writeCommand(handles.dg,sprintf(':RUN'));
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':STOP'));

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton10,'value',1);
set(handles.radiobutton11,'value',0);
set(handles.radiobutton12,'value',0);
set(handles.radiobutton13,'value',0);
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce CHANnel1'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton11,'value',1);
set(handles.radiobutton10,'value',0);
set(handles.radiobutton12,'value',0);
set(handles.radiobutton13,'value',0);
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce CHANnel2'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton12,'value',1);
set(handles.radiobutton10,'value',0);
set(handles.radiobutton11,'value',0);
set(handles.radiobutton13,'value',0);
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce EXT'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ll=num2str(get(handles.slider1,'Value'));
lll=sprintf([':TIMebase:SCALe ',ll]);
writeCommand(handles.dg,lll);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ll=num2str(get(handles.slider2,'Value'));
lll=sprintf([':CHANnel1:OFFSet ',ll]);
writeCommand(handles.dg,lll);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ll=num2str(get(handles.slider6,'Value'));
lll=sprintf([':CHANnel2:OFFSet ',ll]);
writeCommand(handles.dg,lll);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ll=num2str(get(handles.slider7,'Value'));
lll=sprintf([':CHANnel1:SCALe ',ll,'V/div']);
writeCommand(handles.dg,lll);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(handles.listbox1,'Value')==1)
writeCommand(handles.dg,sprintf(':TRIGger:SWEep AUTO'));
elseif (get(handles.listbox1,'Value')==2)
writeCommand(handles.dg,sprintf(':TRIGger:SWEep NORMAL'));
else
writeCommand(handles.dg,sprintf(':TRIGger:SWEep SINGle'));    
end

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
if (get(handles.listbox2,'Value')==1)
writeCommand(handles.dg,sprintf(':TRIGger:MODE EDGE'));
elseif (get(handles.listbox2,'Value')==2)
writeCommand(handles.dg,sprintf(':TRIGger:MODE PULS'));
elseif (get(handles.listbox2,'Value')==3)
writeCommand(handles.dg,sprintf(':TRIGger:MODE RUNT'));    
elseif (get(handles.listbox2,'Value')==4)
writeCommand(handles.dg,sprintf(':TRIGger:MODE WIND'));
elseif (get(handles.listbox2,'Value')==5)
writeCommand(handles.dg,sprintf(':TRIGger:MODE NEDG'));
elseif (get(handles.listbox2,'Value')==6)
writeCommand(handles.dg,sprintf(':TRIGger:MODE SLOP'));
elseif (get(handles.listbox2,'Value')==7)
writeCommand(handles.dg,sprintf(':TRIGger:MODE VID'));
elseif (get(handles.listbox2,'Value')==8)
writeCommand(handles.dg,sprintf(':TRIGger:MODE PATT'));
elseif (get(handles.listbox2,'Value')==9)
writeCommand(handles.dg,sprintf(':TRIGger:MODE DEL'));
elseif (get(handles.listbox2,'Value')==10)
writeCommand(handles.dg,sprintf(':TRIGger:MODE TIM'));
elseif (get(handles.listbox2,'Value')==11)
writeCommand(handles.dg,sprintf(':TRIGger:MODE DURAT'));
elseif (get(handles.listbox2,'Value')==12)
writeCommand(handles.dg,sprintf(':TRIGger:MODE SHOL'));
elseif (get(handles.listbox2,'Value')==13)
    writeCommand(handles.dg,sprintf(':TRIGger:MODE RS232'));
elseif (get(handles.listbox2,'Value')==14)
    writeCommand(handles.dg,sprintf(':TRIGger:MODE IIC'));
elseif (get(handles.listbox2,'Value')==15)
    writeCommand(handles.dg,sprintf(':TRIGger:MODE SPI'));
elseif (get(handles.listbox2,'Value')==16)
    writeCommand(handles.dg,sprintf(':TRIGger:MODE CAN'));
elseif (get(handles.listbox2,'Value')==17)
    writeCommand(handles.dg,sprintf(':TRIGger:MODE USB'));
end

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton13.
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton13,'value',1);
set(handles.radiobutton11,'value',0);
set(handles.radiobutton10,'value',0);
set(handles.radiobutton12,'value',0);
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce ACL'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce ACL'));

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce ACL'));

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce ACL'));

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeCommand(handles.dg,sprintf(':TRIGger:PULSe:SOURce ACL'));


% --- Executes on button press in radiobutton14.
function radiobutton14_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton14,'value')
writeCommand(handles.dg,sprintf(':CHANnel1:VERNier on'));
else
writeCommand(handles.dg,sprintf(':CHANnel1:VERNier off'));    
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton14


% --- Executes on button press in radiobutton15.
function radiobutton15_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton15,'value')
writeCommand(handles.dg,sprintf(':CHANnel2:VERNier ON'));
else
writeCommand(handles.dg,sprintf(':CHANnel2:VERNier OFF'));    
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton15


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ll=num2str(get(handles.slider9,'Value'));
lll=sprintf([':CHANnel2:SCALe ',ll,'V/div']);
writeCommand(handles.dg,lll);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ll=num2str(get(handles.slider11,'Value'));
lll=sprintf([':TIMebase:OFFSet ',ll]);
writeCommand(handles.dg,lll);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton16.
function radiobutton16_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton16,'value',1);
set(handles.radiobutton17,'value',0);
set(handles.radiobutton18,'value',0);
writeCommand(handles.dg,sprintf(':TIMebase:MODE MAIN'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton16


% --- Executes on button press in radiobutton17.
function radiobutton17_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton17,'value',1);
set(handles.radiobutton16,'value',0);
set(handles.radiobutton18,'value',0);
writeCommand(handles.dg,sprintf(':TIMebase:MODE XY'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton17


% --- Executes on button press in radiobutton18.
function radiobutton18_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton18,'value',1);
set(handles.radiobutton17,'value',0);
set(handles.radiobutton16,'value',0);
writeCommand(handles.dg,sprintf(':TIMebase:MODE ROLL'));
% Hint: get(hObject,'Value') returns toggle state of radiobutton18



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%请求数据
handles.MSO2000A.InputBufferSize =2048*5000;
fopen(handles.MSO2000A);
fprintf(handles.MSO2000A, ':wav:data?' );
[data,len]= fread(handles.MSO2000A,2048*5000);
fclose(handles.MSO2000A);
wave = data(12:len-1);
wave = wave'; 
wave= wave-mean(wave);
plot(handles.axes1,wave); 
%axis( [0,500,-40,40] );
title(handles.axes1,'调幅波形图');
fftSpec = fft(wave',2048*5000); 
fftRms = abs( fftSpec');
fftLg = 20*log(fftRms); 
plot(handles.axes2,fftLg);
%axis( [0,1200000,0,300] ); 
title(handles.axes2,'调幅波频谱图');
f2=pout(wave);
am = abs(wave+j*f2);
am=am-mean(am);

plot(handles.axes3,am); 
%axis( [0,500,-40,40] );
title(handles.axes3,'解调波');
fftSpec2 = fft(f2',2048*5000); 
fftRms2 = abs( fftSpec2');
fftLg = 20*log(fftRms2); 

plot(handles.axes4,fftLg);
%axis( [0,200000,0,300] ); 
title(handles.axes4,'解调波频谱图');


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
II1=num2str(get(handles.edit1,'String'))
II2=num2str(get(handles.edit2,'String'));
II3=num2str(get(handles.edit3,'String'));
II4=num2str(get(handles.edit4,'String'));
II5=num2str(get(handles.edit5,'String'));
II6=num2str(get(handles.edit6,'String'));
IIIl=sprintf([':SOURCE1:APPLy:SINusoid ',II1,'%dMHz,',II2,'%dmVpp,',II3,II4]);
III2=sprintf([':SOURCE1:MOD:AM',II5]);
III3=sprintf([':SOURCE1:MOD:AM:INTernal:FREQuency',II6,'%dkHz']);


writeCommand(handles.ddg,IIIl);
writeCommand(handles.ddg,sprintf(':SOURCE1:MOD ON'));
writeCommand(handles.ddg,sprintf(':SOURCE1:MOD:TYPe AM'));
writeCommand(handles.ddg,III2);
writeCommand(handles.ddg,III3);
writeCommand(handles.ddg,sprintf(':SOURCE1:MOD:AM:INTernal:FUNCtion SINusoid'));


% writeCommand(handles.ddg,sprintf(':SOURCE%d:APPLy:SINusoid 2.455MHz,200mVrms,0,0', channel));
% writeCommand(handles.ddg,sprintf(':SOURCE%d:MOD ON', channel));
% writeCommand(handles.ddg,sprintf(':SOURCE%d:MOD:TYPe AM', channel));
% writeCommand(handles.ddg,sprintf(':SOURCE%d:MOD:AM 80', channel));
% writeCommand(handles.ddg,sprintf(':SOURCE%d:MOD:AM:INTernal:FREQuency 25kHz', channel));
% writeCommand(handles.ddg,sprintf(':SOURCE%d:MOD:AM:INTernal:FUNCtion SINusoid', channel));


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
