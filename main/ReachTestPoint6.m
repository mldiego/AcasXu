%% Reachability analysis of Test #6
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [6.71228910612664e-13,10962.0000000000,1.57079632679490,35863.4847437225,10966.9277165339,2.19339632679490,35863.4850822618,-1.57065892473991,0.622600000000000]; % Test point 1;

% Number of test points
m = size(init_dyn,1);
tf = 50;
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
        output = reach_TestPointsb(IS,@dyns_tp6,st,tf,'approx-star',609,750);
        time = toc(t1);
        save("../data_reach/testpoint6/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
end

% save('../data_reach/testPoints_jat_6.mat','output','-v7.3');
