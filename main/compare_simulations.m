% Compare nnv vs nnenum (one-by-one)
glob_path = "/home/manzand/Documents/Python/dubins_acasxu/sims/";
folders = ["Left Abeam", "Intruder Tail Chase", "Right Gaining", "Left Gaining", "Left Closing",...
    "Right Abeam", "Right Isosceles", "Right Closing", "Ownship Tail Chase", "Head On Collision"];
% folders = ["Intruder Tail Chase", "Right Gaining", "Left Gaining", "Left Closing",...
%     "Right Abeam", "Right Isosceles", "Right Closing", "Ownship Tail Chase", "Head On Collision"];
% Loop over each test case
v_own = [954.6  ; 462.6 ; 100 ; 204.9 ; 362.3; 609.3; 1145.9; 636.2; 497.4; 600];
v_int = [1050 ;   900 ;   200 ; 600   ; 300  ; 750;   1145;   450  ; 60   ; 600];
tc = 1;
dif = cell([10,1000]);
mean_ = zeros([10,1000,3]); % ownship variables only
std_ = zeros([10,1000,3]);
max_ = zeros([10,1000,3]);
for test_case = folders
    test_folder = glob_path + test_case;
    test_fcn = str2func("@dyns_tp" + string(tc));
    % Loop over each simulation
    for i=0:1:999
        sim_path = test_folder + "/" + string(i) + ".mat";
        simN = load(sim_path);
        init_state = simN.states(1,1:6);
        tf = round(simN.states(end,7));
        [x7,x8,x9] = environment(init_state(1:3),init_state(4:6));
        init_State =[init_state, x7, x8, x9]';
        [data,~] = sim_TestPoints(init_State, test_fcn, 0:2:tf, test_case ,v_own(tc), v_int(tc));
%         dc = data(:,1:6);
        dif(tc,i+1) = {simN.states(:,1:3) - data(:,1:3)};
        mean_(tc,i+1,:) = mean(abs(dif{tc,i+1}));
        max_(tc,i+1,:) = max(abs(dif{tc,i+1}));
        std_(tc,i+1,:) = std(abs(dif{tc,i+1}));
    end
    tc = tc + 1;
end
save('Diff_sim.mat','dif','mean_','std_','max_');

%% Process statistics
% First one including cases 2 and 10 
% The next one with both

load('Diff_sim.mat');
mean1 = mean(mean(mean_));
std1 = mean(mean(std_));
max1 = mean(mean(max_));

% Next one only counting 80% of the cases
mean2 = [mean_(1,:,:); mean_(3:9,:,:)];
mean2 = mean(mean(mean2));
std2 = [std_(1,:,:); std_(3:9,:,:)];
std2 = mean(mean(std2));
max2 = [max_(1,:,:); max_(3:9,:,:)];
max2 = mean(mean(max2));
