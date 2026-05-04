%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function angle_to_baseline = extract_angle_validate(cursor_info,n_cursors)
if length(cursor_info)==n_cursors
    angle_selected_segment = cursor_info(1).Target.YData;
    x_poisitions = sort(arrayfun(@(x) x.Position(1), cursor_info));
    angle_cursors = angle_selected_segment(x_poisitions)';
    angle_to_baseline = angle_cursors(2:2:end)-angle_cursors(1:2:end);
else
    errordlg('Check the cursors')
end