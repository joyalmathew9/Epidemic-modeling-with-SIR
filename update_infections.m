function [x_color, sir, x_timer, ti] = update_infections(x_pos, x_color, sir, x_timer, m, r, g, t, ic, measure, tc, ti)
    n = length(x_color);
    lr = sum(x_color=='r');
    red = zeros(2,2,lr); c = 0;

    % Identify infected
    red_idx = 0;
    for i = 1:n
        if x_color(i) == 'r'
            red_idx = red_idx + 1;
            red(:,:,red_idx) = x_pos(:,i) + m*[-1 1; -1 1];
        end
    end

    % Containment measures
    if ic < sum(x_color=='r') && t>200
        if measure == 1, m = 0.3*m; end
        if measure == 2, r = 35; end
        if measure == 3
            psi = 2*pi*rand(1,n);
            x_vel = m*[cos(psi); sin(psi)];
        end
        if tc == 0, tc = t; ti = []; end
    end

    % Update SIR for each agent
    for i = 1:n
        % Susceptible -> Infected
        if x_color(i)=='b'
            contacts = 0;
            for j = 1:lr
                if all(red(:,1,j) < x_pos(:,i) & x_pos(:,i) < red(:,2,j))
                    contacts = contacts + 1;
                end
            end
            if contacts > 0
                x_color(i) = 'r';
                sir = sir + [-1 1 0];
                ti = [ti, t - x_timer(i)];
                x_timer(i) = t;
            end
        end

        % Infected -> Recovered
        if x_color(i)=='r' && t - x_timer(i) > r
            x_color(i) = 'g';
            sir = sir + [0 -1 1];
            x_timer(i) = t;
        end

        % Recovered -> Susceptible
        if x_color(i)=='g' && t - x_timer(i) > g
            x_color(i) = 'b';
            sir = sir + [1 0 -1];
            x_timer(i) = t;
        end
    end
end
