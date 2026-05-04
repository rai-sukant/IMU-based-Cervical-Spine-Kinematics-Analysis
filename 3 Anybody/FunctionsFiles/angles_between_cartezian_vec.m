%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function a_b_angles = angles_between_cartezian_vec(vector_a, vector_b)
    % Input: vector_a and vector_b matrices (each row is a Cartesian vector [x, y, z])
    % Output: a_b_angles column vector (angle in degrees between corresponding vectors, 0 to 360)

    dot_products = sum(vector_a .* vector_b, 2);
    magnitudes_a = sqrt(sum(vector_a.^2, 2));
    magnitudes_b = sqrt(sum(vector_b.^2, 2));

    cos_angles = dot_products ./ (magnitudes_a .* magnitudes_b);
    cos_angles = max(-1, min(1, cos_angles)); 

    a_b_angles = rad2deg(acos(cos_angles));
end

