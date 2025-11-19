function x_pos = update_positions(x_pos, x_vel, v_t, w)
    % Update positions and reflect at boundaries
    x_pos = x_pos + v_t*x_vel;

    % Boundary reflection
    for i = 1:size(x_pos,2)
        for j = 1:2
            if x_pos(j,i) < w || x_pos(j,i) > 1-w
                x_vel(j,i) = -x_vel(j,i);
            end
        end
    end
end
