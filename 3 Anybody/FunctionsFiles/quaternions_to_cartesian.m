%% This software is for non-commercial use only.
%% Commercial use requires a separate license.

function cartesian_vectors = quaternions_to_cartesian(quaternions, seq)
    % Input: quaternions matrix (each row is a quaternion [w, x, y, z]), seq ('xyz', 'zyx', 'zyz')
    % Output: cartesian_vectors matrix (each row is a Cartesian vector [x, y, z])

    num_quaternions = size(quaternions, 1);
    cartesian_vectors = zeros(num_quaternions, 3);

    w = quaternions(:, 1);
    x = quaternions(:, 2);
    y = quaternions(:, 3);
    z = quaternions(:, 4);

    switch seq
        case 'xyz'
            cartesian_vectors(:, 1) = w.^2 + x.^2 - y.^2 - z.^2;
            cartesian_vectors(:, 2) = 2 * (x .* y + w .* z);
            cartesian_vectors(:, 3) = 2 * (x .* z - w .* y);
        case 'zyx'
            cartesian_vectors(:, 1) = 2 * (x .* y - w .* z);
            cartesian_vectors(:, 2) = 2 * (x .* z + w .* y);
            cartesian_vectors(:, 3) = w.^2 - x.^2 - y.^2 + z.^2;
        case 'zyz'
            cartesian_vectors(:, 1) = 2 * (w .* y + x .* z);
            cartesian_vectors(:, 2) = 2 * (w .* z - x .* y);
            cartesian_vectors(:, 3) = w.^2 - x.^2 - y.^2 - z.^2;
        otherwise
            error('Invalid rotation sequence. Use ''xyz'', ''zyx'', or ''zyz''.');
    end
end
