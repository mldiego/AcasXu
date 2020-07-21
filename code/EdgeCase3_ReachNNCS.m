%% Run multiple scenarios using NNV reachability analysis
% Execute multiple scenarios in parallel
clc;clear;close all;
% --- Setup scenarios ---
% ----- Scenarios 1 -----
lb1 = [0; 0; 0; 12507; 5917; -pi; 14000; 0.436; pi];
up1 = [0; 0; 0; 14500; 7189; -pi; 16000; 0.466; pi];
init_set1 = Star(lb1,up1);
lb2 = [0; 0; 0; 12326; 6290; -pi; 14000; 0.466; pi];
up2 = [0; 0; 0; 14293; 7586; -pi; 16000; 0.494; pi];
init_set2 = Star(lb2,up2);
lb3 = [0; 0; 0; 12122; 6640; -pi; 14000; 0.494; pi];
up3 = [0; 0; 0; 14087; 8005; -pi; 16000; 0.524; pi];
init_set3 = Star(lb3,up3);
lb4 = [0; 0; 0; 11915; 7005; -pi; 14000; 0.524; pi];
up4 = [0; 0; 0; 13855; 8405; -pi; 16000; 0.553; pi];
init_set4 = Star(lb4,up4);
lb5 = [0; 0; 0; 11703; 7355; -pi; 14000; 0.553; pi];
up5 = [0; 0; 0; 13615; 8782; -pi; 16000; 0.581; pi];
init_set5 = Star(lb5,up5);
lb6 = [0; 0; 0; 11467; 7685; -pi; 14000; 0.581; pi];
up6 = [0; 0; 0; 13375; 9179; -pi; 16000; 0.611; pi];
init_set6 = Star(lb6,up6);
% All initial sets scenario 1
Init_Set1 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 1 -----
lb1 = [0; 0; 0; 12507; -5917; -pi; 14000; -0.436; pi];
up1 = [0; 0; 0; 14500; -7189; -pi; 16000; -0.466; pi];
init_set1 = Star(lb1,up1);
lb2 = [0; 0; 0; 12326; -6290; -pi; 14000; -0.466; pi];
up2 = [0; 0; 0; 14293; -7586; -pi; 16000; -0.494; pi];
init_set2 = Star(lb2,up2);
lb3 = [0; 0; 0; 12122; -6640; -pi; 14000; -0.494; pi];
up3 = [0; 0; 0; 14087; -8005; -pi; 16000; -0.524; pi];
init_set3 = Star(lb3,up3);
lb4 = [0; 0; 0; 11915; -7005; -pi; 14000; -0.524; pi];
up4 = [0; 0; 0; 13855; -8405; -pi; 16000; -0.553; pi];
init_set4 = Star(lb4,up4);
lb5 = [0; 0; 0; 11703; -7355; -pi; 14000; -0.553; pi];
up5 = [0; 0; 0; 13615; -8782; -pi; 16000; -0.581; pi];
init_set5 = Star(lb5,up5);
lb6 = [0; 0; 0; 11467; -7685; -pi; 14000; -0.581; pi];
up6 = [0; 0; 0; 13375; -9179; -pi; 16000; -0.611; pi];
init_set6 = Star(lb6,up6);
% All initial sets scenario 1
Init_Set2 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

init_set = [Init_Set1 Init_Set2];
% Number of simulations
m = size(init_set,2);
%% Simulate all
% Experiments = cell(1,m);
% timing = cell(1,m);

% 6 cases at a time
parfor i=7:m
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
hold on;
% Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,4,5,'k')
for i=1:1
    Star.plotBoxes_2D_noFill(Experiments{i}.init_set{1},4,5,pc(i));
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i));
end
grid;
title('Edge Case 3');
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
title('Edge Case 3');
xlabel('X position (ft)');
ylabel('Y position (ft)');

% Save resutls
if ~exist('../data_reach','dir')
    mkdir('../data_reach')
end
saveas(f1,'../data_reach/EdgeCase3_pos.png');
saveas(f2,'../data_reach/EdgeCase3_neg.png');
save('../data_reach/EdgeCase3','Experiments','timing','init_set');


