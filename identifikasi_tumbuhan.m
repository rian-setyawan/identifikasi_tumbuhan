function varargout = identifikasi_tumbuhan(varargin)
% IDENTIFIKASI_TUMBUHAN MATLAB code for identifikasi_tumbuhan.fig
%      IDENTIFIKASI_TUMBUHAN, by itself, creates a new IDENTIFIKASI_TUMBUHAN or raises the existing
%      singleton*.
%
%      H = IDENTIFIKASI_TUMBUHAN returns the handle to a new IDENTIFIKASI_TUMBUHAN or the handle to
%      the existing singleton*.
%
%      IDENTIFIKASI_TUMBUHAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IDENTIFIKASI_TUMBUHAN.M with the given input arguments.
%
%      IDENTIFIKASI_TUMBUHAN('Property','Value',...) creates a new IDENTIFIKASI_TUMBUHAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before identifikasi_tumbuhan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to identifikasi_tumbuhan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help identifikasi_tumbuhan

% Last Modified by GUIDE v2.5 12-Jun-2019 19:52:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @identifikasi_tumbuhan_OpeningFcn, ...
                   'gui_OutputFcn',  @identifikasi_tumbuhan_OutputFcn, ...
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


% --- Executes just before identifikasi_tumbuhan is made visible.
function identifikasi_tumbuhan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to identifikasi_tumbuhan (see VARARGIN)

% Choose default command line output for identifikasi_tumbuhan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');
hback = axes('units','normalized','position',[0 0 1 1]);
uistack(hback,'bottom'); % menciptakan axes untuk tempat menampilkan gambar
% menampilkan background
[back map]=imread('content.jpg');
image(back)
colormap(map)
background=imread('content.jpg');
% set(handles.pan1,'CData',background);
% handlevisibility off agar axes tidak terlihat
% dan gambar background saja yang muncul.
set(hback,'handlevisibility','off','visible','off')
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes identifikasi_tumbuhan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = identifikasi_tumbuhan_OutputFcn(hObject, eventdata, handles) 
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
[filename,pathname] = uigetfile('*.jpg');
 
if ~isequal(filename,0)
    Img_awl = imread(fullfile(pathname,filename));
    Img = imresize(Img_awl,[200 250]);    
    axes(handles.axes1)
    imshow(Img)
    title('Citra RGB')
else
    return
end
handles.Img = Img;
guidata(hObject, handles)

%Cek Gambar
x=fullfile(pathname);
set(handles.edit5,'String', x);
if strcmp(x, 'G:\MATLAB\identifikasi_tumbuhan_\data uji\')
    set(handles.edit6,'String',x); 
else
    axes(handles.axes1)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes2)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes4)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    axes(handles.axes5)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    
    set(handles.uitable1,'Data',[])
    set(handles.edit1,'String',[])
    set(handles.edit4,'String',[])
    msgbox('Folder Yang Anda Pilih Salah!!!!!','Warning','warn');    
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
 
% Color-Based Segmentation Using K-Means Clustering
cform = makecform('srgb2lab');
lab = applycform(Img,cform);
%lab=rgb2hsv(Img);
axes(handles.axes2)
imshow(lab)
title('Citra L*a*b');
 
