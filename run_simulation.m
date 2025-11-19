%% Main script to run the SIR simulations
% Description: SIR model simulation with containment measures

clear; close all;

% Parameters
nloops = 30;          % Number of simulations
t00 = 1500;           % Total simulation time
measures = 0:3;       % Containment measures: 0=none,1=distancing,2=testing,3=travel restriction

% Folders
if ~exist('data','dir'); mkdir('data'); end
if ~exist('figures','dir'); mkdir('figures'); end

% Loop over simulations
for loop = 1:nloops
    % Initialize agents
    [x_pos, x_vel, x_color, x_timer, sir_init] = initialize_agents();
    
    % Loop over measures
    for measure = measures
        [tsir, data] = run_measure_simulation(x_pos, x_vel, x_color, x_timer, sir_init, measure, t00);
        save_results(tsir, data, measure, loop);
    end
end
