%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---

% Test points a few steps before making a decision other than COC
init_dyn = [2.57298292500859e-12,43020,1.57079632679490,-24493.3681551309,42001.9180476659,1.14119632679490,24514.5168901961,1.58947758085803,-0.429600000000000; % Test point 1
    35893.0279144087,45893.0279144087,0.785398163397448,10529.1098552221,20529.1098552220,0.785398163397448,35869.9969142215,-3.14159265358979,0; % Test point 2
    1.65327317884897e-12,27000,1.57079632679490,11817.3036040667,19580.0166915592,1.93249632679490,13953.6981558167,-2.13147179977319,0.361700000000000; % Test point 3
    1.50455207156047e-13,2457.12000000000,1.57079632679490,-27214.9617743134,-24756.0571082470,1.02929632679490,38486.5374819606,2.35616193707089,-0.541500000000000; % Test point 4
    7.71934556058857e-12,126066.480000003,1.57079632679490,-6322.85650169227,132385.574856207,1.33289632679490,8939.24129837534,0.785688971941065,-0.237900000000000; % Test point 5
    9.69552870884960e-13,15834.0000000000,1.57079632679490,32364.5890742658,15841.1178127712,2.19339632679490,32364.5898569618,-1.57057640085547,0.622600000000000; % Test point 6
    2.94466322854982e-12,48090,1.57079632679490,46873.8427144232,67543.2504089879,2.35429632679490,50749.8865816395,-1.17741187939997,0.783500000000000; % Test point 7
    1.32450449914983e-12,21630.8000000000,1.57079632679490,20411.0367261430,42040.2047556014,2.32849632679490,28864.4423758876,-0.785438295691109,0.757700000000000; % Test point 8
    7.92135839798884e-13,12936.5600000000,1.57079632679490,9.55224503334934e-14,45296,1.57079632679490,32359.4399999998,9.42921199566535e-16,0; % Test point 9
    1.54305496692567e-12,25200,1.57079632679490,1.54305496692567e-12,94800,-1.57079632679490,69600,2.52291482330984e-17,3.14159265358979; % Test point 10
    ];

% Number of test points
m = size(init_dyn,1);
tf = [12;0;24;18;18;18;18;18;18;18];
st = 1; % Initial advisory
output = struct('data',cell(1,10),'tT',cell(1,10));
%% Simulate all
delete(gcp('nocreate')); % End previous parallel session
[~, cores] = evalc('feature(''numcores'')');

% parpool(cores);
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
    pause;
    if K == 4
        % Test 4
        [lb,ub] = calc_uncB(init_dyn(4,:)',100);
        init_set = Star(lb,ub);
        t4 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp4,st,tf(K),'approx-star',204.76,600);
        output(K).tT = toc(t4);
    end
    pause;
    if K == 5
        % Test 5
        [lb,ub] = calc_uncB(init_dyn(5,:)',100);
        init_set = Star(lb,ub);
        t5 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp5,st,tf(K),'approx-star',362.26,300);
        output(K).tT = toc(t5);
    end
    pause;
    if K == 6
        % Test 6
        [lb,ub] = calc_uncB(init_dyn(6,:)',100);
        init_set = Star(lb,ub);
        t6 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp6,st,tf(K),'approx-star',609,750);
        output(K).tT = toc(t6);
    end
    pause;
    if K == 7
        % Test 7
        [lb,ub] = calc_uncB(init_dyn(7,:)',100);
        init_set = Star(lb,ub);
        t7 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp7,st,tf(K),'approx-star',1145,1145);
        output(K).tT = toc(t7);
    end
    pause;
    if K == 8
        % Test 8
        [lb,ub] = calc_uncB(init_dyn(8,:)',100);
        init_set = Star(lb,ub);
        t8 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp8,st,tf(K),'approx-star',636.2,450);
        output(K).tT = toc(t8);
    end
    pause;
    if K == 9
        % Test 9
        [lb,ub] = calc_uncB(init_dyn(9,:)',100);
        init_set = Star(lb,ub);
        t9 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp9,st,tf(K),'approx-star',497.56,60);
        output(K).tT = toc(t9);
    end
    pause;
    if K == 10
        % Test 10
        [lb,ub] = calc_uncB(init_dyn(10,:)',100);
        init_set = Star(lb,ub);
        t10 = tic;
        output(K).data = reach_TestPointsb(init_set,@dyns_tp10,st,tf(K),'approx-star',600,600);
        output(K).tT = toc(t10);
    end
end

save('../data_reach/testPoints_opp.mat','output','-v7.3');
%% Visualize results
plot_all = false;
for i=1:m
    if i==2
        disp('Run ReachTestPoint2 files for these results');
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
            saveas(f,"../data_reach/TestPoint"+string(i)+"all_opp.png");
        else
            saveas(f,"../data_reach/TestPoint"+string(i)+"_opp.png");
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
        saveas(f4,"../data_reach/TestPoint"+string(i)+"both_opp.png");
    end
end