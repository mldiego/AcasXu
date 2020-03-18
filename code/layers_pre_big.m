%% Define the layers that model the equivalent to the if/switch statement
% We are going to use a new activation function in one of the layers called
% 'dublim', which is the same as 'hardlims', but adding another piecewise
% linearity: if x > 1, the output will be 0 as well.

% % Create the network structure
% net = feedforwardnet([10]);
% % m = length(net.layers);
% net.inputs{1}.processFcns = {};
% net.outputs{2}.processFcns = {};
% net.inputs{1}.size = 6;
% net.layers{2}.size = 25;
% net.layers{1}.transferFcn = 'purelin';
% % net.layers{2}.transferFcn = 'purelin';
% net.layers{2}.transferFcn = 'dublim';
% 
% % If we want to send the command as {1,2,3,4,5}, use this first assignment,
% % if we send the previous advisory as {0, 0.15, -0.15, 0.3, -0.3}, comment it
% % out and use the following one.
% % The first has been tested and works.
% 
% % % ASSIGN 1. Assign values to weights and bias in each layer
% % % Input 6: Previous adv: {1,2,3,4,5}
% % w1 = zeros(10,6);
% % b1 = zeros(10,1);
% % w2 = zeros(25,10);
% % b2 = zeros(25,1);
% % % w3 = zeros(25,25);
% % % b3 = -20*ones(25,1);
% % 
% % % Layer 1
% % w1(1:5,1:5) = eye(5);
% % w1(1,6) = 20;
% % w1(2,6) = 20;
% % w1(3,6) = 20;
% % w1(4,6) = 20;
% % w1(5,6) = 20;
% % w1(6:10,1:5) = eye(5);
% % 
% % % Layer 2
% % w2(1:5,1:5)= eye(5);
% % w2(6:10,1:5) = eye(5);
% % w2(11:15,1:5) = eye(5);
% % w2(16:20,1:5) = eye(5);
% % w2(21:25,1:5) = eye(5);
% % % w2(26:30,6:10) = eye(5);
% % w2(1:5,6:10) = -20*eye(5);
% % w2(6:10,6:10) = -40*eye(5);
% % w2(11:15,6:10) = -60*eye(5);
% % w2(16:20,6:10) = -80*eye(5);
% % w2(21:25,6:10) = -100*eye(5);
% 
% 
% % ASSIGN 2. Assign values to weights and bias in each layer
% % Input 6: Previous adv: {0,0.15,-0.15,0.3,-0.3}
% w1 = zeros(10,6);
% b1 = zeros(10,1);
% w2 = zeros(25,10);
% b2 = zeros(25,1);
% % w3 = zeros(25,25);
% % b3 = -20*ones(25,1);
% 
% % Layer 1
% w1(1:5,1:5) = eye(5);
% w1(1,6) = 200;
% w1(2,6) = 200;
% w1(3,6) = 200;
% w1(4,6) = 200;
% w1(5,6) = 200;
% w1(6:10,1:5) = eye(5);
% 
% % Layer 2
% w2(1:5,1:5)= eye(5);
% w2(6:10,1:5) = eye(5);
% w2(11:15,1:5) = eye(5);
% w2(16:20,1:5) = eye(5);
% w2(21:25,1:5) = eye(5);
% % w2(26:30,6:10) = eye(5);
% w2(1:5,6:10) = 0*eye(5);
% w2(6:10,6:10) = -5.24*eye(5);
% w2(11:15,6:10) = 5.2*eye(5);
% w2(16:20,6:10) = -10.48*eye(5);
% w2(21:25,6:10) = 10.4*eye(5);
% 
% 
% % Set NN 
% net.IW{1} = w1;
% net.b{1} = b1;
% net.LW{2,1} = w2;
% net.b{2} = b2;

% This does not always work, so I will look into a different method

%% Second method

% The inputs to this network will be v_own and previous advisory

net = feedforwardnet([]);
net.inputs{1}.processFcns = {};
net.outputs{1}.processFcns = {};
net.inputs{1}.size = 2;
net.layers{1}.size = 5;
net.layers{1}.transferFcn = 'dublim';
% view(net)

w = zeros(5,2);
b = zeros(5,1);
b(1) = -0.1;
b(2) = -0.4;
b(3) = 0.2;
b(4) = -0.6;
b(5) = 0.4;
w(:,1) = 1;
w(:,2) = 10;

net.IW{1} = w;
net.b{1} = b;

save('nn_new/switch_acasxu1_net','net');
net_to_mat('nn_new/switch_acasxu1_net.mat','nn_new/switch_acasxu1.mat');

% This works (had to change the the dublim function to 
% x in (-0.1,0.1), return 1, else 0.