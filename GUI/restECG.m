function varargout = restECG(varargin)
% RESTECG MATLAB code for restECG.fig
%      RESTECG, by itself, creates a new RESTECG or raises the existing
%      singleton*.
%
%      H = RESTECG returns the handle to a new RESTECG or the handle to
%      the existing singleton*.
%
%      RESTECG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESTECG.M with the given input arguments.
%
%      RESTECG('Property','Value',...) creates a new RESTECG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before restECG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to restECG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help restECG

% Last Modified by GUIDE v2.5 29-Mar-2018 16:37:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @restECG_OpeningFcn, ...
                   'gui_OutputFcn',  @restECG_OutputFcn, ...
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


% --- Executes just before restECG is made visible.
function restECG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to restECG (see VARARGIN)

% Choose default command line output for restECG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes restECG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = restECG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

handles.datafromxml = 1;
if handles.datafromxml ==1
    
    handles.path = 'D:\DataBase\MuseLargError\';
    set(handles.listbox1,'string', listname(handles.path ));
else
   % a = load('D:\MGCDB\muse\musedb_500Hz.mat');
    handles.DATA = a.DATA;
    name = [];
    for ii = 1:length(handles.DATA)
        aa(ii) = sum(handles.DATA(ii).QRStype);
    end
    [a, index] = sort(aa);
    for ii = 1:length(index)
        name{ii} = num2str(index(ii));
        aa(ii) = sum(handles.DATA(ii).QRStype);
    end
    
    handles.DATA  = handles.DATA (index);
    set(handles.listbox1,'string', name);
    handles.index = 1;
end
guidata(hObject, handles);


function show_ecg(handles)

if handles.datafromxml ==1
   DATA = handles.Data;
    assignin('base','DATA',DATA);%
    assignin('base','fname',handles.fname);%
%      assignin('base','index',handles.index);%
else    
    DATA = handles.DATA(handles.index) ;
    assignin('base','DATA',DATA);%
    assignin('base','index',handles.index);%
end

ecg = DATA.wave_median*DATA.adu/1000;
fs = DATA.fs;
if isempty(DATA.Meas.POnset)
    DATA.Meas.POnset = 0 ;
    DATA.Meas.POffset = 0 ;
end;
pqrst = [DATA.Meas.POnset,DATA.Meas.POffset,...
    DATA.Meas.QOnset,DATA.Meas.QOffset,DATA.Meas.TOffset] * DATA.fs/500;


% [data, qrs, qrs2, meanwave, pqrst2] = ProcRestEcg(DATA.wave,fs);
  [data, meanwave,rpos,QRStype, pqrst2, ecgmeas2] = ProcRestEcg(DATA.wave,fs);

axes(handles.axes1);
get(handles.axes1,'position');

plot_restEcg(DATA.wave,DATA.fs,DATA.rpos,DATA.QRStype, -1  )

% hold on;plot_restEcg(data,250,qrs.time,qrs.anntyp,-2); 
hold on;plot_restEcg(data,250,rpos,QRStype,-3); 
% hold on;plot_restEcg(data,250,qrs2.time,qrs2.anntyp,-4);
hold off;


% plot_restEcg(DATA.wave,DATA.fs,DATA.rpos*250/DATA.fs,DATA.QRStype, -1  )

axes(handles.axes3);
get(handles.axes3,'position');
if fs == 500
    ecg = ecg(1:2:end,:);
    pqrst = pqrst/2 ;
end
ecg = ecg(26:end-25,:);
pqrst = floor( pqrst-25);
plot_restMedianWave(ecg,250,pqrst  , 'k' );

axes(handles.axes4);
get(handles.axes4,'position');
% hold on;
plot_restMedianWave(meanwave,250, pqrst2 , 'r' );

set(handles.m1,'String',DATA.Meas.VentricularRate);
set(handles.m2,'String',DATA.Meas.AtrialRate);
set(handles.m3,'String',DATA.Meas.PRInterval);
set(handles.m4,'String',DATA.Meas.QRSDuration);
set(handles.m5,'String',DATA.Meas.QTInterval);
set(handles.m6,'String',DATA.Meas.QTCorrected);
set(handles.m7,'String',DATA.Meas.PAxis);
set(handles.m8,'String',DATA.Meas.RAxis);
set(handles.m9,'String',DATA.Meas.TAxis);
set(handles.m10,'String',DATA.Meas.QRSCount);


