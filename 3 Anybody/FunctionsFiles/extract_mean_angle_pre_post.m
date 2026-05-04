%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function mean_angle_prepost = extract_mean_angle_pre_post(cursor_info)

    [dataCursorIndices_pre, angle_selected_segment_pre, dataCursorIndices_post, angle_selected_segment_post] = get_cursros_pre_post(cursor_info);

    %   Extract means of chosen segments
    mean_angle_prepost = [];
    %   Movement side 1
    for iseg = 1:4:12
        mean_angle_prepost(end+1,1) = nanmean(angle_selected_segment_pre(dataCursorIndices_pre(iseg):dataCursorIndices_pre(iseg+1)));
        mean_angle_prepost(end,2) = nanmean(angle_selected_segment_post(dataCursorIndices_post(iseg):dataCursorIndices_post(iseg+1)));
    end

    %   Movement side 2
    for iseg = 3:4:12
        mean_angle_prepost(end+1,1) = nanmean(angle_selected_segment_pre(dataCursorIndices_pre(iseg):dataCursorIndices_pre(iseg+1)));
        mean_angle_prepost(end,2) = nanmean(angle_selected_segment_post(dataCursorIndices_post(iseg):dataCursorIndices_post(iseg+1)));
    end