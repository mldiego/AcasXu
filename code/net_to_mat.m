function net_to_mat(in_path,out_path)

load(in_path);
m = length(net.layers);
b = {};
W = {};
act_fcns = [];
for i=1:m
    b{i} = net.b{i};
    act_fcns = [act_fcns net.layers(i).transferFcn];
    if i==1
        W{i} = net.IW{i};
    else
        W{i} = net.LW{i,i-1};
    end
end

save(out_path,'W','b','act_fcns');

end

