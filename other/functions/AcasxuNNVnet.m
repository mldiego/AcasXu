function AcasxuNNVnet
%% Convert nnet Acasxu files to NNV (mat) format

if ~exist('../../networks/nnv_format','dir')
    mkdir('./../networks/nnv_format')
end

nnets = dir('../../networks/nnet/*.nnet');
if isempty(nnets)
    error('Cannot find the folder with the AcasXu networks');
end

for i=1:length(nnets)
    a = nnets(i).name;
    a2 = split(string(a),'.');
    Load_nn([nnets(i).folder filesep a],'../../networks/nnv_format/');
end
end

