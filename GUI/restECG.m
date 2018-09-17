
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

% Last Modified by GUIDE v2.5 13-Aug-2018 14:21:34

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

% 修改此处，处理不同文件类型
handles.datafromxml = 'mat';
if handles.datafromxml =='xml'
    handles.suf = '*.xml';
    drt = {'D:\DataBase\Muse'};
    m = length(drt);
    list = dir('D:\DataBase\MUSE_Classify');
    for ii = 1:length(list)
        if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))
            m = m +1;
            drt{m} = fullfile('D:\DataBase\MUSE_Classify',list(ii).name);
        end
    end
    list = dir('D:\MGCDB\MUSE_Classify\');
    for ii = 1:length(list)
        if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))
            m = m +1;
            drt{m} = fullfile('D:\MGCDB\MUSE_Classify\',list(ii).name);
        end
    end
    set(handles.listbox4,'string', drt);
    
    
end
%     handles.path = 'D:\DataBase\MuseLargError\';
%     set(handles.listbox1,'string', listname(handles.path ));
if handles.datafromxml =='mat'
    m = 1;
    handles.suf = '*.mat';
    list = dir('D:\MGCDB\muse\classify');
    
    for ii = 1:length(list)
        if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))         
            drt{m} = fullfile('D:\MGCDB\muse\classify',list(ii).name);
            m = m +1;
        end
        if ~isempty(strfind(list(ii).name,'listfile'))
            drt{m} = fullfile('D:\MGCDB\muse\classify',list(ii).name);
            m = m +1;
        end
    end
    set(handles.listbox4,'string', drt);
    
    
end

if handles.datafromxml =='dat'
    m = 1;
    handles.suf = '*.dat';
    list = dir('.\dat');
    
    drt=findalldir('.\dat');
%     drt{1} = 'D:\MatlabWork\RestEcg\dat';
%     for ii = 1:length(list)
%         if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))
%             m = m +1;
%             drt{m} = fullfile('D:\MatlabWork\RestEcg\dat',list(ii).name);
%         end
%     end
    set(handles.listbox4,'string', drt);
%     
    
end
contents = cellstr(get(handles.listbox4,'String'));
handles.filepath = contents{1};
set(handles.listbox1,'string', listname(handles.filepath,handles.suf));
guidata(hObject, handles);


   

function myData = show_ecg(handles)


DATA = handles.Data;
assignin('base','DATA',DATA);%
assignin('base','fname',handles.fname);%
%      assignin('base','index',handles.index);%
fs = DATA.fs;
if isfield(DATA,'wave_median')
    ecg = DATA.wave_median*DATA.adu/1000;
    
    if isempty(DATA.Meas.POnset)
        DATA.Meas.POnset = 0 ;
        DATA.Meas.POffset = 0 ;
    end;
    pqrst = [DATA.Meas.POnset,DATA.Meas.POffset,...
        DATA.Meas.QOnset,DATA.Meas.QOffset,DATA.Meas.TOffset] * DATA.fs/500;
end


% [data, qrs, qrs2, meanwave, pqrst2] = ProcRestEcg(DATA.wave,fs);
% [data, meanwave,rpos,QRStype, pqrst2, ecgmeas2] = ProcRestEcg(DATA.wave,fs);
%  fid = fopen('D:\\9.dat','wb');fwrite(fid,200*DATA.wave,'int32');fclose(fid);
%   fid = fopen('D:\\9.dat','rb'); d = fread(fid,[5000 8],'int32');fclose(fid);

[meanwave, rpos,QRStype ,ppos,pqrst2,ecgmeas2 , dataout , pdataout, pmeanwave,pchan,av,metric_Regular,tachycardia]  = matrestecg('mat_restecg_Process',floor(200*DATA.wave),fs,200);

myData.wave = floor(200*DATA.wave);
myData.dataout = dataout;
myData.meanwave = meanwave;
myData.rpos = rpos;
myData.ppos = ppos;
myData.pmeanwave = pmeanwave;
myData.pchan = pchan;
myData.QRStype = QRStype;
myData.pqrst = pqrst2;
myData.pdataout = pdataout;
myData.metric_Regular = metric_Regular;
disp(metric_Regular);
assignin('base','myData',myData);%
assignin('base','dataout',dataout);%
assignin('base','meanwave',meanwave);%
assignin('base','rpos',rpos);%
assignin('base','QRStype2',QRStype);%
assignin('base','listlabel',handles.list_label);%
assignin('base','listname',handles.list_name);%
meanwave = meanwave/200;
d = floor(200*DATA.wave);
if DATA.fs==500
    d = d(1:2:end,:);
end
fs = 250;
fid = fopen('D:\\3.dat','wb'); fwrite(fid,d,'int32');fclose(fid);




axes(handles.axes1);
get(handles.axes1,'position');

plot_restEcg(DATA.wave,DATA.fs,DATA.rpos,DATA.QRStype, -1  ,'k',[],0)

