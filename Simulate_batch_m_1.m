%% Simulate multiple scenarios for AcasXu closedloop
clc;clear;
% Export data from Simulink to workspace
% https://www.mathworks.com/help/simulink/ug/export-simulation-data-1.html

% Initial scenario
x1_i = 0; x2_i = 25000; x3_i = -pi/2; 
x1_o = 0; x2_o = 0; x3_o = pi/2;

% Run simulation
sim('AcasXuClosedLoop_m_1.mdl');
% Plot results
figure('visible','off');
plot(x_own,y_own,'b');
hold on;
plot(x_int,y_int,'r');
scatter(x1_o,x2_o,'b');
scatter(x1_i,x2_i,'r');
legend('ownship','intruder');
xlabel('X position (ft)');
ylabel('Y position (ft)');
grid;
title('AcasXu Closed-Loop');
saveas(gcf,['data_sim/m_1/exp' int2str(1)],'jpeg');
% Save simulation info
save(['data_sim/m_1/exp' int2str(1)]);

clc;clear;
rng = 23; % Set random seed
% Run batch of experiments
for i=2:100
    disp('Simulating experiment '+string(i));
    % Randomly initialize state variables of intruder and ownship
    x1_i = randi([-20000,20000]);
    x2_i = randi([-20000,20000]);
    x1_o = randi([-20000,20000]);
    x2_o = randi([-20000,20000]);
    x3_o = rand*2*pi-pi;
    x3_i = rand*2*pi-pi;
    % Run simulation
    sim('AcasXuClosedLoop_m_1.mdl');
    %Plot results
    figure;
    % figure('visible','off'); % Uncomment to see plot 
    plot(x_own,y_own,'b');
    hold on;
    plot(x_int,y_int,'r');
    scatter(x1_o,x2_o,'b');
    scatter(x1_i,x2_i,'r');
    legend('ownship','intruder');
    xlabel('X position (ft)');
    ylabel('Y position (ft)');
    grid;
    title('AcasXu Closed-Loop');
    % Save figure
    saveas(gcf,['data_sim/m_1/exp' int2str(i)],'jpeg');
    % Save simulation info
    save(['data_sim/m_1/exp' int2str(i)]);
end