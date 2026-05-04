function xsens_to_delsys(inputFile, outputFile)
% convert_xsens_quat_to_avanti
%
% Extracts only quaternion columns from Xsens W4/W5 format and
% renames them to AvantiSensor1 / AvantiSensor2 format.
%
% Usage:
%   convert_xsens_quat_to_avanti(inputPath, outputPath)
%
% Example:
%   convert_xsens_quat_to_avanti( ...
%     "", ...
%     "");

% -------------------------------------------------------
% Simple column extraction + renaming (No processing)
% W4 -> AvantiSensor1, W5 -> AvantiSensor2
% -------------------------------------------------------

clear; clc;

% ---------- File paths (change these) ----------
inputFile = "E:\local_git\Cervical_ROM\Test_trial_Xsens_3-2-25\Sukant\sukant_imu_data_2.csv";   % <-- your original CSV
outputFile = "E:\local_git\Cervical_ROM\Test_trial_Xsens_3-2-25\Sukant\sukant_imu_data_2_target_data.csv";    % <-- new formatted CSV

% ---------- Read original CSV ----------
T = readtable(inputFile);

% ---------- Select only quaternion columns ----------
T_new = table();

T_new.AvantiSensor1_ORIENT_W1 = T.W4_quat_w;
T_new.AvantiSensor1_ORIENT_X1 = T.W4_quat_x;
T_new.AvantiSensor1_ORIENT_Y1 = T.W4_quat_y;
T_new.AvantiSensor1_ORIENT_Z1 = T.W4_quat_z;

T_new.AvantiSensor2_ORIENT_W2 = T.W5_quat_w;
T_new.AvantiSensor2_ORIENT_X2 = T.W5_quat_x;
T_new.AvantiSensor2_ORIENT_Y2 = T.W5_quat_y;
T_new.AvantiSensor2_ORIENT_Z2 = T.W5_quat_z;

% ---------- Write to new CSV ----------
writetable(T_new, outputFile);

disp("Conversion complete! Target CSV saved.");
