%%Software to make an LED on the Arduino board blink
%{
A test of MatLab and Arduino connectivity, that will also allow me to
start uilding the GUI environement I want for the arduino control for
future projects.
%}

% Create the Arduino object
clear a;
a = arduino ('COM4', 'Uno')
%}

% 
lampControl (a);

% Testing the Arduino functions
%{
ledOff (a);
ledOn (a);
pause (0.5);
ledOff (a);
step_width = 100;
delay = 0.01;
ledBriPWMDuty (a, step_width, delay);
ledDimPWMDuty (a, step_width, delay);
ledBriPWMVolt (a, step_width, delay);
ledDimPWMVolt (a, step_width, delay);
%}
% Release the Arduino, clean up
clear a;

% ----- %
% Here are all the function definitions

% the Arduino functions
% Binary turn the LED Off
function ledOff (a)
    writeDigitalPin (a, 'D09', 0);
    %disp ('LED Off');
end 
% Binary turn the LED On
function ledOn (a)
    writeDigitalPin (a, 'D09', 1);
    %disp ('LED On');
end
% Control LED Brightness via PWM Duty Cycle
function ledBriPWMDuty (a, step_width, delay)
    steps = (1/step_width);
    %disp ('LED Brightening')
    for i = 1:step_width
        writePWMDutyCycle (a, 'D09', i*steps);
        pause (delay);
    end
end
% Dim LED via PWM Duty Cycle
function ledDimPWMDuty (a, step_width, delay)
    steps = (1/step_width);
    %disp ('LED Dimming')
    for i = 1:step_width
        writePWMDutyCycle (a, 'D09', 1-(i*steps));
        pause (delay);
    end
end
% Brighten LED via PWM Voltage
function ledBriPWMVolt (a, step_width, delay)
    steps = (5/step_width);
    %disp ('LED Brightening')
    for i = 1:step_width
        writePWMVoltage (a, 'D09', i*steps);
        pause (delay);
    end
end
% Dim LED via PWM Voltage
function ledDimPWMVolt (a, step_width, delay)
    steps = (5/step_width);
    %disp ('LED Dimming')
    for i = 1:step_width
        writePWMVoltage (a, 'D09', 5-(i*steps));
        pause (delay);
    end
end

% Create a GUI window with stuff in it
function lampControl (a)
% Create the GUI window itself - [left bottom width height]
figr = uifigure('Position', [300 300 300 300], ...
    'Name', 'Arduino Blinking GUI');
% Create a lamp status
panel_status = uipanel(figr, ...
    'Position', [000 200 300 100]);
status_label = uilabel(panel_status, ...
    'Position', [075 000 100 100], ...
    'Text', 'LED Status');
lamp = uilamp(panel_status, ...
    'Position', [200 040 020 020], ...
    'Color', 'blue');

% Create a switch object
panel_blink = uipanel(figr, ...
    'Position', [000 100 300 100]);

sw_blink = uiswitch (figr, 'slider', ...
    'Items', {'On', 'Off'}, ...
    'Position', [100 040 045 020], ...
    'ValueChangedFcn', @switchBlink);

sw_fade = uiswitch (figr, 'slider', ...
    'Items', {'On', 'Off'}, ...
    'Position', [100 080 020 020], ...
    'ValueChangedFcn', @switchFade);

% the GUI functions
function switchBlink (src, event)
    step_width = 2;
    delay = 0.1;
    switch src.Value
        case 'On'
            
            lamp.Color = 'red';
            ledOn (a);
            
            
        case 'Off'
            %disp ('Switch Off')
            lamp.Color = [0 0 0];
            ledOff (a);
            %ledDimPWMDuty (a, step_width, delay)
    end
end
end

