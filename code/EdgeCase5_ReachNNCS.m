%% Run multiple scenarios using NNV reachability analysis
% Execute multiple scenarios in parallel
clc;clear;close all;
% --- Setup scenarios ---
Init_set = create_regions(8000,10000,45,55,100,0.25);
% Number of simulations
m = size(Init_set,2);
%% Simulate all
n_cases = 60;
Experiments = cell(1,n_cases);
timing = cell(1,n_cases);
rng(10);
idsx = randi([1 m],1,n_cases);
init_set = Init_set(idsx);

% 6 cases at a time
t = tic;
parfor i=1:n_cases
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    Experiments{i} = ReachACASXuNNCS(init_set(i),1,2,'approx-star');
    timing{i} = toc(t);
    disp(' ');
end
tT = toc(t);

%% Visualize results
% Colors for plots
pc = ['r', 'b', 'g', 'y', 'c', 'm'];
% Scenario 1
f1 = figure;
hold on;
% Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,4,5,'k')
for i=1:6
    Star.plotBoxes_2D_noFill(Experiments{i}.init_set{1},4,5,pc(i));
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i));
end
grid;
% title('Edge Case 5');
xlabel('X position (ft)');
ylabel('Y position (ft)');
% Scenario 2
f2 = figure;
% Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,4,5,'k')
hold on;
for i=7:12
    Star.plotBoxes_2D_noFill(Experiments{i}.init_set{1},4,5,pc(i-6));
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i-6));
end
grid;
% title('Edge Case 5');
xlabel('X position (ft)');
ylabel('Y position (ft)');
% 
% % Save resutls
% if ~exist('../data_reach','dir')
%     mkdir('../data_reach')
% end
% saveas(f1,'../data_reach/EdgeCase3_pos.png');
% saveas(f2,'../data_reach/EdgeCase3_neg.png');
% save('../data_reach/EdgeCase5','Experiments','timing','init_set');


