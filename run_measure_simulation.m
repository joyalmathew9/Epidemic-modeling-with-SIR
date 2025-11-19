function [tsir, data] = run_measure_simulation(x_pos, x_vel, x_color, x_timer, sir_init, measure, t00)
    % Run simulation for one containment measure
    r = 90; g = 70; u = 0.4; w = 0.025;
    ic = 50; tcmin = 200; m = w; 
    v = @(t) u; % velocity

    n = sum(sir_init);
    sir = sir_init;
    tsir = [0; sir'];
    tc = 0; ti = []; ts = t00;

    for t = 1:t00
        % Update positions
        x_pos = update_positions(x_pos, x_vel, v(t), w);

        % Update SIR states
        [x_color, sir, x_timer, ti] = update_infections(x_pos, x_color, sir, x_timer, m, r, g, t, ic, measure, tc, ti);

        % Record
        if sir(2) == 0 && ts == t00
            ts = t;
        end
        tsir = [tsir, [t; sir']];
    end

    % Summary data
    tim = mean(ti);
    sm = mean(tsir(2,tc+1:end));
    im = mean(tsir(3,tc+1:end));
    data = [measure, tc, ts, tim, sm, im];
end
