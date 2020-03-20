%% Reachability analysis of the closedLoop system of AcasXu with Dubins model
% There are 2 main components required:
% - Dubins plant x2 (ownship and intruder)
% - AcasXu networks x5 (choose based on t=0 and previous advisory)

% Plant dynamics
ownship = NonLinearODE(3,1,@dubindynamics);
intruder = NonLinearODE(3,1,@dubindynamics);
% Controllers
acasxu11 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_5_1_batch_2000.mat');



