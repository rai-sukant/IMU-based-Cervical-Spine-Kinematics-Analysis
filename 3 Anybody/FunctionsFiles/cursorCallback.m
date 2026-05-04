%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

% Define the data cursor callback function
function output_txt = cursorCallback(~, event_obj)
pos = get(event_obj, 'Position');
x_value = pos(1);
y_value = pos(2);

% Display the cursor information as text
output_txt = {['X: ' num2str(x_value)], ['Y: ' num2str(y_value)], 'Press Enter to continue'};

% Store the cursor position in the handles structure
handles = guidata(gcf);
handles.x_value = x_value;
handles.y_value = y_value;
guidata(gcf, handles);
end