%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function [dataCursorIndices_pre,angle_selected_segment_pre,...
    dataCursorIndices_post,angle_selected_segment_post] = get_cursros_pre_post(cursor_info)
    dataCursorIndices_pre = [];
    dataCursorIndices_post = [];
    for icur = 1:size(cursor_info,2)
        curr_cursor = cursor_info(icur);
        if isequal(curr_cursor.Target.Color,[0,0,1]) %Blue-pre
            dataCursorIndices_pre(end+1) = curr_cursor.DataIndex;
            angle_selected_segment_pre = curr_cursor.Target.YData;
        elseif isequal(curr_cursor.Target.Color,[1,0,0]) %Red-post
            dataCursorIndices_post(end+1) = curr_cursor.DataIndex;
            angle_selected_segment_post = curr_cursor.Target.YData;

        end
    end

    dataCursorIndices_pre = sort(dataCursorIndices_pre);
    dataCursorIndices_post = sort(dataCursorIndices_post);