hold on;
plot_restEcg(dataout/200,250,rpos,QRStype, -3 ,'r',[],1 );
hold on;
plot_restEcg(pdataout/2000,250,ppos,ppos, -2  ,'b',[],0)

% plot_restEcg(dataout/200,250,rpos - 100 + pqrst2(4),QRStype, -2 ,'r',[],1 );
% hold on;plot_restEcg(data,250,qrs.time,qrs.anntyp,-2);
% hold on;plot_restEcg(data,250,rpos,QRStype,-3);
% hold on;plot_restEcg(data,250,qrs2.time,qrs2.anntyp,-4);
hold off;

disp(tachycardia)
clear matrestecg;

% plot_restEcg(DATA.wave,DATA.fs,DATA.rpos*250/DATA.fs,DATA.QRStype, -1  )

axes(handles.axes3);
get(handles.axes3,'position');
if fs == 500
    ecg = ecg(1:2:end,:);
    pqrst = pqrst/2 ;
end
if isfield(DATA,'wave_median')
    ecg = ecg(26:end-25,:);
    pqrst = floor( pqrst-25);
    plot_restMedianWave(ecg,250,pqrst  , 'k' );
end
axes(handles.axes4);
get(handles.axes4,'position');

% hold on;
plot_restMedianWave(meanwave,250, pqrst2 , 'r' );
if isfield(DATA,'Meas')
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
end

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

if isfield(DATA,'diag')
    diag = [];
    for ii = 1:length(DATA.diag)
        diag = [diag '  '  DATA.diag{ii}];
    end;
    set(handles.DiagInfo,'String',diag);
    
    diag_orig = [];
    for ii = 1:length(DATA.diag_orig)
        diag_orig = [diag_orig '  '  DATA.diag_orig{ii}];
    end;
    set(handles.DiagOrig,'String',diag_orig);
end

set(handles.dif11,'String',str2double(get(handles.m1,'String'))-str2double(get(handles.alg11,'String')));
set(handles.dif12,'String',str2double(get(handles.m2,'String'))-str2double(get(handles.alg12,'String')));
set(handles.dif13,'String',str2double(get(handles.m3,'String'))-str2double(get(handles.alg13,'String')));
set(handles.dif14,'String',str2double(get(handles.m4,'String'))-str2double(get(handles.alg14,'String')));
set(handles.dif15,'String',str2double(get(handles.m5,'String'))-str2double(get(handles.alg15,'String')));
% set(handles.dif16,'String',str2double(get(handles.m6,'String'))-str2double(get(handles.alg16,'String')));
% set(handles.dif17,'String',str2double(get(handles.m7,'String'))-str2double(get(handles.alg17,'String')));
% set(handles.dif18,'String',str2double(get(handles.m8,'String'))-str2double(get(handles.alg18,'String')));
% set(handles.dif19,'String',str2double(get(handles.m9,'String'))-str2double(get(handles.alg19,'String')));

if isfield(DATA,'diag')
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
    
    % set(handles.m16,'String',DATA.Meas.ECGSampleBase);
    % set(handles.m17,'String',DATA.Meas.ECGSampleExponent);
    set(handles.m18,'String',DATA.Meas.QTcFrederica);
end

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

fname = get(handles.listbox1,'string');

handles.cur_sel = get(hObject,'Value');

