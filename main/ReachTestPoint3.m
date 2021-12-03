%% Reachability analysis of Test #1
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [1.22464679914738e-12,20000,1.57079632679490,16771.4100770869,6485.86421596979,1.93249632679490,21538.6492914250,-2.24905401248807,0.361700000000000]; % Test point 3

% Number of test points
m = size(init_dyn,1);
tf = 130;
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
        output = reach_TestPointsb(IS,@dyns_tp3,st,tf,'approx-star',100,200);
        time = toc(t1);
        save("../data_reach/testpoint3/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
end

% save('../data_reach/testPoints_jat_3.mat','output','-v7.3');
