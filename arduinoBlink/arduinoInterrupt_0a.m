%% Software to accept an interrupt input

% A test of MatLabconnectivity, checking for high or low on a given pin
% before proceeding with executing code elsewhere

%% Create my variables
% Create the Arduino object
clear a;
a = arduino ('COM7', 'Uno');

% Define my pins
DIN_PIN = 'D07';
LED_PIN = 'D09';

% Other stuff
value = readDigitalPin (a, DIN_PIN);
loop_time = 0.2;

% Blink the LED for a function check
pause (loop_time);
writeDigitalPin (a, LED_PIN, 1);
fprintf ('Setting LED on \n');
pause (loop_time);
writeDigitalPin (a, LED_PIN, 0);
fprintf ('Setting LED off \n');

% A little loop to give me some time to push the interrupt button
for i = 1:100
    value = readDigitalPin (a, DIN_PIN);
    pause (loop_time);
    fprintf ('Input Pin reads %f \n', value);
    if value == 0
        writeDigitalPin (a, LED_PIN, 0);
    else
        writeDigitalPin (a, LED_PIN, 1);
    end
end

writeDigitalPin (a, LED_PIN, 0);
fprintf ('Setting LED off \n');