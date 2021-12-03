%% Reachability analysis of Test #4
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [7.52276035780236e-14,1228.56000000000,1.57079632679490,-29070.4808871567,-27841.0285541235,1.02929632679490,41111.2687354777,2.35617925279970,-0.541500000000000]; % Test point 4

% Number of test points
m = size(init_dyn,1);
tf = 60;
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
for K = 1 : Np % Computer shut down, move forward to next set
        IS = small_sets(K);
        t1 = tic;
        output = reach_TestPointsb(IS,@dyns_tp4,st,tf,'approx-star',204.76,600);
        time = toc(t1);
        save("../data_reach/testpoint4/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
end

% save('../data_reach/testPoints_jat_4.mat','output','-v7.3');
