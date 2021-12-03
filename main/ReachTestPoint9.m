%% Reachability analysis of Test #9
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [8.53069365937260e-13,13931.6800000000,1.57079632679490,1.02870331128378e-13,45416.0000000000,1.57079632679490,31484.3199999998,1.22282681129676e-15,0];

% Number of test points
m = size(init_dyn,1);
tf = 44;
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
        output = reach_TestPointsb(IS,@dyns_tp9,st,tf,'approx-star',497.56,60);
        time = toc(t1);
        save("../data_reach/testpoint9/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
end

% save('../data_reach/testPoints_jat_9.mat','output','-v7.3');
