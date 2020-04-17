function ToONNX(network,outpath)
%% Create a layer graph for a SeriesNetwork and DAG Network

%% Load mat model to convert
load(network);

%% Get the layers type for the network
% Define input first and start the graph
lin = imageInputLayer([1 size(W{1},2)], 'Name', 'input','AverageImage',zeros([1 size(W{1},2)]));
lgraph = layerGraph;
lgraph = addLayers(lgraph,lin);

%% For files created in matlab
n = length(W);
for i=1:n
    a = split(string(act_fcns(i,:)));
    if strcmp(a(1),"relu") % Check activation function in layer
        layer = [fullyConnectedLayer(size(W{i},1),'Name','Operation_'+string(i)) 
        reluLayer('Name','relu_'+string(i))];
%         disp('Relu layer')
    elseif strcmp(a(1),"linear")  % Check activation function in layer
        layer = fullyConnectedLayer(size(W{i},1),'Name','linear_'+string(i)); 
%         disp('Linear layer')
    end
%     disp(layer)
    lgraph = addLayers(lgraph,layer);
end

% Add output layer
lout = regressionLayer('Name','output');
lgraph = addLayers(lgraph,lout);

%% Add weigths and bias values to layers
newlays = lgraph.Layers;
n = 1;
m = 1;
while n <= length(newlays)
    if class(newlays(n)) == "nnet.cnn.layer.FullyConnectedLayer"
%         disp("Adding pretrained values...")
        newlays(n).Weights = W{m};
        newlays(n).Bias =b{m}; 
        n = n + 1;
        m = m + 1;
    else
%         disp("No values to add")
        n = n + 1;
    end
end

%% Create graphical network 
newlgraph = layerGraph;
newlgraph = addLayers(newlgraph,newlays);
% figure
% plot(newlgraph)

%% Assemble network
net = assembleNetwork(newlgraph);

% deepNetworkDesigner % Opens visualizer for Series Network

%% Convert to ONNX
exportONNXNetwork(net,string(outpath))
