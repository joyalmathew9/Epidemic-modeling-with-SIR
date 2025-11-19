function save_results(tsir, data, measure, loop)
    % Save Excel
    writematrix(data, sprintf('data/SIR_data_m%d.xls', measure), 'WriteMode','append');

    % Save Figure
    figure('visible','off');
    plot(tsir(2:4,:)'); 
    title(sprintf('Measure %d, Simulation %d', measure, loop));
    saveas(gcf, sprintf('figures/SIR_fig_m%d_s%d.pdf', measure, loop));
    close(gcf);
end
