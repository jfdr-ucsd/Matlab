%%Software to make an LED on the Arduino board blink
%{
A test of MatLab and Arduino connectivity, that will also allow me to
start uilding the GUI environement I want for the arduino control for
future projects.
%}

% Create the Arduino object
clear a;
a = arduino ('COM7', 'Uno');
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

% Create a lamp status panel
panel_status = uipanel(figr, ...
    'Position', [000 200 300 100]);
% Label it
status_label = uilabel(panel_status, ...
    'Position', [010 000 100 100], ...
    'Text', 'LED Status');
% Add a lamp to mimic LED
status_lamp = uilamp(panel_status, ...
    'Position', [100 040 020 020], ...
    'Color', 'blue');
% A simple switch that turns the LED on and off
status_sw_LED = uiswitch (panel_status, 'slider', ...
    'Items', {'On', 'Off'}, ...
    'Position', [200 040 045 020], ...
    'ValueChangedFcn', @switchLED);

% Create a blinking control panel
panel_blink = uipanel(figr, ...
    'Position', [000 100 300 100]);
blink_label = uilabel(panel_blink, ...
    'Position', [015 080 100 020], ...
    'Text', 'Blinking Controls');
blink_button_on = uibutton (panel_blink, 'state', ...
    'Text', {'Blinking On'}, ...
    'Position', [010 050 100 020], ...
    'ValueChangedFcn', @blinkOn);
blink_button_off = uibutton (panel_blink, 'state', ...
    'Text', {'Blinking Off'}, ...
    'Position', [010 020 100 020], ...
    'UserData', 0, ...
    'ValueChangedFcn', @blinkOff);

% the GUI functions
    % A simple switch that turns the LED on and off
    function switchLED (src, event)
        switch src.Value
            case 'On'
                status_lamp.Color = 'red';
                ledOn (a);
            case 'Off'
                status_lamp.Color = [0 0 0];
                ledOff (a);
        end
    end

    % Turns blinking off
    function blinkOff (src, event)
        set (src.UserData, 1);
        disp ('Turn blinking off');
        disp (src.UserData);
    end

    % Turns blinking on 
    function blinkOn (src, event)
        set (blink_button_off.UserData, 0);
        disp ('Turn blinking on');
        disp (blink_button_off.UserData);
        i = 1;
        while i < 30
            % your iterative computation here
            i = i + 1;
            disp (i);
            pause(0.1);
            if get(blink_button_off.UserData) % stop condition
                break;
            end

        end
        
    end
    
end

