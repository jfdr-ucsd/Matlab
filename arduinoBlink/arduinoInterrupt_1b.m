%% Software to accept an interrupt input

% A test of MatLab connectivity, checking for high or low on a given pin
% before proceeding with executing code elsewhere

function thisIsTerribleProgramming ()
%% Create my variables
% Create the Arduino object
% Close all possible open connections
fclose('all');
close all;
clear all;
clc;

clear a;
a = arduino ('COM7', 'Uno');
fprintf ('Defined the arduino \n')

% Define my pins
SWC_PIN = 'D07';
LED_PIN = 'D09';
FLW_PIN = 'D02';

% Other stuff
value = readDigitalPin (a, DIN_PIN);
loop_time = 0.1;

%% Creating Window and Title
f=figure('Visible','off',...
    'Position', [010 010 600 400],...
    'Name','Arduino Interrupt Control',...
    'NumberTitle','off',...
    'MenuBar','none');

htitle=uicontrol('Style','Text',...
    'String','Arduino Interrupt Control',...
    'FontUnits','normalized', ...
    'FontWeight','Bold',...
    'BackgroundColor',[0.7 0.7 0.7],...
    'ForegroundColor','k',...
    'Position',[200, 370, 200, 030]);

%% Creating buttons and input dialogs
%Red LED Panel
hPanelRed = uipanel('Title', 'Red LED', ...
    'BackgroundColor', 'white', ...
    'Position',[.05 .05 .40 .80]);

hRedLock = uipanel ('Title', 'Lock Status', ...
    'Parent', hPanelRed, ...
    'BackgroundColor', 'blue', ...
    'Position', [.05 .75 .35 .15]);

hRedLEDbinary = uicontrol('Style','togglebutton',...
    'Parent', hPanelRed, ...
    'String', 'LED On/Off',...
    'FontUnits','normalized',...
    'Position',[010 180 150 025],...
    'Callback',{@callbackRedLEDbinary});

hRedExit = uicontrol('Style','pushbutton',...
    'Parent', hPanelRed, ...
    'String','Exit',...
    'FontUnits','normalized',...
    'Position',[010 010 150 025],...
    'Callback',{@callbackExit});

%% Actually executing the program
% Show Window
movegui(f,'center')
f.Visible='on';
fprintf ('created the GUI \n');
checkInterrupt();

%% Functions defining what the buttons do

% Binary LED control
    function callbackRedLEDbinary (source, eventdata)
        if hRedLEDbinary.Value == 0
            fprintf ('button LED value %f \n', hRedLEDbinary.Value);
            writeDigitalPin (a, LED_PIN, 0);
            checkInterrupt();
        end
        if hRedLEDbinary.Value == 1
            fprintf ('button LED value %f \n', hRedLEDbinary.Value);
            writeDigitalPin (a, LED_PIN, 1);
            checkInterrupt();
        end
    end

% Check the interrupt pin
    function checkInterrupt ()
        intVal = readDigitalPin (a, DIN_PIN);
        if intVal == 0
            fprintf ('Interrupt pin is at %f \n', intVal);
        end
        if intVal == 1
            fprintf ('Interrupt pin is at %f \n', intVal);
        end
       
    end

% Exit the GUI
    function callbackExit (source, eventdata)
        fclose('all');
        close all;
        clear all;
    end

% this ends the wrapper function
end