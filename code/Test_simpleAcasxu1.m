%% Test the acasxu large network
% By assuming that time (vertical separation) is always 0, we convert
% the AcasXu system into a single NN, and then we test it wrt the original
% ones to ensure correct functioning.

% Load all the networks
bigacasxu1 = LoadAcasXu('nn_new/simple_acasxu1.mat');
acasxu11 = LoadAcasXu('../networks/ACASXU_run2a_1_1_batch_2000.mat');
acasxu21 = LoadAcasXu('../networks/ACASXU_run2a_2_1_batch_2000.mat');
acasxu31 = LoadAcasXu('../networks/ACASXU_run2a_3_1_batch_2000.mat');
acasxu41 = LoadAcasXu('../networks/ACASXU_run2a_4_1_batch_2000.mat');
acasxu51 = LoadAcasXu('../networks/ACASXU_run2a_5_1_batch_2000.mat');

%% Part 1. Simulation

% Generate sample inputs
m = 1000; % Numbr of inputs to test
test_in = 2*rand(5,m)-1; % Interval (-1,1)
out_big = zeros(25,m);
out_small = zeros(25,m);

% Run the tests
for i=1:m
    % Large network
    out_big(:,i) = bigacasxu1.evaluate(test_in(:,i));
    % Smaller networks
    out_small(1:5,i) = acasxu11.evaluate(test_in(:,i));
    out_small(6:10,i) = acasxu21.evaluate(test_in(:,i));
    out_small(11:15,i) = acasxu31.evaluate(test_in(:,i));
    out_small(16:20,i) = acasxu41.evaluate(test_in(:,i));
    out_small(21:25,i) = acasxu51.evaluate(test_in(:,i));    
end

% Compare results
if out_big == out_small
    disp('CORRECT')
    disp('The large network represents the behavior of the smaller ones')
else
    warning('There is something wrong with the simple large network');
end


%% Part 2. Reachability analysis

% Create input sets
lb = [0.1;0.1;0.1;0.1;0.1];
ub = [0.11;0.11;0.11;0.11; 0.11];
in_set = Star(lb,ub);

lb = [-1; -1; -1; -1; -1];
ub = [-1.01; -1.01; -1.01; -1.01; -1.01];
in_set1 = Star(lb,ub);

% Large network
out_bigSe = bigacasxu1.reach(in_set,'exact-star',4);
out_bigS1e = bigacasxu1.reach(in_set1,'exact-star',4);

% Smaller networks
out1_smallSe = acasxu11.reach(in_set,'exact-star',4);
out1_smallSe1 = acasxu11.reach(in_set1,'exact-star',4);
out2_smallSe = acasxu21.reach(in_set,'exact-star',4);
out2_smallSe1 = acasxu21.reach(in_set1,'exact-star',4);
out3_smallSe = acasxu31.reach(in_set,'exact-star',4);
out3_smallSe1 = acasxu31.reach(in_set1,'exact-star',4);
out4_smallSe = acasxu41.reach(in_set,'exact-star',4);
out4_smallSe1 = acasxu41.reach(in_set1,'exact-star',4);
out5_smallSe = acasxu51.reach(in_set,'exact-star',4);
out5_smallSe1 = acasxu51.reach(in_set1,'exact-star',4);



%% Part 3. Reachability analysis (approximate methods)
% Create input sets
lb = [0.1;0.1;0.1;0.1;0.1];
ub = [0.11;0.11;0.11;0.11; 0.11];
in_set = Star(lb,ub);

lb = [-1; -1; -1; -1; -1];
ub = [-1.01; -1.01; -1.01; -1.01; -1.01];
in_set1 = Star(lb,ub);

% Large network
out_bigS = bigacasxu1.reach(in_set,'approx-star',4);
out_bigS1 = bigacasxu1.reach(in_set1,'approx-star',4);

% Smaller networks
out1_smallS = acasxu11.reach(in_set,'approx-star',4);
out1_smallS1 = acasxu11.reach(in_set1,'approx-star',4);
out2_smallS = acasxu21.reach(in_set,'approx-star',4);
out2_smallS1 = acasxu21.reach(in_set1,'approx-star',4);
out3_smallS = acasxu31.reach(in_set,'approx-star',4);
out3_smallS1 = acasxu31.reach(in_set1,'approx-star',4);
out4_smallS = acasxu41.reach(in_set,'approx-star',4);
out4_smallS1 = acasxu41.reach(in_set1,'approx-star',4);
out5_smallS = acasxu51.reach(in_set,'approx-star',4);
out5_smallS1 = acasxu51.reach(in_set1,'approx-star',4);

