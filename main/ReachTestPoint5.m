%% Reachability analysis of Test #5
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [7.32006906607536e-12,119545.800000003,1.57079632679490,-7595.43288953584,127137.665811920,1.33289632679490,10739.0735659618,0.785627712887557,-0.237900000000000];

% Number of test points
m = size(init_dyn,1);
tf = 42;
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
% output = struct('data',cell(1,Np),'tT',cell(1,Np));
% parpool(cores);
for K = 1 : Np
        IS = small_sets(K);
        t1 = tic;
        output = reach_TestPointsb(IS,@dyns_tp5,st,tf,'approx-star',362.26,300);
        time = toc(t1);
        save("../data_reach/testpoint5/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
end

% save('../data_reach/testPoints_jat_5.mat','output','-v7.3');
