%% Reachability analysis of Test #1
% clc;clear;close all;
%% --- Setup scenarios ---

init_dyn = [34380,0,0,34365.2056753629,27992.0284905617,-0.429600000000000,27992.0324001038,1.57132484595043,-0.429600000000000]; % Test point 1;

% Number of test points
m = size(init_dyn,1);
tf = 44;
st = 1; % Initial advisory
%% Simulate all
% delete(gcp('nocreate')); % End previous parallel session
% [~, cores] = evalc('feature(''numcores'')');
uncc = [5000; 200]; % Original (Let's see which cases are the fastest)
% Compute initial set
Npx = 50; % Number of partitions
Npy = 2; % Number of partitions
% small_sets = init_set.partition([1,2],[Np,1]);
small_sets = compute_set_partitions(init_dyn, uncc(2), uncc(1), Npy, Npx);
Np = length(small_sets);
% output = struct('data',cell(1,Np),'tT',cell(1,Np));
% parpool(cores);
for K = Np:-1:1
% for K = 1:Np
    try
        IS = small_sets(K);
        t1 = tic;
        output = reach_TestPointsb(IS,@dyns_tp1,st,tf,'approx-star',955,1050);
        time = toc(t1);
        save("../data_reach/testpoint1_rot/jat_" + string(K) + ".mat",'output','IS','time','-v7.3');
    catch
        disp("Partition " +string(K) + " of test case 1 failed")
    end
end