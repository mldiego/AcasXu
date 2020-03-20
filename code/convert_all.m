networks = dir('../networks/nnv_format/*.mat');
for i=1:length(networks)
    net = mat_to_net(['../networks/nnv_format/' networks(i).name]);
    gensim(net)
    s = split(string(networks(i).name),'.');
    save_system('untitled',['../networks/simulink_block/' s{1} '.mdl']);
    bdclose('all');
end