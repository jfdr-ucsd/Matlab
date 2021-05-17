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

%% Creating Buttons
hLEDon = uicontrol('Style','togglebutton',...
    'String', 'LED On',...
    'FontUnits','normalized',...
    'Position',[010 330 150 025],...
    'Callback',{@callbackLEDon});
hLEDoff = uicontrol('Style','pushbutton',...
    'String','LED Off',...
    'FontUnits','normalized',...
    'Position',[010 300 150 025],...
    'Callback',{@callbackLEDoff});
hExit = uicontrol('Style','pushbutton',...
    'String','Exit',...
    'FontUnits','normalized',...
    'Position',[010 010 150 025],...
    'Callback',{@callbackExit});
hBlink = uicontrol('Style','togglebutton',...
    'String', 'Blinking Control',...
    'FontUnits','normalized',...
    'Position',[010 230 150 025],...
    'Callback',{@callbackBlink});

%% Functions defining what the buttons do

    function callbackLEDon (source, eventdata)
        disp ('LED on');
        writeDigitalPin (a, 'D09', 1);
    end

    function callbackLEDoff (source, eventdata)
        disp ('LED off');
        writeDigitalPin (a, 'D09', 0);
    end

    function callbackExit (source, eventdata)
        disp ('Exiting GUI');
        fclose('all');
        close all;
        clear all;
    end

    function callbackBlink (source, eventdata)
       
        while get (hBlink, 'Value') == 1 
            if get (hBlink, 'Value') == 0
                break
            end
            writeDigitalPin (a, 'D09', 1);
            pause (0.1);
            writeDigitalPin (a, 'D09', 0);
           
        end
    end

%% Actually executing the program

% Show Window
movegui(f,'center')
f.Visible='on';
%readtemps;
end