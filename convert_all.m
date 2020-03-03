networks = dir('networks/*.mat');
for i=1:length(networks)
    net = mat_to_net(['networks/' networks(i).name]);
    gensim(net)
    s = split(string(networks(i).name),'.');
    save_system('untitled',['simulink_networks/' s{1} '.mdl']);
    bdclose('all');
end