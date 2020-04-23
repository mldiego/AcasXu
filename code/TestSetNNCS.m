%% Run multiple scenarios using NNV reachability analysis
clc;clear;close all;
% --- Setup scenarios ---
lb1 = [10000; 5234; 0.2; 10030; 3450; 0.7; 17783; -1.7540; 0.4900];
up1 = [10006; 5240; 0.21; 10036; 3456; 0.71; 17902; -1.7674; 0.5100];
init_set1 = Star(lb1,up1);
% Number of simulations
init_set = init_set1;
m = size(init_set,1);
%% Simulate all
AllSets = cell(1,m);
timing = cell(1,m);
for i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    AllSets{i} = SetSimulationNNCS(init_set(i),1,2);
    timing{i} = toc(t);
    disp(' ');
end