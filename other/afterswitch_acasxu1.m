%% Create acasxu network from the smaller ones
% By assuming that time (vertical separation) is always 0, we can convert
% the AcasXu system into a single NN

%We will convert the original one by adding 5 neurons to each layer as well
% as having 10 neurons instead of 5

% Controllers
acasxu11 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_5_1_batch_2000.mat');

% Create big net (acasxu_big_1)
net = feedforwardnet([255 255 255 255 255 255 30]);
m = length(net.layers);
net.inputs{1}.processFcns = {};
net.outputs{m}.processFcns = {};
net.inputs{1}.size = 10;
net.layers{m}.size = 25;

% Add activation functions to net layers
for i=1:m-2
    net.layers{i}.transferFcn = 'poslin';
end
net.layers{m-1}.transferFcn = 'purelin';
net.layers{m}.transferFcn = 'purelin';


% -------------- First Layer -------------------
% Weights
net.IW{1} = zeros(255,10);
net.IW{1}(1:50,1:5) = acasxu11.Layers(1).W;
net.IW{1}(51:100,1:5) = acasxu21.Layers(1).W;
net.IW{1}(101:150,1:5) = acasxu31.Layers(1).W;
net.IW{1}(151:200,1:5) = acasxu41.Layers(1).W;
net.IW{1}(201:250,1:5) = acasxu51.Layers(1).W;
net.IW{1}(251:255,6:10) = eye(5);
% Bias
net.b{1} = zeros(255,1);
net.b{1}(1:50) = acasxu11.Layers(1).b;
net.b{1}(51:100) = acasxu21.Layers(1).b;
net.b{1}(101:150) = acasxu31.Layers(1).b;
net.b{1}(151:200) = acasxu41.Layers(1).b;
net.b{1}(201:250) = acasxu51.Layers(1).b;

%---------------- Second layer --------------------
% Weights
net.LW{2,1} = zeros(255,255);
net.LW{2,1}(1:50,1:50) = acasxu11.Layers(2).W;
net.LW{2,1}(51:100,51:100) = acasxu21.Layers(2).W;
net.LW{2,1}(101:150,101:150) = acasxu31.Layers(2).W;
net.LW{2,1}(151:200,151:200) = acasxu41.Layers(2).W;
net.LW{2,1}(201:250,201:250) = acasxu51.Layers(2).W;
net.LW{2,1}(251:255,251:255) = eye(5);
% Bias
net.b{2} = zeros(255,1);
net.b{2}(1:50) = acasxu11.Layers(2).b;
net.b{2}(51:100) = acasxu21.Layers(2).b;
net.b{2}(101:150) = acasxu31.Layers(2).b;
net.b{2}(151:200) = acasxu41.Layers(2).b;
net.b{2}(201:250) = acasxu51.Layers(2).b;

% --------------- Third Layer -------------------
net.LW{3,2} = zeros(255,255);
net.LW{3,2}(1:50,1:50) = acasxu11.Layers(3).W;
net.LW{3,2}(51:100,51:100) = acasxu21.Layers(3).W;
net.LW{3,2}(101:150,101:150) = acasxu31.Layers(3).W;
net.LW{3,2}(151:200,151:200) = acasxu41.Layers(3).W;
net.LW{3,2}(201:250,201:250) = acasxu51.Layers(3).W;
net.LW{3,2}(251:255,251:255) = eye(5);
% Bias
net.b{3} = zeros(255,1);
net.b{3}(1:50) = acasxu11.Layers(3).b;
net.b{3}(51:100) = acasxu21.Layers(3).b;
net.b{3}(101:150) = acasxu31.Layers(3).b;
net.b{3}(151:200) = acasxu41.Layers(3).b;
net.b{3}(201:250) = acasxu51.Layers(3).b;


% -------------- Fourth Layer -------------------
net.LW{4,3} = zeros(255,255);
net.LW{4,3}(1:50,1:50) = acasxu11.Layers(4).W;
net.LW{4,3}(51:100,51:100) = acasxu21.Layers(4).W;
net.LW{4,3}(101:150,101:150) = acasxu31.Layers(4).W;
net.LW{4,3}(151:200,151:200) = acasxu41.Layers(4).W;
net.LW{4,3}(201:250,201:250) = acasxu51.Layers(4).W;
net.LW{4,3}(251:255,251:255) = eye(5);
% Bias
net.b{4} = zeros(255,1);
net.b{4}(1:50) = acasxu11.Layers(4).b;
net.b{4}(51:100) = acasxu21.Layers(4).b;
net.b{4}(101:150) = acasxu31.Layers(4).b;
net.b{4}(151:200) = acasxu41.Layers(4).b;
net.b{4}(201:250) = acasxu51.Layers(4).b;

