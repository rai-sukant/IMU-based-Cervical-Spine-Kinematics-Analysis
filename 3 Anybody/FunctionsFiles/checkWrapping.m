%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function [movement_angle] = checkWrapping(movement_angle)
    movement_angle_wrapp = wrapTo360(movement_angle);
    diff_movement_angle = diff(movement_angle_wrapp);
    if sum(abs(diff_movement_angle)>250)<2 % Check if any sudden angle change due to the cyclic of the angle (arctan)
        movement_angle = movement_angle_wrapp;
    end