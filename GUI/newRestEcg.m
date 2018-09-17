function newRestEcg()

hObject = figure('NumberTitle', 'off', 'Resize','on','Color',[1,1,1],'Name', '静态心电图分析软件','tag','静态心电图分析软件','position',get(0,'ScreenSize'));

handles.listbox_datasource = uicontrol('parent',hObject,'style','listbox','Units','normalized','position',[0 0 0.2 0.25],...
    'Callback',{@listbox_datasource_Callback});

handles.listbox_data = uicontrol('parent',hObject,'style','listbox','Units','normalized','position',[0 0.25 0.2 0.75],...
    'Callback',{@listbox_data_Callback});

% handles.textedit1 = uicontrol('parent',hObject,'style','text','Units','normalized','FontSize',12,'HorizontalAlignment','left','position',[0.20 0.16 0.5 0.2]);

handles.axes1 = axes('parent',hObject,'Position',[0.2 0.4 0.5 0.6]);axis off;
handles.axes2  = axes('parent',hObject,'Position',[0.7 0.4 0.15 0.6]');axis off;
handles.axes3  = axes('parent',hObject,'Position',[0.85 0.4 0.15 0.6]);axis off;


for ii = 1:3
    for jj = 1:6
        handles.radiobutton(ii,jj) = uicontrol('parent',hObject,'style','radiobutton','Units','normalized','position',[0.62+0.1*ii 0.3-0.05*(jj-1) 0.1 0.05]);
    end
end

for ii = 1:8
    for jj = 1:3
        handles.textedit1(ii,jj) = uicontrol('parent',hObject,'style','text','Units','normalized','position',[0.2+0.06*(ii-1) 0.15+0.04*(jj-1) 0.05 0.03]);
    end
end

handles.text_diag1 = uicontrol('parent',hObject,'style','text','Units','normalized','HorizontalAlignment','left','position',[0.2 0.27 0.5 0.03]);
handles.text_diag2 = uicontrol('parent',hObject,'style','text','Units','normalized','HorizontalAlignment','left','position',[0.2 0.3 0.5 0.03]);
handles.text_diag_my = uicontrol('parent',hObject,'style','text','Units','normalized','HorizontalAlignment','left','position',[0.2 0.34 0.5 0.03]);
handles.text_fname = uicontrol('parent',hObject,'style','text','Units','normalized','HorizontalAlignment','left','position',[0.2 0.37 0.5 0.03]);
handles.button_1 = uicontrol('parent',hObject,'style','pushbutton','String','Button1','Units','normalized','HorizontalAlignment','left',...
    'position',[0.25 0.01 0.08 0.05], 'Callback',{@button1_Callback});
handles.button_2 = uicontrol('parent',hObject,'style','pushbutton','String','Button2','Units','normalized','HorizontalAlignment','left'...
    ,'position',[0.35 0.01 0.08 0.05], 'Callback',{@button2_Callback});


% 修改此处，处理不同文件类型
handles.datafromxml = 'mat';
if handles.datafromxml =='xml'
    handles.suf = '*.xml';
    drt=findalldir('D:\DataBase\MUSE_Classify');
end
if handles.datafromxml =='mat'
    handles.suf = '*.mat';
    drt=findalldir('D:\MGCDB\muse\classify');
    % 加入listfile开头的mat文件
    list = dir('D:\MGCDB\muse\classify');    
    for ii = 1:length(list)
        if ~isempty(strfind(list(ii).name,'listfile'))
            drt{end+1} = fullfile('D:\MGCDB\muse\classify',list(ii).name);
           
        end
    end
end
if handles.datafromxml =='dat'
    handles.suf = '*.dat';
    drt=findalldir('.\dat'); 
end
set(handles.listbox_datasource,'string', drt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% callback of listbox datasourece
% 打开数据源
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function listbox_datasource_Callback(hObject,~)
        contents = cellstr(get(hObject,'String'));
        filepath = contents{get(hObject,'Value')};
        try 
            data = load(filepath);
            handles.list_name = data.listname;
            handles.listlabel = data.listlabel;
            for kk = 1 :length(handles.list_name)                
                tmp{kk} = sprintf('%05d_ %s' ,kk,handles.list_name{kk});
            end
            set(handles.listbox_data,'string',tmp);
       
        catch
            [tmp] = dirfilename(filepath,handles.suf);

            if ~isempty(tmp)
                for kk = 1 :length(tmp)
                    handles.list_name{kk} = fullfile(filepath,tmp{kk});
                    tmp{kk} = sprintf('%05d_ %s' ,kk,tmp{kk});
                end            
                set(handles.listbox_data,'string',tmp,'Value',1); 
             
            else
                if ~isempty(listname(handles.filepath,handles.suf))
                    set(handles.listbox_data,'string', listname(handles.filepath,handles.suf));
                end
            end
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% callback of listbox data
% 打开数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function listbox_data_Callback(hObject,~)
    
        handles.cur_sel = get(hObject,'Value');     
 
        fname = handles.list_name{handles.cur_sel};
      
        if handles.datafromxml == 'xml'
            
            [handles.Data.wave,handles.Data.rpos,handles.Data.QRStype,handles.Data.wave_median,handles.Data.fs,handles.Data.label,...
                handles.Data.Meas,...
                handles.Data.Meas_Orig,handles.Data.diag,handles.Data.diag_orig,handles.Data.Meas_Matrix,handles.Data.adu,handles.Data.PatientID]...
                = musexmlread(fname);
            
            handles.Data.wave = handles.Data.wave*handles.Data.adu/1000;
            handles.Data.rpos = handles.Data.rpos*250/handles.Data.fs;
            handles.Data.Meas_Matrix = parseMeasMatrix(handles.Data.Meas_Matrix);
        end
        
        if handles.datafromxml == 'mat'
            a = load(fname);
            handles.Data = a.DATA;
            handles.index = get(hObject,'Value');
            handles.Data.wave = handles.Data.wave*handles.Data.adu/1000;
            handles.Data.rpos = handles.Data.rpos*250/handles.Data.fs;
            handles.Data.Meas_Matrix = parseMeasMatrix(handles.Data.Meas_Matrix);
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
        
 
        handles.fname = fname;
        
        [handles.Data,handles.myData] = proc_data(handles.Data);
        show_data(handles.Data,handles.myData);
        show_txt(handles.fname,handles.Data,handles.myData);
        assignin('base','DATA',handles.Data);%
        assignin('base','fname',handles.fname);%
        assignin('base','myData',handles.myData);%
        
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% button1_Callback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function button1_Callback(hObject,~)
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
    end
       
       
    function button2_Callback(hObject,~)
        
        myData = handles.myData;
        rpos = myData.rpos;
        x = myData.dataout(:,8);
        x = x - mean(x);
        Fx = abs(fft(x)).^2/(length(x)*length(x));
        pout = myData.pdataout;        
        figure;subplot(311);plot(x);        
        subplot(312);plot(myData.pdataout(:,6));        
        subplot(313);plot(Fx);        
        r = index_vta(myData.dataout,rpos);
        [ratio1 ,ratio2] = fwaveDetect(pout,rpos);  
         title([ratio1 ratio2]);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 显示数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function show_data(DATA,myData)
        
        axes(handles.axes1);
        plot_restEcg(DATA.wave,DATA.fs,DATA.rpos,DATA.QRStype, -1  ,'k',[],0)
        hold on;
        plot_restEcg(myData.dataout/200,250,myData.rpos,myData.QRStype, -3 ,'r',[],0);
        hold on;
        plot_restEcg(myData.pdataout/2000,250,myData.ppos,myData.ppos, -2  ,'b',[],0)
        
        hold off;
        
%         disp(tachycardia)
        clear matrestecg;
        
        % plot_restEcg(DATA.wave,DATA.fs,DATA.rpos*250/DATA.fs,DATA.QRStype, -1  )
        
        axes(handles.axes2);
        get(handles.axes2,'position');
        if isfield(DATA,'wave_median')
            ecg = DATA.wave_median*DATA.adu/1000;
            pqrst = DATA.pqrst;
            if DATA.fs == 500
                ecg = ecg(1:2:end,:);
                pqrst = pqrst/2 ;
            end
            
            ecg = ecg(26:end-25,:);
            pqrst = floor( pqrst-25);
            plot_restMedianWave(ecg,250,pqrst  , 'k' );
        end
        axes(handles.axes3);
        get(handles.axes3,'position');
        
        % hold on;
        plot_restMedianWave(myData.meanwave/200,250, myData.pqrst , 'r' );        
        
       
        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 显示文本数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function show_txt(fname,DATA,myData)
      
       title = {'VRate','ARate','PRInt','QRSDu','QTInt','QTCor','PAxis','RAxis','TAxis'};
       diag = 'Diag = ';
       diag_orig = 'Orig = ';
       if  isfield(DATA,'Meas')
           Meas = DATA.Meas;
           val1 = { Meas.VentricularRate,Meas.AtrialRate,Meas.PRInterval,Meas.QRSDuration,Meas.QTInterval,Meas.QTCorrected,Meas.PAxis,Meas.RAxis,Meas.TAxis};           
           for kk = 1 :8
               set(handles.textedit1(kk,3) ,'string',title{kk});
               set(handles.textedit1(kk,2) ,'string',val1{kk});
           end
       end
       
       if  isfield(myData,'Meas')
           Meas = myData.Meas;
           val2 = [ Meas.VentricularRate,Meas.AtrialRate,Meas.PRInterval,Meas.QRSDuration,Meas.QTInterval,Meas.QTCorrected,Meas.PAxis,Meas.RAxis,Meas.TAxis];
           for kk = 1 :8
               set(handles.textedit1(kk,3) ,'string',title{kk}); 
               set(handles.textedit1(kk,1) ,'string',val2(kk));
           end
       end           
           
       if isfield(DATA,'diag')
           
           for kk = 1:length(DATA.diag)
               diag = [diag '  '  DATA.diag{kk}];
           end;          
           
           for kk = 1:length(DATA.diag_orig)
               diag_orig = [diag_orig '  '  DATA.diag_orig{kk}];
           end;
           
       end
 

             
       set(handles.text_diag1 ,'string',diag);
       set(handles.text_diag2 ,'string',diag_orig);
        set(handles.text_diag_my ,'string',myData.DiagnosticStr);
       set(handles.text_fname ,'string',fname);


       
%        [label ,label_name] = label_tachycardia(DATA);
%        nb = length(handles.radiobutton);
%         for kk = 1 :length(label_name)
%            set(handles.radiobutton(kk),'string',label_name{kk});
%            set(handles.radiobutton(kk),'value',label(kk));
%                
%         end;

    end

end

function  name = dirfilename(path,suff)
list = dir(fullfile(path ,suff));
name = cell(1,length(list));
for ii = 1:length(list)
    name{ii} = list(ii).name;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 处理MUSE数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [DATA ,myData] = proc_data(DATA)
d = floor(200*DATA.wave);
if DATA.fs==500
    d = d(1:2:end,:);
end
fs = 250;
fid = fopen('D:\\3.dat','wb'); fwrite(fid,d,'int32');fclose(fid);


if isfield(DATA,'wave_median') 
    if isempty(DATA.Meas.POnset)
        DATA.Meas.POnset = 0 ;
        DATA.Meas.POffset = 0 ;
    end
    DATA.pqrst = [DATA.Meas.POnset,DATA.Meas.POffset,...
        DATA.Meas.QOnset,DATA.Meas.QOffset,DATA.Meas.TOffset] * DATA.fs/500; 

end

[meanwave, rpos,QRStype ,ppos,pqrst2,ecgmeas2 ,DiagnosticArray,DiagnosticStr, dataout , pdataout, pmeanwave,pchan,DiagnosticAV,DiagnosticTach,FT_tachycardia,measureMatrix]  = matrestecg('mat_restecg_Process',floor(d),fs,200);

myData.wave = floor(200*DATA.wave);
myData.dataout = dataout;
myData.meanwave = meanwave;
myData.rpos = rpos;
myData.ppos = ppos;
myData.pmeanwave = pmeanwave;
myData.Meas = ecgmeas2;
myData.pchan = pchan;
myData.QRStype = QRStype;
myData.pqrst = pqrst2;
myData.pdataout = pdataout;
myData.DiagnosticAV = DiagnosticAV;
% myData.metric_Regular = metric_Regular;
myData.DiagnosticTach = DiagnosticTach;
myData.FT_tachycardia = FT_tachycardia;
myData.measureMatrix = measureMatrix';
myData.DiagnosticArray = DiagnosticArray;
myData.DiagnosticStr = DiagnosticStr;

% disp(metric_Regular);
end


