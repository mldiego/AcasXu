%% Run multiple scenarios using NNV reachability analysis
% Execute multiple scenarios in parallel
clc;clear;close all;
% --- Setup scenarios ---
% ----- Scenarios 1 -----
lb1 = [0; 0; 0; 22658; 6470; -pi; 24000; 0.262; pi];
up1 = [0; 0; 0; 24148; 10565; -pi; 26000; 0.426; pi];
init_set1 = Star(lb1,up1);
lb2 = [0; 0; 0; 22658; -6470; -pi; 24000; -0.262; pi];
up2 = [0; 0; 0; 24148; -10565; -pi; 26000; -0.426; pi];
init_set2 = Star(lb2,up2);
% All initial sets scenario 1
init_set = [init_set1 init_set2];

% Number of simulations
m = size(init_set,2);
%% Simulate all
Experiments = cell(1,m);
timing = cell(1,m);

% 6 cases at a time
parfor i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    Experiments{i} = ReachACASXuNNCS(init_set(i),1,1,'approx-star');
    timing{i} = toc(t);
    disp(' ');
end

%% Visualize results
% Colors for plots
pc = ['r', 'b', 'g', 'y', 'c', 'm'];
% Scenario 1
f1 = figure;
Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,4,5,'k')
hold on;
Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,1,2,pc(1));
grid;
% title('Edge Case 2');
xlabel('X position (ft)');
ylabel('Y position (ft)');
% Scenario 2
f2 = figure;
Star.plotBoxes_2D_noFill(Experiments{2}.int_reachSet,4,5,'k')
hold on;
Star.plotBoxes_2D_noFill(Experiments{2}.int_reachSet,1,2,pc(2));
grid;
% title('ACAS Xu aircraft set trajectories');
xlabel('X position (ft)');
ylabel('Y position (ft)');

% % Save resutls
% if ~exist('../data_reach','dir')
%     mkdir('../data_reach')
% end
% saveas(f1,'../data_reach/EdgeCase2_pos.png');
% saveas(f2,'../data_reach/EdgeCase2_neg.png');
% save('../data_reach/EdgeCase2','Experiments','timing','init_set');


