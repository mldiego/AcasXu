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
% tf = [12;0;24;18;18;18;18;18;18;18];
tf = [14;0;28;30;28;30;30;30;28;30];
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
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp1,st,tf(K),'approx-star',955,1050);
        output(K).tT = toc(t1);
        disp('11111111111111111111111');
    end
    if K == 3
        % Test 3
        [lb,ub] = calc_uncB(init_dyn(3,:)',100);
        init_set = Star(lb,ub);
        t3 =tic;
        output(K).data  = reachTestPoints_JATreviews(init_set,@dyns_tp3,st,tf(K),'approx-star',100,200);
        output(K).tT = toc(t3);
        disp('3333333333333333333333333');
    end
    if K == 4
        % Test 4
        [lb,ub] = calc_uncB(init_dyn(4,:)',100);
        init_set = Star(lb,ub);
        t4 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp4,st,tf(K),'approx-star',204.76,600);
        output(K).tT = toc(t4);
        disp('4444444444444444444444444444');
    end
    if K == 5
        % Test 5
        [lb,ub] = calc_uncB(init_dyn(5,:)',100);
        init_set = Star(lb,ub);
        t5 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp5,st,tf(K),'approx-star',362.26,300);
        output(K).tT = toc(t5);
        disp('5555555555555555555555555555555');
    end
    if K == 6
        % Test 6
        [lb,ub] = calc_uncB(init_dyn(6,:)',100);
        init_set = Star(lb,ub);
        t6 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp6,st,tf(K),'approx-star',609,750);
        output(K).tT = toc(t6);
        disp('666666666666666666666666666');
    end
    if K == 7
        % Test 7
        [lb,ub] = calc_uncB(init_dyn(7,:)',100);
        init_set = Star(lb,ub);
        t7 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp7,st,tf(K),'approx-star',1145,1145);
        output(K).tT = toc(t7);
        disp('7777777777777777777777777777');
    end
    if K == 8
        % Test 8
        [lb,ub] = calc_uncB(init_dyn(8,:)',100);
        init_set = Star(lb,ub);
        t8 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp8,st,tf(K),'approx-star',636.2,450);
        output(K).tT = toc(t8);
        disp('8888888888888888888888888888888888');
    end
    if K == 9
        % Test 9
        [lb,ub] = calc_uncB(init_dyn(9,:)',100);
        init_set = Star(lb,ub);
        t9 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp9,st,tf(K),'approx-star',497.56,60);
        output(K).tT = toc(t9);
        disp('99999999999999999999999999999999999');
    end
    if K == 10
        % Test 10
        [lb,ub] = calc_uncB(init_dyn(10,:)',100);
        init_set = Star(lb,ub);
        t10 = tic;
        output(K).data = reachTestPoints_JATreviews(init_set,@dyns_tp10,st,tf(K),'approx-star',600,600);
        output(K).tT = toc(t10);
        disp('000000000000000000000000000000000000');
    end
end

save('../data_reach/testPoints_JATrevs.mat','output','-v7.3');
%% Visualize results
clc;clear;
load('../data_reach/testPoints_JATrevs.mat');
load('../data_sim/TestPoints_opp.mat');
% Ownship plots
xp = {[-40000 -20000 0 20000];
    [-20000 0 20000 40000];
    [-20000 0 20000 40000];
    [-30000 -20000 -10000 0 10000];
    [-50000 0 50000];
    [-10000 0 10000 20000 30000 40000];
    [-20000 0 20000 40000 60000 80000];
    [-10000 0 10000 20000 30000];
    [-20000 -10000 0 10000 20000];
    [-50000 -25000 0 25000 50000]};
yp = {[0 10000 20000 30000 40000 50000 60000 70000 80000];
    [-30000 -20000 -10000 0 10000 20000 30000];
    [-30000 -20000 -10000 0 10000 20000 30000];
    [-30000 -20000 -10000 0 10000];
    [0 20000 40000 60000 80000 100000 120000 140000];
    [0 10000 20000 30000 40000 50000];
    [0 20000 40000 60000 80000 100000];
    [0 10000 20000 30000 40000 50000];
    [0 10000 20000 30000 40000 50000];
    [0 20000 40000 60000 80000 100000 120000]};
xp_label = {{'-40000', '-20000', '0', '20000'};
    {'-20000' '0' '20000' '40000'};
    {'-20000' '0' '20000' '40000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'-50000' '0' '50000'};
    {'-10000' '0' '10000' '20000' '30000' '40000'};
    {'-20000' '0' '20000' '40000' '60000' '80000'};
    {'-10000' '0' '10000' '20000' '30000'};
    {'-20000' '-10000' '0' '10000' '20000'};
    {'-50000' '-25000' '0' '25000' '50000'}};
yp_label = {{'0', '10000', '20000', '30000', '40000', '50000', '60000', '70000', '80000'};
    {'-30000' '-20000' '-10000' '0' '10000' '20000' '30000'};
    {'-30000' '-20000' '-10000' '0' '10000' '20000' '30000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'0' '20000' '40000' '60000' '80000' '100000' '120000' '140000'};
    {'0' '10000' '20000' '30000' '40000' '50000'};
    {'0' '20000' '40000' '60000' '80000' '100000'};
    {'0' '10000' '20000' '30000' '40000' '50000'};
    {'0' '10000' '20000' '30000' '40000' '50000'};
    {'0' '20000' '40000' '60000' '80000' '100000' '120000'}};
xl = [[-55000 30000];[-21000 50000];[-21000 50000];[-33000 11000];[-75000 60000];
    [-12000 44000];[-22000 82000];[-15000 40000];[-25000 23000];[-53000 54000]];
yl = [[-2000 81000];[-35000 35000];[-35000 35000];[-33000 15000];[-2000 142000];
    [-9000 51000];[-4000 105000];[-3000 53000];[-2000 50500];[-2000 122000]];
% Zoomed in plots
xp_zoom = {[-20000 -10000 0 10000 20000];
    [-5000 0 5000];
    [-5000 0 5000];
    [-5000 -2500 0 2500 5000 75000];
    [-5000 0 5000];
    [-10000 0 10000];
    [-30000 -20000 -10000 0 10000];
    [-10000 -5000 0 5000];
    [-10000 -5000 0 5000 10000];
    [-5000 0 5000 10000]};
yp_zoom = {[40000 50000 60000 70000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [2000 4000 6000 8000 10000 12000 14000];
    [120000 122000 124000 126000 128000 130000 132000 134000 136000];
    [10000 15000 20000 25000 30000 35000 40000];
    [50000 60000 70000 80000 90000];
    [25000 27500 30000 32500 35000 37500 40000 42500];
    [15000 20000 25000 30000 35000];
    [30000 32500 35000 37500 40000 42500 45000 47500]};
xpz_label = {{'-20000' '-10000' '0' '10000' '20000'};
    {'-5000' '0' '5000'};
    {'-5000' '0' '5000'};
    {'-5000' '-2500' '0' '2500' '5000' '75000'};
    {'-5000' '0' '5000'};
    {'-10000' '0' '10000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'-10000' '-5000' '0' '5000'};
    {'-10000' '-5000' '0' '5000' '10000'};
    {'-5000' '0' '5000' '10000'}};
ypz_label = {{'40000' '50000' '60000' '70000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'2000' '4000' '6000' '8000' '10000' '12000' '14000'};
    {'120000' '122000' '124000' '126000' '128000' '130000' '132000' '134000' '136000'};
    {'10000' '15000' '20000' '25000' '30000' '35000' '40000'};
    {'50000' '60000' '70000' '80000' '90000'};
    {'25000' '27500' '30000' '32500' '35000' '37500' '40000' '42500'};
    {'15000' '20000' '25000' '30000' '35000'};
    {'30000' '32500' '35000' '37500' '40000' '42500' '45000' '47500'}};
xl_zoom = [[-21000 28000];[-7000 7000];[-7000 7000];[-5500 7800];[-8000 8000];
    [-19000 13000];[-33000 15000];[-12000 8000];[-13000 11000];[-9000 12000]];
yl_zoom = [[30000 70000];[19000 34000];[19000 34000];[0 14100];[118000 136500];
    [9000 43000];[45000 95000];[23500 43500];[13500 36500];[27500 48500]];
% Square Zoomed in plots
xp_sq = {[-10000 -5000 0 5000 10000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [-2000 -1000 0 1000 2000];
    [-5000 -2500 0 2500 5000];
    [-5000 -2500 0 2500 5000];
    [-10000 -5000 0 5000 10000];
    [-20000 -10000 0 10000];
    [-10000 -5000 0 5000];
    [-6000 -3000 0 3000 6000];
    [-5000 0 5000 10000]};
yp_sq = {[40000 45000 50000 55000 60000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [26000 27000 28000 29000];
    [0 2000 4000 6000 8000 10000];
    [124000 126000 128000 130000 132000 134000 136000];
    [15000 20000 25000 30000 35000];
    [50000 60000 70000 80000];
    [25000 30000 35000 40000];
    [15000 20000 25000 30000];
    [25000 30000 35000 40000 45000]};
xsq_label = {{'-10000' '-5000' '0' '5000' '10000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'-2000' '-1000' '0' '1000' '2000'};
    {'-5000' '-2500' '0' '2500' '5000'};
    {'-5000' '-2500' '0' '2500'};
    {'-10000' '-5000' '0' '5000' '10000'};
    {'-20000' '-10000' '0' '10000'};
    {'-10000' '-5000' '0' '5000'};
    {'-6000' '-3000' '0' '3000' '6000'};
    {'-5000' '0' '5000' '10000'}};
ysq_label = {{'40000' '45000' '50000' '55000' '60000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'26000' '27000' '28000' '29000'};
    {'0' '2000' '4000' '6000' '8000' '10000'};
    {'124000' '126000' '128000' '130000' '132000' '134000' '136000'};
    {'15000' '20000' '25000' '30000'};
    {'50000' '60000' '70000' '80000'};
    {'25000' '30000' '35000' '40000'};
    {'15000' '20000' '25000' '30000' };
    {'25000' '30000' '35000' '40000' '45000'}};

sim_limits = [41,50,165,33,187,36,42,33,38,40];

for i=1:m
    if i==2
        disp('Run ReachTestPoint2 files for these results');
    else
        f = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha', 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.1);
        plot(out_sim(i).data(1:sim_limits(i),4),out_sim(i).data(1:sim_limits(i),5),'k');
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        xlim(xl(i,:));
        ylim(yl(i,:));
        xticks(xp{i});
        yticks(yp{i});
        xticklabels(xp_label{i,:});
        yticklabels(yp_label{i,:});
        ax = gca; % Get current axis
        ax.GridColor = 'w'; % Set grid lines color
        ax.XAxis.FontSize = 15; % Set font size of axis
        ax.YAxis.FontSize = 15;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset; 
        left = outerpos(1) + ti(1);
        bottom = outerpos(2) + ti(2);
        ax_width = outerpos(3) - ti(1) - ti(3);
        ax_height = outerpos(4) - ti(2) - ti(4);
        ax.Position = [left bottom ax_width ax_height];
        saveas(f,"../data_reach/jat/TestPoint"+string(i)+"_opp_JATrevs.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f4 = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.1);
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        xlim(xl_zoom(i,:));
        ylim(yl_zoom(i,:));
        xticks(xp_zoom{i});
        yticks(yp_zoom{i});
        xticklabels(xpz_label{i,:});
        yticklabels(ypz_label{i,:});
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        ax = gca; % Get current axis
        ax.GridColor = 'w'; % Set grid lines color
        ax.XAxis.FontSize = 15; % Set font size of axis
        ax.YAxis.FontSize = 15;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset; 
        left = outerpos(1) + ti(1);
        bottom = outerpos(2) + ti(2);
        ax_width = outerpos(3) - ti(1) - ti(3);
        ax_height = outerpos(4) - ti(2) - ti(4);
        ax.Position = [left bottom ax_width ax_height];
        saveas(f4,"../data_reach/jat/TestPoint"+string(i)+"both_opp_JATrevs.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fsq = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.1);
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        xticks(xp_sq{i});
        yticks(yp_sq{i});
        xticklabels(xsq_label{i,:});
        yticklabels(ysq_label{i,:});
        ax = gca; % Get current axis
        ax.GridColor = 'w'; % Set grid lines color
        ax.XAxis.FontSize = 15; % Set font size of axis
        ax.YAxis.FontSize = 15;
        axis(ax,'equal');
        xlim(ax, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.02)
        ylim(ax, ylim(ax) + [-1,1]*range(ylim(ax)).* 0.02)
        outerpos = ax.OuterPosition;
        ti = ax.TightInset; 
        left = outerpos(1) + ti(1);
        bottom = outerpos(2) + ti(2);
        ax_width = outerpos(3) - ti(1) - ti(3);
        ax_height = outerpos(4) - ti(2) - ti(4);
        ax.Position = [left bottom ax_width ax_height];
        saveas(fsq,"../data_reach/jat/TestPoint"+string(i)+"both_opp_sq_JATrevs.png");
%         width = 10;
%         height = 10;
%         fsq.Units = 'inches';
%         figure_position = fsq.Position;
%         fsq.Position = [figure_position(1),figure_position(2), width, height];
%         print(fsq, "../data_reach/jat/TestPoint"+string(i)+"both_opp_sq.pdf", '-dpdf')
    end
end