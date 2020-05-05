%% Run multiple scenarios using NNV reachability analysis
% Execute multiple scenarios in parallel
clc;clear;close all;
% --- Setup scenarios ---
% ----- Scenarios 1 -----
lb1 = [0; 0; pi/2; 0; 25000; -pi/2; 24997; 0; pi];
up1 = [3; 0; pi/2; 0; 25000; -pi/2; 25000; 0; pi];
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 25000; -pi/2; 25000; 0; pi];
up2 = [0; 0; pi/2; 0; 25000; -pi/2; 25003; 0; pi];
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 25000; -pi/2; 25003; 0; pi];
up3 = [-3; 0; pi/2; 0; 25000; -pi/2; 25006; 0; pi];
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 25000; -pi/2; 24994; 0; pi];
up4 = [6; 0; pi/2; 0; 25000; -pi/2; 24997; 0; pi];
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 25000; -pi/2; 25006; 0; pi];
up5 = [9; 0; pi/2; 0; 25000; -pi/2; 25009; 0; pi];
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 25000; -pi/2; 24991; 0; pi];
up6 = [-6; 0; pi/2; 0; 25000; -pi/2; 24994; 0; pi];
init_set6 = Star(lb6,up6);
% All initial sets scenario 1
Init_Set1 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 2 -----
lb1 = [0; 0; pi/2; 0; 15000; -pi/2; 14997; 0; pi];
up1 = [3; 0; pi/2; 0; 15000; -pi/2; 15000; 0; pi];
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 15000; -pi/2; 15000; 0; pi];
up2 = [0; 0; pi/2; 0; 15000; -pi/2; 15003; 0; pi];
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 15000; -pi/2; 15003; 0; pi];
up3 = [-3; 0; pi/2; 0; 15000; -pi/2; 15006; 0; pi];
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 15000; -pi/2; 14994; 0; pi];
up4 = [6; 0; pi/2; 0; 15000; -pi/2; 14997; 0; pi];
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 15000; -pi/2; 15006; 0; pi];
up5 = [9; 0; pi/2; 0; 15000; -pi/2; 15009; 0; pi];
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 15000; -pi/2; 14991; 0; pi];
up6 = [-6; 0; pi/2; 0; 15000; -pi/2; 14994; 0; pi];
init_set6 = Star(lb6,up6);
% All initial sets scenario 2
Init_Set2 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 3 ------
lb1 = [0; 0; pi/2; 0; 10000; -pi/2; 9997; 0; pi];
up1 = [3; 0; pi/2; 0; 10000; -pi/2; 10000; 0; pi];
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 10000; -pi/2; 10000; 0; pi];
up2 = [0; 0; pi/2; 0; 10000; -pi/2; 10003; 0; pi];
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 10000; -pi/2; 10003; 0; pi];
up3 = [-3; 0; pi/2; 0; 10000; -pi/2; 10006; 0; pi];
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 10000; -pi/2; 9994; 0; pi];
up4 = [6; 0; pi/2; 0; 10000; -pi/2; 9997; 0; pi];
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 10000; -pi/2; 10006; 0; pi];
up5 = [9; 0; pi/2; 0; 10000; -pi/2; 10009; 0; pi];
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 10000; -pi/2; 9991; 0; pi];
up6 = [-6; 0; pi/2; 0; 10000; -pi/2; 9994; 0; pi];
init_set6 = Star(lb6,up6);
% All initial sets scenario 3
Init_Set3 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenario 4
lb1 = [0; 0; pi/2; 0; 5000; -pi/2; 4997; 0; pi];
up1 = [3; 0; pi/2; 0; 5000; -pi/2; 5000; 0; pi];
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 5000; -pi/2; 5000; 0; pi];
up2 = [0; 0; pi/2; 0; 5000; -pi/2; 5003; 0; pi];
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 5000; -pi/2; 5003; 0; pi];
up3 = [-3; 0; pi/2; 0; 5000; -pi/2; 5006; 0; pi];
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 5000; -pi/2; 4994; 0; pi];
up4 = [6; 0; pi/2; 0; 5000; -pi/2; 4997; 0; pi];
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 5000; -pi/2; 5006; 0; pi];
up5 = [9; 0; pi/2; 0; 5000; -pi/2; 5009; 0; pi];
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 5000; -pi/2; 4991; 0; pi];
up6 = [-6; 0; pi/2; 0; 5000; -pi/2; 4994; 0; pi];
init_set6 = Star(lb6,up6);
% All initial sets scenario 4
Init_Set4 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% Number of simulations
init_set = [Init_Set1 Init_Set2 Init_Set3 Init_Set4];
m = size(init_set,2);
%% Simulate all
Sets = cell(1,m);
timing = cell(1,m);

% 6 scases at a time
parfor i=19:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    Sets{i} = ReachACASXuNNCS(init_set(i),1,3,'approx-star');
    timing{i} = toc(t);
    disp(' ');
end

%% Visualize results
pc = ['r', 'b', 'g', 'y', 'c', 'm'];
figure;
Star.plotBoxes_2D_noFill(Sets{6},4,5,'k')
for i=1:6
    Star.plotBoxes_2D_noFill(Sets{i},1,2,pc(i));
end

figure;
Star.plotBoxes_2D_noFill(Sets{7},4,5,'k')
for i=7:12
    Star.plotBoxes_2D_noFill(Sets{i},1,2,pc(i-6));
end

save('../data_reach/StanSets');