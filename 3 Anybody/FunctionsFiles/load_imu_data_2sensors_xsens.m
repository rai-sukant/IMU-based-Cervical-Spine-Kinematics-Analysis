function [quat_sensor1, quat_sensor2] = load_imu_data_2sensors_xsens(datafilename)
% This function loads quaternion data from Xsens DOT CSV file
% Sensor mapping:
%   W4 → Sensor 1 (Neck)
%   W5 → Sensor 2 (Head)

datatable=readtable(datafilename);

%% -------- SENSOR 1 : W4 (Neck) --------
quat1_w = datatable.W4_quat_w;
quat1_x = datatable.W4_quat_x;
quat1_y = datatable.W4_quat_y;
quat1_z = datatable.W4_quat_z;

quat_sensor1 = [quat1_w, quat1_x, quat1_y, quat1_z];

%% -------- SENSOR 2 : W5 (Head) --------
quat2_w = datatable.W5_quat_w;
quat2_x = datatable.W5_quat_x;
quat2_y = datatable.W5_quat_y;
quat2_z = datatable.W5_quat_z;

quat_sensor2 = [quat2_w, quat2_x, quat2_y, quat2_z];

