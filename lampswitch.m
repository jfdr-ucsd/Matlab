function lampswitch
fig = uifigure('Position',[100 100 370 280]);


lmp = uilamp(fig,...
    'Position',[165 75 20 20],...
    'Color','green');


sw = uiswitch(fig,'toggle',...
    'Items',{'Go','Stop'},...    
    'Position',[165 160 20 45],...
    'ValueChangedFcn',@switchMoved); 

% ValueChangedFcn callback
function switchMoved(src,event)  
    switch src.Value
        case 'Go'
            lmp.Color = 'green';
        case 'Stop'
            lmp.Color = 'red';
        end
    end
end