handles.lab = lab;
guidata(hObject, handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
lab = handles.lab;
 
ab = double(lab(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
 
nColors = 2;
[cluster_idx, ~] = kmeans(ab,nColors,'distance','sqEuclidean', ...
    'Replicates',3);
 
pixel_labels = reshape(cluster_idx,nrows,ncols);
 
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
 
for k = 1:nColors
    color = Img;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
 
area_cluster1 = sum(find(pixel_labels==1));
area_cluster2 = sum(find(pixel_labels==2));
 
[~,cluster_min] = min([area_cluster1,area_cluster2]);
 
Img_bw = (pixel_labels==cluster_min);
Img_bw = imfill(Img_bw,'holes');
Img_bw = bwareaopen(Img_bw,50);
 
daun = Img;
R = daun(:,:,1);
G = daun(:,:,2);
B = daun(:,:,3);
R(~Img_bw) = 0;
G(~Img_bw) = 0;
B(~Img_bw) = 0;
daun_rgb = cat(3,R,G,B);
handles.Img_bw = Img_bw;

axes(handles.axes4)
imshow(Img_bw)
title('Citra biner');
 
stats = regionprops(Img_bw,'Area','Perimeter','Eccentricity');
area = stats.Area;
perimeter = stats.Perimeter;
metric = 4*pi*area/(perimeter^2);
eccentricity = stats.Eccentricity;
 
ciri_bentuk = cell(2,2);
ciri_bentuk{1,1} = 'Metric';
ciri_bentuk{2,1} = 'Eccentricity';
ciri_bentuk{1,2} = num2str(metric);
ciri_bentuk{2,2} = num2str(eccentricity);
 
handles.ciri_bentuk = ciri_bentuk;
guidata(hObject, handles)


set(handles.uitable1,'Data',ciri_bentuk,'RowName',1:2)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%=============UDAH GA KEPAKE====================
%Img_bw = handles.Img_bw;
 
%axes(handles.axes4)
%imshow(Img_bw)
%title('Citra biner');
 
%stats = regionprops(Img_bw,'Area','Perimeter','Eccentricity');
%area = stats.Area;
%perimeter = stats.Perimeter;
%metric = 4*pi*area/(perimeter^2);
%eccentricity = stats.Eccentricity;
 
%ciri_bentuk = cell(2,2);
%ciri_bentuk{1,1} = 'Metric';
%ciri_bentuk{2,1} = 'Eccentricity';
%ciri_bentuk{1,2} = num2str(metric);
%ciri_bentuk{2,2} = num2str(eccentricity);
 
%handles.ciri_bentuk = ciri_bentuk;
%guidata(hObject, handles)
 

%set(handles.uitable1,'Data',ciri_bentuk,'RowName',1:2)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
Img_bw = handles.Img_bw;
ciri_bentuk = handles.ciri_bentuk;
 
Img_gray = rgb2gray(Img);
Img_gray(~Img_bw) = 0;
 
axes(handles.axes5)
imshow(Img_gray)
title('Citra Grayscale')
 
pixel_dist = 1;
GLCM = graycomatrix(Img_gray,'Offset',[0 pixel_dist; -pixel_dist pixel_dist; -pixel_dist 0; -pixel_dist -pixel_dist]);
stats = graycoprops(GLCM,{'contrast','correlation','energy','homogeneity'});
Contrast = mean(stats.Contrast);
Correlation = mean(stats.Correlation);
Energy = mean(stats.Energy);
Homogeneity = mean(stats.Homogeneity);
 
ciri_total = cell(6,2);
ciri_total{1,1} = ciri_bentuk{1,1};
ciri_total{1,2} = ciri_bentuk{1,2};
ciri_total{2,1} = ciri_bentuk{2,1};
ciri_total{2,2} = ciri_bentuk{2,2};
ciri_total{3,1} = 'Contrast';
ciri_total{4,1} = 'Correlation';
ciri_total{5,1} = 'Energy';
ciri_total{6,1} = 'Homogeneity';
ciri_total{3,2} = num2str(Contrast);
ciri_total{4,2} = num2str(Correlation);
ciri_total{5,2} = num2str(Energy);
ciri_total{6,2} = num2str(Homogeneity);

handles.ciri_total = ciri_total;
guidata(hObject, handles)
 
set(handles.text2,'String','Ekstraksi Ciri')
set(handles.uitable1,'Data',ciri_total,'RowName',1:6)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ciri_database
ciri_total = handles.ciri_total;
MT = get(handles.uitable2,'data');

ciri = zeros(1,6);
for i = 1:6
    ciri(i) = str2double(ciri_total{i,2});
end
 
[num,~] = size(ciri_database);

dist = zeros(num,1);
for n = 1:num
    data_base = ciri_database(n,:);
    jarak = sum((data_base-ciri).^2).^0.5;
    dist(n,1) = jarak;
end

sav = zeros(num,2);
for n = 1:num    
    sav(n,1)=dist(n,1);       
    sav(n,2)=MT(n,7);       
end

hasil_awal = sav
hasil = sortrows(sav)
hasil2 = zeros(num,2);

k=get(handles.edit4,'String');
if isempty(k)
    msgbox('Masukan Nilai K','warning','warn')
else
dt = str2double(k);
end

for n=1:dt
   hasil2(n,1)=hasil(n,1); 
   hasil2(n,2)=hasil(n,2); 
end
hasil2

% hasil klasifikasi 
satu=0;
dua=0;
tiga=0;
for n=1:dt
    if hasil2(n,2)==1
        satu = satu + 1;
    elseif hasil2(n,2)==2
        dua = dua + 1;
    elseif hasil2(n,2)==3
        tiga = tiga + 1;    
    end
end

if satu>dua&&satu>tiga
    set(handles.edit1,'String','Jambu');
    daun_jambu;
elseif dua>satu&&dua>tiga
    set(handles.edit1,'String','Kersen');
    daun_kersen;
elseif tiga>satu&&tiga>dua
    set(handles.edit1,'String','Sirih');
    daun_sirih;
else
    hasil3=min(hasil2);
    hasil3(1,1)=hasil2(1,1); 
    hasil3(1,2)=hasil2(1,2);
    if hasil3(1,2)==1
        kl='Jambu';
        daun_jambu;
    elseif hasil3(1,2)==2
        kl='Kersen';
        daun_kersen;
    elseif hasil3(1,2)==3
        kl='Sirih';
        daun_sirih;
    end
    set(handles.edit1,'String',kl);
    
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes4)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes5)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 

set(handles.uitable1,'Data',[])
set(handles.edit1,'String',[])
set(handles.edit4,'String',[])

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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(identifikasi_tumbuhan);
menu



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


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(daun_jambu);
