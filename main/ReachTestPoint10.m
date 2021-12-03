%% Reachability analysis of Test #10
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [1.76349139077220e-12,28800,1.57079632679490,1.76349139077220e-12,91200.0000000000,-1.57079632679490,62400.0000000000,-2.47377049887484e-16,3.14159265358979]; % Test point 1;

% Number of test points
m = size(init_dyn,1);
tf = 30;
st = 1; % Initial advisory
%% Simulate all
% delete(gcp('nocreate')); % End previous parallel session
% [~, cores] = evalc('feature(''numcores'')');
uncc = [5000; 200]; % Original (Let's see which cases are the fastest)
% Compute initial set
% [lb,ub] = calc_uncB(init_dyn(1,:)',uncc(1),uncc(2));
% init_set = Box(lb,ub);
% Compute partitions
Npx = 50; % Number of partitions
Npy = 2; % Number of partitions
% small_sets = init_set.partition([1,2],[Np,1]);
small_sets = compute_set_partitions(init_dyn, uncc(1), uncc(2), Npx, Npy);
Np = length(small_sets);
% parpool(cores);
for K = 1 : Np
        IS = small_sets(K);
        t1 = tic;
        output = reach_TestPointsb(IS,@dyns_tp10,st,tf,'approx-star',600,600);
        time = toc(t1);
        save("../data_reach/testpoint10/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
end

% save('../data_reach/testPoints_jat_10.mat','output','-v7.3');
