function controller = LoadAcasXu(inputpath)
% Load  an acasXu network and create a compatible NN with nnv..
load(inputpath);
n = length(b);
Layers = [];
try
    if act_fcns
        for i=1:n
            L = LayerS(W{i}, b{i},act_fcns{i});
            Layers = [Layers L];
        end
    end
catch    
    for i=1:n
        if i == n
            L = LayerS(W{i}, b{i},'purelin');
            Layers = [Layers L];
        else
            L = LayerS(W{i}, b{i},'poslin');
            Layers = [Layers L];
        end
    end
end
controller = FFNNS(Layers);

end