% --------------- Fifth Layer -------------------
net.LW{5,4} = zeros(255,255);
net.LW{5,4}(1:50,1:50) = acasxu11.Layers(5).W;
net.LW{5,4}(51:100,51:100) = acasxu21.Layers(5).W;
net.LW{5,4}(101:150,101:150) = acasxu31.Layers(5).W;
net.LW{5,4}(151:200,151:200) = acasxu41.Layers(5).W;
net.LW{5,4}(201:250,201:250) = acasxu51.Layers(5).W;
net.LW{5,4}(251:255,251:255) = eye(5);
% Bias
net.b{5} = zeros(255,1);
net.b{5}(1:50) = acasxu11.Layers(5).b;
net.b{5}(51:100) = acasxu21.Layers(5).b;
net.b{5}(101:150) = acasxu31.Layers(5).b;
net.b{5}(151:200) = acasxu41.Layers(5).b;
net.b{5}(201:250) = acasxu51.Layers(5).b;

% ------------ Sixth Layer -------------------
% Weights
net.LW{6,5} = zeros(255,255);
net.LW{6,5}(1:50,1:50) = acasxu11.Layers(6).W;
net.LW{6,5}(51:100,51:100) = acasxu21.Layers(6).W;
net.LW{6,5}(101:150,101:150) = acasxu31.Layers(6).W;
net.LW{6,5}(151:200,151:200) = acasxu41.Layers(6).W;
net.LW{6,5}(201:250,201:250) = acasxu51.Layers(6).W;
net.LW{6,5}(251:255,251:255) = eye(5);
% Bias
net.b{6} = zeros(255,1);
net.b{6}(1:50) = acasxu11.Layers(6).b;
net.b{6}(51:100) = acasxu21.Layers(6).b;
net.b{6}(101:150) = acasxu31.Layers(6).b;
net.b{6}(151:200) = acasxu41.Layers(6).b;
net.b{6}(201:250) = acasxu51.Layers(6).b;

% ---------- Seventh Layer ----------------
% Weights
net.LW{7,6} = zeros(30,255);
net.LW{7,6}(1:5,1:50) = acasxu11.Layers(7).W;
net.LW{7,6}(6:10,51:100) = acasxu21.Layers(7).W;
net.LW{7,6}(11:15,101:150) = acasxu31.Layers(7).W;
net.LW{7,6}(16:20,151:200) = acasxu41.Layers(7).W;
net.LW{7,6}(21:25,201:250) = acasxu51.Layers(7).W;
net.LW{7,6}(26:30,251:255) = eye(5);
% Bias
net.b{7} = zeros(30,1);
net.b{7}(1:5) = acasxu11.Layers(7).b;
net.b{7}(6:10) = acasxu21.Layers(7).b;
net.b{7}(11:15) = acasxu31.Layers(7).b;
net.b{7}(16:20) = acasxu41.Layers(7).b;
net.b{7}(21:25) = acasxu51.Layers(7).b;

% -------------Output Layer ------------------
% Weights
net.LW{8,7} = zeros(25,30);
net.LW{8,7}(1:25,1:25) = eye(25);
net.LW{8,7}(1:5,26) = -20;
net.LW{8,7}(6:10,27) = -20;
net.LW{8,7}(11:15,28) = -20;
net.LW{8,7}(16:20,29) = -20;
net.LW{8,7}(21:25,30) = -20;
% Bias
net.b{8} = ones(25,1)*(20);


% Works as desired. All the outputs corresponding to the NNs that we should
% not be using are large positive numbers, whereas the ones we care about
% are small (the actual outputs of the NNs)

% save('nn_new/acasxu1_afterswitch_net','net');
% net_to_mat('nn_new/acasxu1_afterswitch_net.mat','nn_new/acasxu1_afterswitch.mat')



