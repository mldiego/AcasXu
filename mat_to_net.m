function net = mat_to_net(netmat)

% Load network (mat)
load(netmat);

% Size of all layers
layer_sizes = [];
for i=1:length(b)
    layer_sizes = [layer_sizes length(b{i})];
end
% Number of layers
m = length(layer_sizes);

% Setup the feedforward net
net = feedforwardnet(layer_sizes(1:end-1));
net.inputs{1}.processFcns = {};
net.outputs{m}.processFcns = {};
net.inputs{1}.size = size(W{1,1},2);
net.layers{m}.size = layer_sizes(m);

% Add bias to net layers
for i=1:m
    net.b{i} = b{i};
end
% Add weights to net layers
net.IW{1} = W{1};
for i=2:m
    net.LW{i,i-1} = W{i};
end

end

