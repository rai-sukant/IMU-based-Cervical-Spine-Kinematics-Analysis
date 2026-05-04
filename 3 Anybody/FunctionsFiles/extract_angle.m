%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function [movement_angle]= extract_angle(datafilename,chosen_plane,segment)
% This function extract the angle between two sensors from the chosen
% plane, and selected segment for calculation.
% Input: 
% datafilename : string = full path of the data file.
%   chosen_plane : string = 'Sagital' or 'Frontal' or 'Horizontal'
% segment : (string or cell 1X2) =  the desired segment for calcuating the angle,
%                                   if segment is cell of 2, first element is the segment and 
%                                   the second element is the desired axis according to 
%                                   the angle's plane:
%                                   X - Horizontal 
%                                   Y - Frontal
%                                   Z - Sagital

[quat_sensor1,quat_sensor2] = load_imu_data_2sensors_xsens(datafilename);
switch chosen_plane
    case 'Sagital'
        %   Convert quaterions to eularian angles [deg]
        eul_angle_sensor1 = quat2eul(quat_sensor1,segment{1}) * 180/pi;
        eul_angle_sensor2 = quat2eul(quat_sensor2,segment{1}) * 180/pi;
        
        %   Movement angle is the different angle between both sensors on the movement axis 
        movement_angle = eul_angle_sensor2(:,segment{2}) - eul_angle_sensor1(:,segment{2});
    
    case 'Frontal'
        %   Convert quaterions to eularian angles [deg]
        eul_angle_sensor1 = quat2eul(quat_sensor1,segment{1}) * 180/pi;
        eul_angle_sensor2 = quat2eul(quat_sensor2,segment{1}) * 180/pi;

        %   Wrap angle between 0 and 360 [deg] at desired mocement axis
        eul_angle_sensor1 = wrapTo360(eul_angle_sensor1(:,segment{2}));
        eul_angle_sensor2 = wrapTo360(eul_angle_sensor2(:,segment{2}));

        %   Movement angle is the different angle between both sensors on the movement axis 
        movement_angle = eul_angle_sensor2 - eul_angle_sensor1;
        
    case 'Horizontal'
        %   Convert quaterions to cartesian coorinates
        cartz_coord_sensor1 = quaternions_to_cartesian(quat_sensor1, segment{1});
        cartz_coord_sensor2 = quaternions_to_cartesian(quat_sensor2, segment{1});
      
        %   Get 2D coordinates in XY plane (rotation in Z-axis, no coordinated change)
        cartz_coord_2d_sensor1 = cartz_coord_sensor1(:,1:2);
        cartz_coord_2d_sensor2 = cartz_coord_sensor2(:,1:2);

        %   Offest sensor 1 so baseline would be (1,0) 
        %   (assuming 800 still in baseline)
        cartz_coord_2d_sensor1  = cartz_coord_2d_sensor1 - cartz_coord_2d_sensor1(800,:);
        cartz_coord_2d_sensor1(:,1) = cartz_coord_2d_sensor1(:,1)+1;
        
        %   Extract the angle between two caritzian vectors
        movement_angle = angles_between_cartezian_vec(cartz_coord_2d_sensor1, cartz_coord_2d_sensor2);
end