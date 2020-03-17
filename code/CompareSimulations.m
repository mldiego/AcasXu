%% Compare all equivalent simulations
% Current ways
% 1) Switching between NNs like in Simulink
% 2) Using the switch and big network instead of switch statement 

% We will follow the following steps
% 1) Set initial states
% 2) Compute outputs of the plants
% 3) Compute inputs of the NN
% 4) Compute outputs of the NN
% 5) Compute input of the NN and next step Previous advisory

%% Section 1. Load all networks and dynamical models
% Plant dynamics
tr = 0.01; % reachability time step for plant
tc = 0.2; % control period of the plant
outC = [1 0 0; 0 1 0; 0 0 1]; % Output matrix
ownship = NonLinearODE(3,1,@dubindynamics, tr, tc, outC);
intruder = NonLinearODE(3,1,@dubindynamics, tr, tc, outC);
% Controllers (1)
acasxu11 = LoadAcasXu('../networks/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/ACASXU_run2a_5_1_batch_2000.mat');
% Controller (2)
acasxu1 = LoadAcasXu('acasxu1_afterswitch.mat');
neta = load('acasxu1_afterswitch_net.mat');
awnet = neta.net;
netb = load('switch_acasxu1_net.mat');
swnet = netb.net;

%% Section 2. Simulation
% ------ Configure simulations ------
% Constant across simulations
adv_int = 0; % constant input to intruder
u4 = 807; u5 = 807; % constant inputs (NN)
scale_mean = [19791.0910000000,0,0,650,600];
scale_range = [60261,6.28318530718000,6.28318530718000,1100,1200];
norm_mat = 7.7518884020100598*eye(5);
norm_vec =  7.7518884020100598*ones(1,5);
tf = 25; % Final time of simulation
st = 0.2; % Step size
time = 0:st:tf; % Time to simulate

% ------------------ Simulation 1 --------------------

% Setup scenario
own_init = [0; 25000; -pi/2]; % initial state
int_init = [0; 0; pi/2]; % Initial state
adv_own = 0; % Initial advisory
data1 = zeros(length(time)-1, 18); %memory allocation

% Begin simulation
% Plants
for i=1:length(time)-1
    prev_adv = adv_own;
    % 2) Compute outputs of the plants
    [~, yo] = ownship.evaluate([time(i) time(i+1)], own_init, adv_own);
    own_init = yo(end,:)'; % 1) Set initial state for next step
    [~, yi] = intruder.evaluate([time(i) time(i+1)], int_init, adv_int);
    int_init = yi(end,:)'; % 1) Set initial state for next step
    % 3) Compute inputs of NN
    [u1,u2,u3] = environment(own_init,int_init);
    % Normalize inputs
    uNN = [u1 u2 u3 u4 u5] - scale_mean;
    uNN = uNN./scale_range;
    uNN = uNN';
    % 4) Compute outputs of NN controller
    if prev_adv == 0
        yNN = acasxu11.evaluate(uNN);
    elseif prev_adv == deg2rad(1.5)
        yNN = acasxu21.evaluate(uNN);
    elseif prev_adv == deg2rad(-1.5)
        yNN = acasxu31.evaluate(uNN);
    elseif prev_adv == deg2rad(3.0)
        yNN = acasxu41.evaluate(uNN);
    elseif prev_adv == deg2rad(-3.0)
        yNN = acasxu51.evaluate(uNN);
    else
        error('The previous advisory to the ownship is invalid')
    end
    % Normalize outputs (Not necessary, but we'll keep it here to show)
    uP = norm_mat * yNN;
    uP = uP + norm_vec;
    % 5) Compute input to the ownship
    adv_own = argmin_advise(uP);
%     adv_own = argmin_advise(yNN); % Same decision
    data = [own_init' int_init' uNN' prev_adv, adv_own, yNN'];
    data1(i,:) = data; % store data
end

% --------------------- Simulation 2 --------------------

% Setup the scenario
own_init = [0; 25000; -pi/2]; % initial state (1)
int_init = [0; 0; pi/2]; % Initial state
adv_own = 0; % Initial advisory
data2 = zeros(length(time)-1,38); % Memory allocation

% Begin simulation
for i=1:length(time)-1
    prev_adv = adv_own;
    % plants
    [~, yo] = ownship.evaluate([time(i) time(i+1)], own_init, adv_own);
    own_init = yo(end,:)'; 
    [~, yi] = intruder.evaluate([time(i) time(i+1)], int_init, adv_int);
    int_init = yi(end,:)';
    % Compute inputs of NN
    [u1,u2,u3] = environment(own_init,int_init);
    % Normalize inputs
    uNN = [u1 u2 u3 u4 u5] - scale_mean;
    uNN = uNN./scale_range;
    uNN = uNN';
    % NN controller
    % (2) Execute both switch NNs    
    yNNs = swnet([uNN(4); prev_adv]);
    yNN = awnet([uNN;yNNs]); % Same thing, not sure the reason tho
    % yNN = acasxu1.evaluate([yNNs; uNN]); % Not working for some reason
    % Normalize outputs (Do not really need it, the order is the same)
    adv_own = argmin_advise(yNN);
    data = [own_init' int_init' uNN' prev_adv, adv_own, yNN'];
    data2(i,:) = data; % store data
end
