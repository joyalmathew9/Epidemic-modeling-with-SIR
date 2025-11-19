function [x_pos, x_vel, x_color, x_timer, sir_init] = initialize_agents()
    % Initialize population and SIR states

    sir_init = [99, 1, 0];       % Initial S, I, R
    sir_colors = ['b','r','g'];  % Colors for plotting
    w = 0.025;                   % Mesh size
    n = sum(sir_init);           % Total population

    % Random positions
    x_pos = w + (1-2*w)*rand(2,n);

    % Random velocities
    psi = 2*pi*rand(1,n);
    x_vel = w * [cos(psi); sin(psi)];

    % Assign colors
    x_color = [];
    for j = 1:length(sir_init)
        x_color = [x_color repmat(sir_colors(j),1,sir_init(j))];
    end

    % Timers
    x_timer = zeros(1,n);
end
