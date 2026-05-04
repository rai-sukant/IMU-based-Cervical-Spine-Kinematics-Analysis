%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function cursor_info = manual_cursor(fig,n_cursors)

if n_cursors ==12
    msgbox(["Please choose one of the angle plots (segemnt) and click on "+num2str(n_cursors)+" data points to select them using data cursors.", ...
        "(6 movement and 6 baselines prior to each movement)."]);
elseif n_cursors == 20
    msgbox(["Please choose one of the angle plots (segemnt) and click on "+num2str(n_cursors)+" data points to select them using data cursors.", ...
        "(10 movement and 10 baselines prior to each movement)."]);
elseif n_cursors == 24
    msgbox(["Please choose one of the angle plots (segemnt) and click on "+num2str(n_cursors)+" data points to select them using data cursors.", ...
        "(PRE (Blue) - 6 movement, start and end of each movement).",...
        "(POST (Red) - 6 movement, start and end of each movement)."]);
end


% Wait for the user to select the cursors
dcm_obj = datacursormode(fig);
set(dcm_obj, 'Enable', 'on');
set(dcm_obj, 'UpdateFcn', []);

cursor_count = 0;
while cursor_count < n_cursors
    cursor_info = getCursorInfo(dcm_obj);
    if cursor_count ~= length(cursor_info)
        cursor_count = length(cursor_info);
        sgtitle({"Select "+n_cursors+" datacursor (hold Shift while clicking)"; ...
            "Number of selected cursors = "+num2str(cursor_count)})
    end
    pause(0.01); 
end