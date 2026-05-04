% Batch Xsens_raw_to_angle   

%% ===============================================
%  BATCH: Xsens CSV → Angle → Anybody CSV
% ===============================================

close all;
clc;
clear;

%% PATH (CHANGE THIS)
%parent_folder = "E:\local_git\Cervical_ROM\Dataset\subject_data_24-3-26";

% parent_folder = "E:\local_git\Cervical_ROM\Dataset\subject_data_11-03-26" ; 

parent_folder = "E:\local_git\Cervical_ROM\Dataset\subject_data_17-3-26"  ; 


%parent_folder = "E:\local_git\Cervical_ROM\Dataset\subject_data_26_3-26" ; 

%parent_folder =  "E:\local_git\Cervical_ROM\Dataset\subject_data_27-3-26" ; 

addpath("FunctionsFiles")

%% SETTINGS
chosen_plane = 'Sagital';
segments = {'zyz', 2};

disp('Sagittal plane selected.');

%% GET ALL FILES
files = dir(fullfile(parent_folder, "xsens_*.csv"));

%% LOOP THROUGH FILES
for i = 1:length(files)

    fileName = files(i).name;
    fullfilename = fullfile(files(i).folder, fileName);

    fprintf("\nProcessing: %s\n", fileName);

    %% ===== STEP 1: EXTRACT ANGLE =====
    movement_angle_segs = cell(1,1);

    movement_angle_segs{1} = ...
        extract_angle(fullfilename, chosen_plane, segments);

    angle_deg = movement_angle_segs{1};

    %% ===== STEP 2: TIME VECTOR =====
    N = length(angle_deg);
    dt = 0.01;
    time = (0:N-1)' * dt;

    %% ===== STEP 3: DEG → RAD =====
    angle_rad = deg2rad(angle_deg);

    %% ===== STEP 4: PARSE NAME =====
    % xsens_mithiran_3.csv → mithiran, 3
    parts = split(erase(fileName, ".csv"), "_");

    if length(parts) < 3
        warning("Skipping malformed file: %s", fileName);
        continue;
    end

    subject = parts{2};
    trial = parts{3};

    %% ===== STEP 5: CREATE OUTPUT FOLDER =====
    processed_root = fullfile(parent_folder, ...
        "processed_" + erase(string(parent_folder), extractBefore(parent_folder, strlength(parent_folder)-0)));

    % cleaner version:
    parent_name = string(split(parent_folder, filesep));
    parent_name = parent_name(end);

    processed_root = fullfile(parent_folder, "processed_" + parent_name);

    subject_folder = fullfile(processed_root, subject);
    trial_folder = fullfile(subject_folder, subject + "_" + trial);

    if ~exist(trial_folder, 'dir')
        mkdir(trial_folder);
    end

    %% ===== STEP 6: SAVE CSV =====
    output_csv = fullfile(trial_folder, subject + "_" + trial + "_Anybody.csv");

    anybody_table = table(time, angle_rad, ...
        'VariableNames', {'Time_sec', 'Angle_rad'});

    writetable(anybody_table, output_csv);

    fprintf("Saved: %s\n", output_csv);

end

disp("🎃 Batch processing complete!");