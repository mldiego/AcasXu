%% Test the acasxu large network with the switch incorporated in layers
% By assuming that time (vertical separation) is always 0, we convert
% the AcasXu system into a single NN, and then we test it wrt the original
% ones to ensure correct functioning. For now, we can only test via
% simulation under the assumption that both speeds are always constant (inputs 4 and 5)

% Load all the networks
netp = load('nn_new/switch_acasxu1_net.mat');
netp = netp.net;
neta = load('nn_new/acasxu1_afterswitch_net.mat');
neta = neta.net;
acasxu11 = LoadAcasXu('../networks/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/ACASXU_run2a_5_1_batch_2000.mat');

%% Part 1. Simulation

% Generate sample inputs
m = 1000; % Numbr of inputs to test
test_in = 2*rand(5,m)-1; % Interval (-1,1)
test_in(4:5,:) = 0.142727;
in6_pos = [0, deg2rad(1.5), deg2rad(-1.5), deg2rad(3), deg2rad(-3)];
indx = randi(length(in6_pos),1,1000);
out_sw = zeros(5,m);
out_big = zeros(25,m);
out_small = zeros(25,m);

% Run the tests
for i=1:m
    % Switch
    out_sw(:,i) = netp(in6_pos(indx(i)));
    % Main acasxu (after switch)
    out_big(:,i) = neta([test_in(:,i);out_sw(:,i)]);
    % Smaller networks
    out_small(1:5,i) = acasxu11.evaluate(test_in(:,i));
    out_small(6:10,i) = acasxu21.evaluate(test_in(:,i));
    out_small(11:15,i) = acasxu31.evaluate(test_in(:,i));
    out_small(16:20,i) = acasxu41.evaluate(test_in(:,i));
    out_small(21:25,i) = acasxu51.evaluate(test_in(:,i));    
end


% We cannot compare the outputs straightforward, but we can see the output
% advisory is the same in each case.

%% Compare outputs (decision)
tot_err = 0;
mb = zeros(1,m);
ms = zeros(1,m);
ib = zeros(1,m);
ism = zeros(1,m);
for i=1:m
    [mb(i),ib(i)] = min(out_big(indx(i)*5-4:indx(i)*5,i));
    [ms(i),ism(i)] = min(out_small(indx(i)*5-4:indx(i)*5,i));
    if ib(i) ~= ism(i) || mb(i) > 15
        tot_err = tot_err + 1;
    end
    
end
disp('')
warning('We had a total of ' + string(tot_err) + ' errors in the output advisory index');
disp('')

% It only returns numerical errors, but they are actually the same, just
% need to figure a different way of comparing them
% Comparing the minimum values works, but I also need to check that it is
% actually the network that corresponds to the inputs
    
% To avoid numerical errors, substract values from each other and make sure
% the difference between them is minimal ( < 0.0001)

% Make a copy of the outputs and set everything else thatn the correct
% outputs to 0

out_small_mod = zeros(25,m);
out_big_mod = zeros(25,m);
for i=1:m
    out_small_mod(indx(i)*5-4:indx(i)*5,i) =  out_small(indx(i)*5-4:indx(i)*5,i);
    out_big_mod(indx(i)*5-4:indx(i)*5,i) =  out_big(indx(i)*5-4:indx(i)*5,i);
end

out_diff_mod = out_big_mod - out_small_mod;
if max(max(out_diff_mod)) < 0.0001 && min(min(out_diff_mod)) > -0.0001
    warning('There are no errors in the outputs of the large AcasXu1 Neural Network')
else
    warning('There are some errors, check out all the output variables and analyze them to see what the problem is');
end

