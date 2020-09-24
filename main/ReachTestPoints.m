%% Reachability analysis of all test points
% clc;clear;close all;
%% --- Setup scenarios ---

% Test points a few steps before making a decision other than COC
init_dyn = [44884.9999999997,0,0,44857.4597464554,23163.4259001182,-0.430000000000000,23163.4422721634,1.57198528047930,-0.430000000000000; % Test point 1
    11112.0000000000,0,0,-22136.0000000001,0,0,33248.0000000006,-pi,0; % Test point 2
    20400, 0, 0, 5073.2, -11724.5, 0.49,19297.04,-2.489,0.49; % Test point 3
    0, 0, 0, -20926, 30926, -0.5418, 43736, 3*pi/4, -0.5418; % Test point 4
    126066.48,0,0,132333.68,6109.85,-0.24,8752.63,0.7727,-0.24; % Test point 5
    15834, 0, 0, 15870.63, -32405.8, 0.62, 32405, -1.5697, 0.62; % Test point 6
    53814.9999999996,0,0,71731.8120481306,-42967.0180557308,0.780000000000000,46552.6003870736,-1.17572944847083,0.780000000000000; % Test point 7
    24811.8000000002,0,0,43646.8719885023,-18835.4286383100,0.760000000000000,26637.0978151548,-0.785407440292358,0.760000000000000; % Test point 8
    15424.3600000000,0,0,45596.0000000000,0,0,30171.6399999997,0,0; % Test point 9
    26999.9999999998,0,0,93000.0000000004,3.30654635769789e-12,3.14159265358979,66000.0000000004,5.00991872378461e-17,3.14159265358979; % Test point 10
    ];

% Number of test points
m = size(init_dyn,1);
tf = [30;0;24;38;30;30;30;30;30;30]; % t final for each test case
st = 1; % Initial advisory
output = struct('data',cell(1,10),'tT',cell(1,10));
%% Simulate all
delete(gcp('nocreate')); % End previous parallel session
[~, cores] = evalc('feature(''numcores'')');

parpool(cores);
parfor K = 1 : m
    if K == 1
        % Test 1
        [lb,ub] = calc_uncB(init_dyn(1,:)',100);
        init_set = Star(lb,ub);
        t1 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp1,st,tf(K),'approx-star',955,1050);
        output(K).tT = toc(t1);
    end
    if K == 3
        % Test 3
        [lb,ub] = calc_uncB(init_dyn(3,:)',100);
        init_set = Star(lb,ub);
        t3 =tic;
        output(K).data  = reach_TestPointsb(init_set,@dyns_tp3,st,tf(K),'approx-star',100,200);
        output(K).tT = toc(t3);
    end
    if K == 4
        % Test 4
        [lb,ub] = calc_uncB(init_dyn(4,:)',100);
        init_set = Star(lb,ub);
        t4 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp4,st,tf(K),'approx-star',204.76,600);
        output(K).tT = toc(t4);
    end
    if K == 5
        % Test 5
        [lb,ub] = calc_uncB(init_dyn(5,:)',100);
        init_set = Star(lb,ub);
        t5 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp5,st,tf(K),'approx-star',362.26,300);
        output(K).tT = toc(t5);
    end
    if K == 6
        % Test 6
        [lb,ub] = calc_uncB(init_dyn(6,:)',100);
        init_set = Star(lb,ub);
        t6 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp6,st,tf(K),'approx-star',609,750);
        output(K).tT = toc(t6);
    end
    if K == 7
        % Test 7
        [lb,ub] = calc_uncB(init_dyn(7,:)',100);
        init_set = Star(lb,ub);
        t7 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp7,st,tf(K),'approx-star',1145,1145);
        output(K).tT = toc(t7);
    end
    if K == 8
        % Test 8
        [lb,ub] = calc_uncB(init_dyn(8,:)',100);
        init_set = Star(lb,ub);
        t8 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp8,st,tf(K),'approx-star',636.2,450);
        output(K).tT = toc(t8);
    end
    if K == 9
        % Test 9
        [lb,ub] = calc_uncB(init_dyn(9,:)',100);
        init_set = Star(lb,ub);
        t9 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp9,st,tf(K),'approx-star',497.56,60);
        output(K).tT = toc(t9);
    end
    if K == 10
        % Test 10
        [lb,ub] = calc_uncB(init_dyn(10,:)',100);
        init_set = Star(lb,ub);
        t10 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp10,st,tf(K),'approx-star',600,600);
        output(K).tT = toc(t10);
    end
end

save('../data_reach/testPoints.mat','output','-v7.3');
%% Visualize results
plot_all = false;
for i=1:m
    if i==2
        disp('Working on it');
    else
        f = figure('Color',[17 17 17]/18);
        hold on;
        grid;
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        if ~plot_all
            Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
            Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,4,5,'b');
        else
            Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,'r');
            Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,4,5,'b');
        end
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        ax = gca; % Get current axis
        ax.GridColor = 'w'; % Set grid lines color
        ax.XAxis.FontSize = 15; % Set font size of axis
        ax.YAxis.FontSize = 15;
        if plot_all
            saveas(f,"../data_reach/TestPoint"+string(i)+"all.png");
        else
            saveas(f,"../data_reach/TestPoint"+string(i)+".png");
        end
        f4 = figure('Color',[17 17 17]/18);
        hold on;
        grid;
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,'g');
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        ax = gca; % Get current axis
        ax.GridColor = 'w'; % Set grid lines color
        ax.XAxis.FontSize = 15; % Set font size of axis
        ax.YAxis.FontSize = 15;
        saveas(f4,"../data_reach/TestPoint"+string(i)+"both.png");

    end
end