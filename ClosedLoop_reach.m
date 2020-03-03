%% Reachability analysis of the closedLoop system of AcasXu with Dubins model
% There are 2 main components required:
% - Dubins plant x2 (ownship and intruder)
% - AcasXu networks x45 (choose based on t and previous advisory)

ownship = NonLinearODE(3,1,@dubindynamics);
intruder = NonLinearODE(3,1,@dubindynamics);
controller = LoadAcasXu('networks/ACASXU...');