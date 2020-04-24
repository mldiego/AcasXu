%% Run multiple scenarios using NNV reachability analysis
% Goal is to test the time to run each reachability step based on the same
% initial state set
clc;clear;close all;
% --- Setup scenarios ---
% lb1 = [10000; 5234; 0.2; 10030; 3450; 0.7; 17783; -1.7540; 0.4900];
% up1 = [10006; 5240; 0.21; 10036; 3456; 0.71; 17902; -1.7674; 0.5100];
% init_set1 = Star(lb1,up1);
lb2 = [10000; 5234; 0.2; 10030; 3450; 0.7; 17783; -1.7540; 0.5];
up2 = [10006; 5240; 0.2; 10036; 3456; 0.7; 17902; -1.7574; 0.5];
init_set = Star(lb2,up2);
% Number of simulations
% init_set = [init_set1 init_set2];
% m = size(init_set,1);
%% Simulate all
tf = [0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8];
m = length(tf);
% AllTestSets = cell(4,m);
% for i=1:m
%     disp('     Scenario ' + string(i));
%     disp('-------------------------');
%     t = tic;
%     AllTestSets{1,i} = SetSimulationNNCS(init_set,1,tf(i),'exact-star');
%     AllTestSets{2,i} = toc(t);
%     t = tic;
%     AllTestSets{3,i} = SetSimulationNNCS(init_set,1,tf(i),'approx-star');
%     AllTestSets{4,i} = toc(t);
%     disp(' ');
% end
ExactSets = cell(1,m);
parfor i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    ExactSets{i} = SetSimulationNNCS(init_set,1,tf(i),'exact-star');
    ExactTimes{i} = toc(t);
    t = tic;
    ApproxSets{i} = SetSimulationNNCS(init_set,1,tf(i),'approx-star');
    ApproxTimes{i} = toc(t);
    disp(' ');
end
