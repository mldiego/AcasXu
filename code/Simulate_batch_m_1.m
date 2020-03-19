%% Simulate multiple scenarios for AcasXu closedloop
clc;clear;
% Export data from Simulink to workspace
% https://www.mathworks.com/help/simulink/ug/export-simulation-data-1.html

% Check for folder to store simulation data
if ~exist('../data_sim/m_1','dir')
    mkdir('data_sim/m_1')
end

% % This scenario may return an error for consecutive zero-crossings
% % Zero-crossing detection has been disabled to prevent this
% x1_i = -3928; x2_i = -16962; x3_i = -1.633926469911444; 
% x1_o = -10404; x2_o = -15068; x3_o = -1.986065940377818;
% % Run simulation
% sim('../simulation/AcasXuClosedLoop_m_1_batch_2017b.mdl');
% pause;

% Initial scenario
x1_i = 0; x2_i = 25000; x3_i = -pi/2; 
x1_o = 0; x2_o = 0; x3_o = pi/2;

% Run simulation
sim('../simulation/AcasXuClosedLoop_m_1_batch.mdl');
% Plot results
figure('units', 'normalized','visible','off');
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
pause(0.5);
axis equal
saveas(gcf,['../data_sim/m_1/exp' int2str(1)],'png');
% Save simulation info
save(['../data_sim/m_1/exp' int2str(1)]);

% Scenario 2
x1_i = 0; x2_i = 25000; x3_i = -pi/2; 
x1_o = 25000; x2_o = 0; x3_o = pi;

% Run simulation
sim('../simulation/AcasXuClosedLoop_m_1_batch.mdl');
% Plot results
figure('units', 'normalized','visible','off');
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
pause(0.5);
axis equal
saveas(gcf,['../data_sim/m_1/exp' int2str(1)],'png');
% Save simulation info
save(['../data_sim/m_1/exp' int2str(1)]);

rng = 23; % Set random seed
% Run batch of experiments
for i=3:200
    disp('Simulating experiment '+string(i));
    % Randomly initialize state variables of intruder and ownship
    x1_i = randi([-20000,20000]);
    x2_i = randi([-20000,20000]);
    x1_o = randi([-20000,20000]);
    x2_o = randi([-20000,20000]);
    x3_o = rand*2*pi-pi;
    x3_i = rand*2*pi-pi;
    % Run simulation
    sim('../simulation/AcasXuClosedLoop_m_1_batch.mdl');
    %Plot results
    figure('units', 'normalized','visible','off'); % Uncomment to see plot 
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
    pause(1);
    axis equal
    % Save figure
    saveas(gcf,['../data_sim/m_1/exp' int2str(i)],'png');
    % Save simulation info
    save(['../data_sim/m_1/exp' int2str(i)]);
end