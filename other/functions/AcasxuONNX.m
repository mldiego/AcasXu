function AcasxuONNX
%% Convert NNV (mat) network files to ONNX

if ~exist('../../networks/onnx','dir')
    mkdir('./../networks/onnx')
end

mats = dir('../../networks/nnv_format/*.mat');

if isempty(mats)
    error('Cannot find the folder with the AcasXu NNV networks');
end

for i=1:length(mats)
    a = mats(i).name;
    na = split(string(a),'.');
    ToONNX(['../../networks/nnv_format/' a],['../../networks/onnx/' char(na(1)) '.onnx']);
end

end

