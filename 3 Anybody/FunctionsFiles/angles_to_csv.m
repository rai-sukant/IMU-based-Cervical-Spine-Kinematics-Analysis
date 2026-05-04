%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function angles_to_csv(mean_angle_prepost, fullfilename, results_path)
num_movements = size(mean_angle_prepost, 1);
row_labels = cell(num_movements, 1);
for i = 1:num_movements
    row_labels{i} = ['movement' num2str(i)];
end

[~, filename, ~] = fileparts(fullfilename);
results_filename = replace(filename, {'_Pre', '_pre'}, '_pre-post');

if size(mean_angle_prepost,2)==2
    cloumns_labels = {'PRE-angle_to_baseline[deg]','POST-angle_to_baseline[deg]'};
else
    cloumns_labels = {'angle_to_baseline[deg]'};
end

T = array2table(mean_angle_prepost, 'RowNames', row_labels, 'VariableNames', cloumns_labels);
disp(T)

writetable(T, fullfile(results_path,results_filename)+"_angle-to-baseline.csv")

msgbox(["Angle of each movement to baseline saved to CSV file."]);