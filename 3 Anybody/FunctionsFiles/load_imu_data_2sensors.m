%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function [quat_sensor1,quat_sensor2] = load_imu_data_2sensors(datafilename)
% This function load the quaterion data of the two sensors from csv file of
% DESLSYS data structure.

datatable=readtable(datafilename);
% sampling_freq=74; %[Hz]

quat1_w=datatable.AvantiSensor1_ORIENT_W1;
quat1_x=datatable.AvantiSensor1_ORIENT_X1;
quat1_y=datatable.AvantiSensor1_ORIENT_Y1;
quat1_z=datatable.AvantiSensor1_ORIENT_Z1;
quat_sensor1=[quat1_w,quat1_x,quat1_y,quat1_z];

quat2_w=datatable.AvantiSensor2_ORIENT_W2;
quat2_x=datatable.AvantiSensor2_ORIENT_X2;
quat2_y=datatable.AvantiSensor2_ORIENT_Y2;
quat2_z=datatable.AvantiSensor2_ORIENT_Z2;
quat_sensor2=[quat2_w,quat2_x,quat2_y,quat2_z];