% Matrix multiplier for "first" NN output of the large network
m1 = zeros(5,25); m1(1,1) = 1; m1(2,2) = 1;
m1(3,3) = 1; m1(4,4) = 1; m1(5,5) = 1;

% Second
m2 = zeros(5,25); m2(1,6) = 1; m2(2,7) = 1;
m2(3,8) = 1; m2(4,9) = 1; m2(5,10) = 1;

% Third
m3 = zeros(5,25); m3(1,11) = 1; m3(2,12) = 1;
m3(3,13) = 1; m3(4,14) = 1; m3(5,15) = 1;

% Fourth
m4 = zeros(5,25); m4(1,16) = 1; m4(2,17) = 1;
m4(3,18) = 1; m4(4,19) = 1; m4(5,20) = 1;

% Fifth
% Third
m5 = zeros(5,25); m5(1,21) = 1; m5(2,22) = 1;
m5(3,23) = 1; m5(4,24) = 1; m5(5,25) = 1;

% Check AcasXu_1_1
if out1_smallS.isSubSet(out_bigS.affineMap(m1,[]))  
    disp('First NN is a subset of large NN')
    figure;
    subplot(1,3,1);
    Star.plotBoxes_2D_noFill(out1_smallS,1,1,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,1,1,'--r');
    legend('Small','Big');
    subplot(1,3,2);
    Star.plotBoxes_2D_noFill(out1_smallS,2,3,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,2,3,'--r');
    legend('Small','Big');
    subplot(1,3,3);
    Star.plotBoxes_2D_noFill(out1_smallS,4,5,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,4,5,'--r');
    legend('Small','Big');
else
    disp('The approximate method return an output of the first NN that is not a subset of the larger one');
end

% Check AcasXu_2_1
if out1_smallS.isSubSet(out_bigS.affineMap(m1,[]))  
    disp('Second NN is a subset of large NN')
    figure;
    subplot(1,3,1);
    Star.plotBoxes_2D_noFill(out1_smallS,1,1,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,1,1,'--r');
    legend('Small','Big');
    subplot(1,3,2);
    Star.plotBoxes_2D_noFill(out1_smallS,2,3,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,2,3,'--r');
    legend('Small','Big');
    subplot(1,3,3);
    Star.plotBoxes_2D_noFill(out1_smallS,4,5,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,4,5,'--r');
    legend('Small','Big');
else
    disp('The approximate method return an output of the first NN that is not a subset of the larger one');
end

% Check AcasXu_3_1
if out1_smallS.isSubSet(out_bigS.affineMap(m1,[]))  
    disp('Third NN is a subset of large NN')
    figure;
    subplot(1,3,1);
    Star.plotBoxes_2D_noFill(out1_smallS,1,1,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,1,1,'--r');
    legend('Small','Big');
    subplot(1,3,2);
    Star.plotBoxes_2D_noFill(out1_smallS,2,3,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,2,3,'--r');
    legend('Small','Big');
    subplot(1,3,3);
    Star.plotBoxes_2D_noFill(out1_smallS,4,5,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,4,5,'--r');
    legend('Small','Big');
else
    disp('The approximate method return an output of the first NN that is not a subset of the larger one');
end

% Check AcasXu_4_1
if out1_smallS.isSubSet(out_bigS.affineMap(m1,[]))  
    disp('Fourth NN is a subset of large NN')
    figure;
    subplot(1,3,1);
    Star.plotBoxes_2D_noFill(out1_smallS,1,1,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,1,1,'--r');
    legend('Small','Big');
    subplot(1,3,2);
    Star.plotBoxes_2D_noFill(out1_smallS,2,3,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,2,3,'--r');
    legend('Small','Big');
    subplot(1,3,3);
    Star.plotBoxes_2D_noFill(out1_smallS,4,5,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,4,5,'--r');
    legend('Small','Big');
else
    disp('The approximate method return an output of the first NN that is not a subset of the larger one');
end

% Check AcasXu_5_1
if out5_smallS.isSubSet(out_bigS.affineMap(m5,[]))  
    disp('Fifth NN is a subset of large NN')
    figure;
    subplot(1,3,1);
    Star.plotBoxes_2D_noFill(out5_smallS,1,1,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,21,21,'--r');
    legend('Small','Big');
    subplot(1,3,2);
    Star.plotBoxes_2D_noFill(out5_smallS,2,3,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,22,23,'--r');
    legend('Small','Big');
    subplot(1,3,3);
    Star.plotBoxes_2D_noFill(out5_smallS,4,5,'b');
    hold on;
    Star.plotBoxes_2D_noFill(out_bigS,24,25,'--r');
    legend('Small','Big');
else
    disp('The approximate method return an output of the first NN that is not a subset of the larger one');
end