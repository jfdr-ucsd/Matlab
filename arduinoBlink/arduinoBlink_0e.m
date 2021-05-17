%%Software to make an LED on the Arduino board blink
%{
A test of MatLab and Arduino connectivity, that will also allow me to
start uilding the GUI environement I want for the arduino control for
future projects.
%}

% Create the Arduino object
clear a;
a = arduino ('COM4', 'Uno')

% Create a GUI window with options in it

% Binary turn the LED on and off
%{
ledOff(a);
for i = 1:10
    ledOn(a);
    pause (0.5);
    ledOff(a);
    pause (0.5);
end
%}

% PWM Duty Cycle 
ledOff (a);
step_width = 500;
delay = 0.01;
ledBriPWMDuty (a, step_width, delay);
ledDimPWMDuty (a, step_width, delay);
ledBriPWMVolt (a, step_width, delay);
ledDimPWMVolt (a, step_width, delay);
%}

% Release the Arduino, clean up
clear a;

% Here are all the function definitions

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
%}

% Control LED Brightness via PWM Duty Cycle
function ledBriPWMDuty (a, step_width, delay)
    steps = (1/step_width);
    for i = 1:step_width
        writePWMDutyCycle (a, 'D09', i*steps);
        pause (delay);
    end
end
% Brighten LED via PWM Duty Cycle
function ledDimPWMDuty (a, step_width, delay)
    steps = (1/step_width);
    for i = 1:step_width
        writePWMDutyCycle (a, 'D09', 1-(i*steps));
        pause (delay);
    end
end
%}

% Dim LED via PWM Voltage
function ledBriPWMVolt (a, step_width, delay)
    steps = (5/step_width);
    for i = 1:step_width
        writePWMVoltage (a, 'D09', i*steps);
        pause (delay);
    end
end
% Brighten LED via PWM Voltage
function ledDimPWMVolt (a, step_width, delay)
    steps = (5/step_width);
    for i = 1:step_width
        writePWMVoltage (a, 'D09', 5-(i*steps));
        pause (delay);
    end
end
%}