if contains(fname,'\') 
    fname = fname{get(hObject,'Value')};
else
    fname = fullfile(handles.filepath,fname{get(hObject,'Value')});
end
if handles.datafromxml == 'xml'
    
    [handles.Data.wave,handles.Data.rpos,handles.Data.QRStype,handles.Data.wave_median,handles.Data.fs,handles.Data.label,...
        handles.Data.Meas,...
        handles.Data.Meas_Orig,handles.Data.diag,handles.Data.diag_orig,handles.Data.Meas_Matrix,handles.Data.adu,handles.Data.PatientID]...
        = musexmlread(fname);
    
    handles.Data.wave = handles.Data.wave*handles.Data.adu/1000;
    handles.Data.rpos = handles.Data.rpos*250/handles.Data.fs;
end

%     else
%          handles.Data.rpos = handles.Data.rpos/2;
%     end;

if handles.datafromxml == 'mat'
    load(fname);
    handles.Data = DATA;
    handles.index = get(hObject,'Value');
    handles.Data.wave = handles.Data.wave*handles.Data.adu/1000;
    handles.Data.rpos = handles.Data.rpos*250/handles.Data.fs;
end

if handles.datafromxml == 'dat'
    fid = fopen(fname,'rb');
    handles.Data.wave = fread(fid,[2500 8],'short');
    handles.Data.wave(handles.Data.wave==-12851) = 0 ;

    handles.Data.wave = handles.Data.wave/200;
    handles.Data.fs = 250;
    handles.Data.rpos = [];
    handles.Data.QRStype = [];
    
    fclose(fid);
end

handles.Data.Meas_Matrix = parseMeasMatrix(handles.Data.Meas_Matrix);
handles.fname = fname;
handles.myData = show_ecg(handles);

guidata(hObject, handles);
% set(handles.radiobutton1,'value',handles.list_label(handles.cur_sel,1)==1);
% set(handles.radiobutton2,'value',handles.list_label(handles.cur_sel,2)==1);
% set(handles.radiobutton3,'value',handles.list_label(handles.cur_sel,3)==1);
% set(handles.radiobutton4,'value',handles.list_label(handles.cur_sel,4)==1);
% set(handles.radiobutton5,'value',handles.list_label(handles.cur_sel,5)==1);
% set(handles.radiobutton6,'value',handles.list_label(handles.cur_sel,6)==1);
% set(handles.radiobutton7,'value',handles.list_label(handles.cur_sel,7)==1);
%                 set(handles.radiobutton8,'value',handles.list_label(handles.cur_sel,8)==1);

guidata(hObject, handles);



%     assignin('base','DATA',handles.Data);%
%     assignin('base','fname',fname);%

function [name, label] = listname(path,suff)

try
    data = load(path);
    name = data.listname;
    label = data.listlabel;
    return ;
catch
    if(exist(fullfile(path,'sortlist.mat'),'file'))
        load(fullfile(path,'sortlist.mat'));
        
        name = listname2;
    else
        
        list = dir(fullfile(path ,suff));
        name = [];
        for ii = 1:length(list)
            name{ii} = list(ii).name;
        end;
    end
    label = 0 ;
end

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

% figure;
% plot_restEcg(handles.myData.pdataout/200,250,handles.myData.ppos,handles.myData.ppos, -2  ,'r',[],0)
figure;
pout = handles.myData.pdataout;
dataout = handles.myData.dataout;
ppos = handles.myData.ppos;
rpos = handles.myData.rpos;
pmeanwave = handles.myData.pmeanwave;
ch = handles.myData.pchan +1;;
subplot(311);plot(dataout(:,ch)); hold on;plot(ppos+1,dataout(ppos+1,ch),'*r');plot(rpos+1,dataout(rpos+1,ch),'.r');
subplot(312);plot(ppos+1,pout(ppos+1,ch),'*r');hold on;plot(pout(:,ch),'k');

subplot(313);plot(pmeanwave); hold on;plot(pmeanwave(:,ch),'r','LineWidth',2); title(num2str(ch));

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

myData = handles.myData;
rpos = myData.rpos;
x = myData.dataout(:,8);
x = x - mean(x);
Fx = abs(fft(x)).^2/(length(x)*length(x));
pout = myData.pdataout;

figure;subplot(311);plot(x);

subplot(312);plot(myData.pdataout(:,6));

subplot(313);plot(Fx);


 r = index_vta(myData.dataout,rpos)
 [ratio1 ,ratio2] = fwaveDetect(pout,rpos);



title([ratio1 ratio2]);
% res=Sta('E:\download\bin\MUSE-100\');
% for i=1:5
%     for j=1:5
%         r=['r',num2str(i),num2str(j)];
%         set(handles.(r),'String',res(i,j));
%     end
% end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4
contents = cellstr(get(hObject,'String'));
handles.filepath = contents{get(hObject,'Value')};

[tmp, list_label] = listname(handles.filepath,handles.suf);
if ~isempty(tmp)
    set(handles.listbox1,'string', tmp);
    set(handles.listbox1,'value',1);
    fname = get(handles.listbox1,'string');
    guidata(handles.output,handles);
    if contains(fname,'\') 
       fullfile(fname)
    else
       fullfile(handles.filepath,fname{1})
    end
    handles.list_label = list_label;
    handles.list_name = tmp;
    guidata(handles.output,handles);
else
    if ~isempty(listname(handles.filepath,handles.suf))
        set(handles.listbox1,'string', listname(handles.filepath,handles.suf));
    end
end

% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton6.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6

handles.list_label(handles.cur_sel,1) = get(hObject,'Value') ;
 guidata(handles.output,handles);
guidata(hObject, handles);

% --- Executes on button press in radiobutton6.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
handles.list_label(handles.cur_sel,2) = get(hObject,'Value') ;
guidata(hObject, handles);
% --- Executes on button press in radiobutton6.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
handles.list_label(handles.cur_sel,3) = get(hObject,'Value') ;
 guidata(handles.output,handles);
guidata(hObject, handles);
% --- Executes on button press in radiobutton6.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
handles.list_label(handles.cur_sel,4) = get(hObject,'Value') ;
 guidata(handles.output,handles);
guidata(hObject, handles);
% --- Executes on button press in radiobutton1.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
handles.list_label(handles.cur_sel,5) = get(hObject,'Value') ;
 guidata(handles.output,handles);
guidata(hObject, handles);

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6

handles.list_label(handles.cur_sel,6) = get(hObject,'Value') ;
 guidata(handles.output,handles);
guidata(hObject, handles);

% --- Executes on button press in radiobutton6.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
handles.list_label(handles.cur_sel,7) = get(hObject,'Value') ;
 guidata(handles.output,handles);
guidata(hObject, handles);