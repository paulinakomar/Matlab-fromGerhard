function varargout = SL_gui(varargin)
% SL_GUI MATLAB code for SL_gui.fig
%      SL_GUI, by itself, creates a new SL_GUI or raises the existing
%      singleton*.
%
%      H = SL_GUI returns the handle to a new SL_GUI or the handle to
%      the existing singleton*.
%
%      SL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SL_GUI.M with the given input arguments.
%
%      SL_GUI('Property','Value',...) creates a new SL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SL_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SL_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SL_gui

% Last Modified by GUIDE v2.5 18-Feb-2014 16:48:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SL_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @SL_gui_OutputFcn, ...
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


% --- Executes just before SL_gui is made visible.
function SL_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SL_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%% start of the gui

%% chose the appropriate material system from popup menu
function MaterialSystem_popup_Callback(hObject, eventdata, handles)
function MaterialSystem_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% buffer layer
    % tick if there is an additional buffer layer
    function BufferLayer_checkbox_Callback(hObject, eventdata, handles)
        if (handles.BufferLayer_checkbox)
            set(handles.BufferLayer_choose_popup, 'Visible', 'on');
            set(handles.Thickness_buffer, 'Visible', 'on');
            set(handles.text2, 'Visible', 'on');
        end
        
    % choose what material do you have as a buffer layer
    function BufferLayer_choose_Callback(hObject, eventdata, handles)
    function BufferLayer_choose_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    % thickness of the buffer layer
    function Thickness_buffer_Callback(hObject, eventdata, handles)
    function Thickness_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


    % choose material that there is as a buffer layer
    function BufferLayer_choose_popup_Callback(hObject, eventdata, handles)
    function BufferLayer_choose_popup_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
        
 %% simulate
 system = get(handles.MaterialSystem_popup, 'Value');
 range;

[twotheta1, Intensity1, twotheta2, Intensity2, IntensityGauss1, IntensityGauss2] = sl(system, range);
%  hold on;
 box on;
 
    plot(handles.plot_T_2T_200_lin, twotheta1, Intensity1);
        xlabel(handles.plot_T_2T_200_lin, '2\it{\theta} (deg)');
        ylabel(handles.plot_T_2T_200_lin, 'Intensity');
    plot(handles.plot_T_2T_400_lin, twotheta2, Intensity2);
        xlabel(handles.plot_T_2T_400_lin, '2\it{\theta} (deg)');
        ylabel(handles.plot_T_2T_400_lin, 'Intensity');
    semilogy(handles.plot_T_2T_200_log, twotheta1,IntensityGauss1+1e-6);
        xlabel(handles.plot_T_2T_200_log, '2\it{\theta} (deg)');
        ylabel(handles.plot_T_2T_200_log, 'Normalized intensity');
    semilogy(handles.plot_T_2T_400_log, twotheta2,IntensityGauss2+1e-6);
        xlabel(handles.plot_T_2T_400_log, '2\it{\theta} (deg)');
        ylabel(handles.plot_T_2T_400_log, 'Normalized intensity');



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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


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
