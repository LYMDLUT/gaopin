% GUI里不能带clear，会清空GUI的工作变量
% 我的一个猜想，采样点数为2048是固定的，但采样得到的波形不一样，即所测信号的频率不一样。
function varargout = gaopinGUI(varargin)
% GAOPINGUI MATLAB code for gaopinGUI.fig
%      GAOPINGUI, by itself, creates a new GAOPINGUI or raises the existing
%      singleton*.
%
%      H = GAOPINGUI returns the handle to a new GAOPINGUI or the handle to
%      the existing singleton*.
%
%      GAOPINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAOPINGUI.M with the given input arguments.
%
%      GAOPINGUI('Property','Value',...) creates a new GAOPINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gaopinGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gaopinGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gaopinGUI

% Last Modified by GUIDE v2.5 10-Jan-2020 11:15:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gaopinGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @gaopinGUI_OutputFcn, ...
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


% --- Executes just before gaopinGUI is made visible.
function gaopinGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gaopinGUI (see VARARGIN)

% Choose default command line output for gaopinGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gaopinGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gaopinGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ------------------------------示波器操作---------------------------------
MSO2000A = visa( 'ni','USB0::0x1AB1::0x04B0::DS2F210800048::INSTR' );
MSO2000A.InputBufferSize = 2048;
N = MSO2000A.InputBufferSize;
%打开已创建的 VISA 对象
fopen(MSO2000A);
%读取波形
fprintf(MSO2000A, ':wav:data?' );
%请求数据
[data,len]= fread(MSO2000A,N);

% 获取周期
fprintf(MSO2000A,':MEASure:PERiod? <CHANnel1>');
T = fscanf(MSO2000A);
T = str2num(T);
Fread = 1/T             % 计算频率
str5 = num2str(Fread);
set(handles.Fread,'string',str5);

% 获取采样频率
fprintf(MSO2000A,':ACQuire:SRATe?');
Fs = fscanf(MSO2000A);
Fs = str2num(Fs)
str6 = num2str(Fs);
set(handles.Fs,'string',str6);
% 计算采样总时间
Tmax = N/Fs
str4 = num2str(Tmax);
set(handles.Tmax,'string',str4);

%关闭设备
fclose(MSO2000A);
delete(MSO2000A);
clear MSO2000A;
% 数据处理。读取的波形数据含有 TMC 头，长度为 11 个字节，其中前 2 个字节分别为 TMC 头标志符
% #和宽度描述符 9，接着的 9 个字节为数据长度，然后是波形数据，最后一个字节为结束符 0x0A。所
% 以，读取的有效波形数据点为 12 到倒数第 2 个点。
wave = data(12:len-1);
wave = wave';
% ------------------------------示波器操作---------------------------------

% load('RFdata.mat');
% N = 2048;
F = 1:1:1025;

% 获取输入量
IgnoredF=get(handles.IgnoredF, 'String');
IgnoredF=str2double(IgnoredF);
rage_rate=get(handles.rage_rate, 'String');
rage_rate=str2double(rage_rate);

% 去均值化
ave = mean(wave);
wave = wave - ave;
plot(handles.wave, wave)    % 绘制波形图像

% fft
fftSpec = fft(wave',2048);
fftRms = abs( fftSpec');
% 取一半
fftRms = fftRms(1:N/2+1);
fftRms(2:end-1) = 2*fftRms(2:end-1);
% 取log
fftLg = 20*log(fftRms);
% 绘图
plot(handles.fft1, F, fftLg)


[fmax,~,fft_max,~] = Find_extremum_of_RowVector(fftLg', F);

% plot them on a figure
plot(handles.fft2,F,fftLg);
hold(handles.fft2,'on')
plot(handles.fft2, fmax, fft_max, 'r+');
xlabel(handles.fft1,'f/Hz'),ylabel(handles.fft1, 'V/mv')
set(handles.fft2,'YLim',[0 250])

[fmax,~,fft_max,~] = Find_extremum_of_RowVector(fftLg(:,IgnoredF:end-1)', F(:,IgnoredF:end-1));

% 查找最大的谐波数
f1_pred=peak(fft_max,fmax,rage_rate,1);
f2_pred=peak(fft_max,fmax,rage_rate,2);

str2 = ['测得信号的最大的频率分量为: ',num2str(f1_pred),' Hz'];
str3 = ['测得信号的次大的频率分量为: ',num2str(f2_pred),' Hz'];
set(handles.string2,'string',str2);
set(handles.string3,'string',str3);




function string1_Callback(hObject, eventdata, handles)
% hObject    handle to string1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of string1 as text
%        str2double(get(hObject,'String')) returns contents of string1 as a double


% --- Executes during object creation, after setting all properties.
function string1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to string1 (see GCBO)
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



function string2_Callback(hObject, eventdata, handles)
% hObject    handle to string2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of string2 as text
%        str2double(get(hObject,'String')) returns contents of string2 as a double


% --- Executes during object creation, after setting all properties.
function string2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to string2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function string3_Callback(hObject, eventdata, handles)
% hObject    handle to string3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of string3 as text
%        str2double(get(hObject,'String')) returns contents of string3 as a double


% --- Executes during object creation, after setting all properties.
function string3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to string3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IgnoredF_Callback(hObject, eventdata, handles)
% hObject    handle to IgnoredF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IgnoredF as text
%        str2double(get(hObject,'String')) returns contents of IgnoredF as a double


% --- Executes during object creation, after setting all properties.
function IgnoredF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IgnoredF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rage_rate_Callback(hObject, eventdata, handles)
% hObject    handle to rage_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rage_rate as text
%        str2double(get(hObject,'String')) returns contents of rage_rate as a double


% --- Executes during object creation, after setting all properties.
function rage_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rage_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tmax_Callback(hObject, eventdata, handles)
% hObject    handle to Tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tmax as text
%        str2double(get(hObject,'String')) returns contents of Tmax as a double


% --- Executes during object creation, after setting all properties.
function Tmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fread_Callback(hObject, eventdata, handles)
% hObject    handle to Fread (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fread as text
%        str2double(get(hObject,'String')) returns contents of Fread as a double


% --- Executes during object creation, after setting all properties.
function Fread_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fread (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fs_Callback(hObject, eventdata, handles)
% hObject    handle to Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fs as text
%        str2double(get(hObject,'String')) returns contents of Fs as a double


% --- Executes during object creation, after setting all properties.
function Fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

