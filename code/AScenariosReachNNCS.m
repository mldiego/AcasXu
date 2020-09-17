%% Run multiple scenarios using NNV reachability analysis
% Execute multiple scenarios in parallel
clc;clear;close all;
% --- Setup scenarios ---
% ----- Scenarios 1 -----
lb1 = [0; 0; 0; 25000; 0; pi; 24997; 0; pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [0; -3; 0; 25000; 0; pi; 25000; 0; pi];
[lb2,up2] = calc_unc(lb2,3);
init_set2 = Star(lb2,up2);
lb3 = [0; -6; 0; 25000; 0; pi; 25003; 0; pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [0; 3; 0; 25000; 0; pi; 24994; 0; pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [0; 6; 0; 25000; 0; pi; 25006; 0; pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [0; -9; 0; 25000; 0; pi; 24991; 0; pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 1
Init_Set1 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 2 -----
lb1 = [0; 0; 0; 15000; 0; pi; 14997; 0; pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [0; -3; 0; 15000; 0; pi; 15000; 0; pi];
[lb2,up2] = calc_unc(lb2,3);
init_set2 = Star(lb2,up2);
lb3 = [0; -6; 0; 15000; 0; pi; 15003; 0; pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [0; 3; 0; 15000; 0; pi; 14994; 0; pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [0; 6; 0; 15000; 0; pi; 15006; 0; pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [0; -9; 0; 15000; 0; pi; 14991; 0; pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 2
Init_Set2 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 3 -----
lb1 = [0; 0; 0; 35000; 0; pi; 34997; 0; pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [0; -3; 0; 35000; 0; pi; 35000; 0; pi];
[lb2,up2] = calc_unc(lb2,3);
init_set2 = Star(lb2,up2);
lb3 = [0; -6; 0; 35000; 0; pi; 35003; 0; pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [0; 3; 0; 35000; 0; pi; 34994; 0; pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [0; 6; 0; 35000; 0; pi; 35006; 0; pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [0; -9; 0; 35000; 0; pi; 34991; 0; pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 2
Init_Set3 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];


% Number of simulations
init_set = [Init_Set1 Init_Set2 Init_Set3];
m = size(init_set,2);
%% Simulate all
Experiments = cell(1,m);
timing = cell(1,m);

% 6 cases at a time
parfor i=1:m 
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    Experiments{i} = ReachACASXuNNCSb(init_set(i),1,2,'approx-star');
    timing{i} = toc(t);
    disp(' ');
end

%% Visualize results
% Colors for plots
pc = ['r', 'b', 'g', 'y', 'c', 'm'];
% Scenarios 1
f1 = figure;
Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,4,5,'k')
for i=1:6
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i));
end
grid;
xlabel('X position (ft)');
ylabel('Y position (ft)');

% Scenarios 2
f2 = figure;
Star.plotBoxes_2D_noFill(Experiments{7}.int_reachSet,4,5,'k')
for i=7:12
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i-6));
end
grid;
xlabel('X position (ft)');
ylabel('Y position (ft)');

% Scenarios 3
f3 = figure;
Star.plotBoxes_2D_noFill(Experiments{13}.int_reachSet,4,5,'k')
for i=13:18
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i-12));
end
grid;
xlabel('X position (ft)');
ylabel('Y position (ft)');

% Save resutls
if ~exist('../data_reach','dir')
    mkdir('../data_reach')
end
saveas(f1,'../data_reach/Asets25000.png');
saveas(f2,'../data_reach/Asets15000.png');
saveas(f3,'../data_reach/Asets35000.png');
save('../data_reach/ASets','Experiments','timing','init_set');


