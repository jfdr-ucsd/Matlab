% %Software to make an LED on the Arduino board blink
%{
Creating a MatLab Arduino control GUI, following now Nick did it.
Uses the figure options instead of uifigure.
%}

function arduinoBlink
%% Initializing the Arduino object
% Close all possible open connections
fclose('all');
close all;
clear all;
clc;

% Create the Arduino object
clear a;
%channel=inputdlg('Arduino Port (i.e. COM4)','Port',1,{'COM4'});
a=arduino('COM4','Uno','Libraries','PaulStoffregen/OneWire');

%% Creating Window and Title
f=figure('Visible','off',...
    'Position', [010 010 600 400],...
    'Name','Arduino Blinking Control',...
    'NumberTitle','off',...
    'MenuBar','none');

htitle=uicontrol('Style','Text',...
    'String','Arduino Blnking Control',...
    'FontUnits','normalized', ...
    'FontWeight','Bold',...
    'BackgroundColor',[0.7 0.7 0.7],...
    'ForegroundColor','k',...
    'Position',[200, 370, 200, 030]);

%% Creating buttons and input dialogs

hPanelRed = uipanel('Title', 'Red LED', ...
    'BackgroundColor', 'white', ...
    'Position',[.05 .05 .40 .90]);

hLEDbinary = uicontrol('Style','togglebutton',...
    'Parent', hPanelRed, ...
    'String', 'LED On/Off',...
    'FontUnits','normalized',...
    'Position',[010 180 150 025],...
    'Callback',{@callbackLEDbinary});

hBlink = uicontrol('Style','togglebutton',...
    'Parent', hPanelRed, ...
    'String', 'Start/Stop Blinking',...
    'FontUnits','normalized',...
    'Position',[010 110 150 025],...
    'Callback',{@callbackBlink});

hWaitText = uicontrol ('Style', 'text',...
    'Parent', hPanelRed, ...
    'String', 'Input Blinking Speed',...
    'FontUnits','normalized',...
    'Position',[010 070 150 025]);

hWaitTime = uicontrol ('Style', 'slider', ...
    'Parent', hPanelRed, ...
    'FontUnits','normalized',...
    'Position',[010 050 150 025]);
hWaitTime.Value = 0.5;

hExit = uicontrol('Style','pushbutton',...
    'Parent', hPanelRed, ...
    'String','Exit',...
    'FontUnits','normalized',...
    'Position',[010 010 150 025],...
    'Callback',{@callbackExit});

%% Functions defining what the buttons do
% Exit the GUI
    function callbackExit (source, eventdata)
        fclose('all');
        close all;
        clear all;
    end

% Binary LED control
    function callbackLEDbinary (source, eventdata)
        if hLEDbinary.Value == 0
            fprintf ('button LED value %f \n', hLEDbinary.Value);
            writeDigitalPin (a, 'D09', 0);
        end
        if hLEDbinary.Value == 1
            fprintf ('button LED value %f \n', hLEDbinary.Value);
            writeDigitalPin (a, 'D09', 1);
        end
    end

% Blinking control
    function callbackBlink (source, eventdata)
        hLEDbinary.Value = 1;
        while get (hBlink, 'Value') == 1 
            if get (hBlink, 'Value') == 0
                break;
            end
            if get (hLEDbinary, 'Value') == 0
                break;
            end
            writeDigitalPin (a, 'D09', 1);
            pause (hWaitTime.Value);
            writeDigitalPin (a, 'D09', 0);
            pause (hWaitTime.Value);
        end
    end

%% Actually executing the program

% Show Window
movegui(f,'center')
f.Visible='on';

end