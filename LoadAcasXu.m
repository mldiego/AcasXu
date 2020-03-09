function controller = LoadAcasXu(inputpath)
% Load  an acasXu network and create a compatible NN with nnv..
load(inputpath);
n = length(b);
Layers = [];
for i=1:n
    if i == n
        L = LayerS(W{i}, b{i},'purelin');
        Layers = [Layers L];
    else
        L = LayerS(W{i}, b{i},'poslin');
        Layers = [Layers L];
    end
end
controller = FFNNS(Layers);

end

