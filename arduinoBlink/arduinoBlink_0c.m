%%Software to make an LED on the Arduino board blink
%{
A test of MatLab and Arduino connectivity, that will also allow me to
start uilding the GUI environement I want for the arduino control for
future projects.
%}


% Create the Arduino object
clear a;
a = arduino ('COM4', 'Uno')

% Binary turn the LED on and off
%{
writeDigitalPin (a, 'D09', 0);
for i = 1:10
    writeDigitalPin (a, 'D09', 1);
    pause (0.5);
    writeDigitalPin (a, 'D09', 0);
    pause (0.5);
end
%}

% Dim LED via PWM Duty Cycle
%{
brightness_step = ((1-0)/20);
for i = 1:20
    writePWMDutyCycle (a, 'D09', i*brightness_step);
    pause (0.1);
end

for i = 1:20
    writePWMDutyCycle (a, 'D09', 1-(i*brightness_step));
    pause (0.1);
end
%}

% Dim LED via PWM Voltage
brightness_step = ((5-0)/20);
for i = 1:20
    writePWMVoltage (a, 'D09', i*brightness_step);
    pause (0.1);
end

for i = 1:20
    writePWMVoltage (a, 'D09', 5-(i*brightness_step));
    pause (0.1);
end

clear a;