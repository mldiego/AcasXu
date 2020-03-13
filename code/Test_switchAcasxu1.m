%% Test the acasxu large network with the switch incorporated in layers
% By assuming that time (vertical separation) is always 0, we convert
% the AcasXu system into a single NN, and then we test it wrt the original
% ones to ensure correct functioning. For now, we can only test via
% simulation under the assumption that both speeds are always constant (inputs 4 and 5)

% Load all the networks
netp = load('switch_acasxu1_net.mat');
netp = netp.net;
neta = load('acasxu1_afterswitch_net.mat');
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
    out_sw(:,i) = netp([test_in(4,i); in6_pos(indx(i))]);
    % Main acasxu (after switch)
    out_big(:,i) = neta([test_in(:,1);out_sw(:,i)]);
    % Smaller networks
    out_small(1:5,i) = acasxu11.evaluate(test_in(:,i));
    out_small(6:10,i) = acasxu21.evaluate(test_in(:,i));
    out_small(11:15,i) = acasxu31.evaluate(test_in(:,i));
    out_small(16:20,i) = acasxu41.evaluate(test_in(:,i));
    out_small(21:25,i) = acasxu51.evaluate(test_in(:,i));    
end


% We cannot compare the outputs straightforward, but we can see the output
% advisory is the same in each case.

%% Compare outputs
tot_err = 0;
for i=1:m
    [~,ib] = min(out_big(indx(i)*5-4:indx(i)*5));
    [~,ism] = min(out_small(indx(i)*5-4:indx(i)*5));
    if ib ~= ism
        disp('We have a problem mate');
        tot_err = tot_err + 1;
    end
end
 warning('We had a total of ' + string(tot_err) + ' errors');

% It only returns numerical errors, but they are actually the same, just
% need to figure a different way of comparing them
% Comparing the minimum values works, but I also need to check that it is
% actually the network that corresponds to the inputs
    