set(handles.alg11,'String',ecgmeas2.VentricularRate);
set(handles.alg12,'String',ecgmeas2.AtrialRate);
set(handles.alg13,'String',ecgmeas2.PRInterval);
set(handles.alg14,'String',ecgmeas2.QRSDuration);
set(handles.alg15,'String',ecgmeas2.QTInterval);
set(handles.alg16,'String',ecgmeas2.QTCorrected);
set(handles.alg17,'String',ecgmeas2.PAxis);
set(handles.alg18,'String',ecgmeas2.RAxis);
set(handles.alg19,'String',ecgmeas2.TAxis);
set(handles.alg110,'String',ecgmeas2.QRSCount);


set(handles.dif11,'String',str2double(get(handles.m1,'String'))-str2double(get(handles.alg11,'String')));
set(handles.dif12,'String',str2double(get(handles.m2,'String'))-str2double(get(handles.alg12,'String')));
set(handles.dif13,'String',str2double(get(handles.m3,'String'))-str2double(get(handles.alg13,'String')));
set(handles.dif14,'String',str2double(get(handles.m4,'String'))-str2double(get(handles.alg14,'String')));
set(handles.dif15,'String',str2double(get(handles.m5,'String'))-str2double(get(handles.alg15,'String')));
% set(handles.dif16,'String',str2double(get(handles.m6,'String'))-str2double(get(handles.alg16,'String')));
% set(handles.dif17,'String',str2double(get(handles.m7,'String'))-str2double(get(handles.alg17,'String')));
% set(handles.dif18,'String',str2double(get(handles.m8,'String'))-str2double(get(handles.alg18,'String')));
% set(handles.dif19,'String',str2double(get(handles.m9,'String'))-str2double(get(handles.alg19,'String')));


set(handles.m11,'String',pqrst(1)/250*1000);
set(handles.alg111,'String',pqrst2(1)/250*1000);
set(handles.m12,'String',pqrst(2)/250*1000);
set(handles.alg112,'String',pqrst2(3)/250*1000);
set(handles.m13,'String',pqrst(3)/250*1000);
set(handles.alg113,'String',pqrst2(4)/250*1000);
set(handles.m14,'String',pqrst(4)/250*1000);
set(handles.alg114,'String',pqrst2(6)/250*1000);
set(handles.m15,'String',pqrst(5)/250*1000);
set(handles.alg115,'String',pqrst2(9)/250*1000);

set(handles.m16,'String',DATA.Meas.ECGSampleBase);
set(handles.m17,'String',DATA.Meas.ECGSampleExponent);
set(handles.m18,'String',DATA.Meas.QTcFrederica);


s111_1=str2double(get(handles.m11,'String'));
s111_2=str2double(get(handles.alg111,'String'));
set(handles.dif111,'String',s111_2-s111_1);

s112_1=str2double(get(handles.m12,'String'));
s112_2=str2double(get(handles.alg112,'String'));
set(handles.dif112,'String',s112_2-s112_1);


s113_1=str2double(get(handles.m13,'String'));
s113_2=str2double(get(handles.alg113,'String'));
set(handles.dif113,'String',s113_2-s113_1);


s114_1=str2double(get(handles.m14,'String'));
s114_2=str2double(get(handles.alg114,'String'));
set(handles.dif114,'String',s114_2-s114_1);


s115_1=str2double(get(handles.m15,'String'));
s115_2=str2double(get(handles.alg115,'String'));
set(handles.dif115,'String',s115_2-s115_1);



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

if handles.datafromxml ==1
    fname = get(handles.listbox1,'string');
    fname = fullfile(handles.path,fname{get(hObject,'Value')});
    [handles.Data.wave,handles.Data.rpos,handles.Data.QRStype,handles.Data.wave_median,handles.Data.fs,handles.Data.label,...
        handles.Data.Meas,...
        handles.Data.Meas_Orig,handles.Data.diag,handles.Data.diag_orig,handles.Data.Meas_Matrix,handles.Data.adu,handles.Data.PatientID]...
        = musexmlread(fname);
    handles.fname = fname;
    handles.Data.wave = handles.Data.wave*handles.Data.adu/1000;
%     if handles.Data.fs== 250
        handles.Data.rpos = handles.Data.rpos*250/handles.Data.fs;
%     else
%          handles.Data.rpos = handles.Data.rpos/2;
%     end;
        
else
    handles.index = get(hObject,'Value');
end
show_ecg(handles)
guidata(hObject, handles);


%     assignin('base','DATA',handles.Data);%
%     assignin('base','fname',fname);%

function name = listname(path)
list = dir([path '\*.xml']);
for ii = 1:length(list)
    name{ii} = list(ii).name;
end;

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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
muse2mit;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
res=Sta('E:\download\bin\MUSE-100\');
for i=1:5
    for j=1:5
        r=['r',num2str(i),num2str(j)];
        set(handles.(r),'String',res(i,j));
    end
end
