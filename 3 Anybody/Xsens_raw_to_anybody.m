%% Xsens_raw_to_anybody
% 
% Xsens_raw_to_angle + to_anybody

% This script uses the .csv file exported from the Xsens DOT sensors
% containing quaternion data from 2 sensors:
% W4 (neck) & W5 (back of head)
% 
% It computes range of motion between the two sensors and exports in .csv
% file in raidinas 


%% Xsens CSV → Angle → Anybody (radians) CSV

close all;
clc;
clear;

%% Sampling frequency
% Fs = 60; % Hz

%% Paths
data_path = "E:\local_git\Cervical_range_of_motion";
addpath("FunctionsFiles")

%% Select file
[fileName, filePath] = uigetfile(fullfile(data_path,"*.csv"), ...
    "Select Xsens CSV file");

fullfilename = fullfile(filePath, fileName);

%% ===== STEP 1: READ XSENS CSV =====
T = readtable(fullfilename);

%% ===== STEP 2: EXTRACT ANGLE =====
chosen_plane = 'Sagital';
disp('Sagittal plane selected.');

segments = {'zyz', 2};
nsegments = size(segments,1);

movement_angle_segs = cell(nsegments,1);

for iseg = 1:nsegments
    seg = segments(iseg,:);
    movement_angle_segs{iseg,1} = ...
        extract_angle(fullfilename, chosen_plane, seg);
end

% Assume single segment (your case)
angle_deg = movement_angle_segs{1};

%% ===== STEP 3: CREATE TIME VECTOR =====
N = length(angle_deg);
dt = 0.01;
time = (0:N-1)' * dt;


%% ===== STEP 4: CONVERT DEG → RAD =====
angle_rad = deg2rad(angle_deg);

%% ===== STEP 5: PLOT (optional but useful) =====
figure;
plot(time, angle_deg, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Time [s]')
ylabel('Angle [deg]')
title('Sagittal Plane – Angle vs Time')

%% ===== STEP 6: SAVE ANYBODY-FRIENDLY CSV =====
[fileBase,~,~] = fileparts(fileName);

output_csv = fullfile(filePath, fileBase + "_Anybody.csv");

anybody_table = table(time, angle_rad, ...
    'VariableNames', {'Time_sec', 'Angle_rad'});

writetable(anybody_table, output_csv);

disp("Anybody-ready file saved to:");
disp(output_csv);