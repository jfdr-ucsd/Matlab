%%Software to make an LED on the Arduino board blink

%A test of MatLab and Arduino connectivity, that will also allow me to
%start uilding the GUI environement I want for the arduino control for
%future projects.

% Create the Arduino object
clear a;
a = arduino ('COM7', 'Uno')

%Turn the LED on and off
writeDigitalPin (a, 'D09', 0);
for i = 1:10
    writeDigitalPin (a, 'D09', 1);
    pause (0.5);
    writeDigitalPin (a, 'D09', 0);
    pause (0.5);
end
