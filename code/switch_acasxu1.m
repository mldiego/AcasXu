%% Define the layers that model the equivalent to the if/switch statement
% We are going to use a new activation function in one of the layers called
% 'dublim', which is similar to 'hardlims', but adding another piecewise
% linearity: 
% if x < 0.0001 && x>-0.0001, return 1, otherwise the output will be 0.


%% Second method

% The inputs to this network is only the previous advisory
% This is another way of converting an index output to a vector output with
% one 1 and four 0

net = feedforwardnet([]);
net.inputs{1}.processFcns = {};
net.outputs{1}.processFcns = {};
net.inputs{1}.size = 1;
net.layers{1}.size = 5;
net.layers{1}.transferFcn = 'dublim';
% view(net)

w = zeros(5,1);
b = zeros(5,1);
b(1) = 0;
b(2) = -0.0262;
b(3) = 0.0262;
b(4) = -0.0524;
b(5) = 0.0524;
w(:,1) = 1;

net.IW{1} = w;
net.b{1} = b;

% save('nn_new/switch_acasxu1_net','net');
% net_to_mat('nn_new/switch_acasxu1_net.mat','nn_new/switch_acasxu1.mat');
