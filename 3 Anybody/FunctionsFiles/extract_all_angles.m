% In FunctionsFiles/extract_all_angles.m

function [movement_angle, head_angle, torso_angle] = extract_all_angles(datafilename, chosen_plane, segment)
% This function returns the relative movement angle, AND the absolute
% pitch angles for the head and torso sensors.

    [quat_sensor1, quat_sensor2] = load_imu_data_2sensors(datafilename);

    switch lower(chosen_plane)
        case 'sagital'
            % Convert quaternions to eulerian angles [deg]
            eul_angle_sensor1 = quat2eul(quat_sensor1, segment{1}) * 180/pi;
            eul_angle_sensor2 = quat2eul(quat_sensor2, segment{1}) * 180/pi;
            
            % --- CORRECTED SECTION ---
            % All outputs are now 1D vectors of the pitch angle (column 2)
            movement_angle = eul_angle_sensor2(:, segment{2}) - eul_angle_sensor1(:, segment{2});
            head_angle     = eul_angle_sensor2(:, segment{2});
            torso_angle    = eul_angle_sensor1(:, segment{2});
            % --- END OF CORRECTION ---
            
        otherwise
            error('This function is currently configured for the "Sagital" plane only.');
    end
end