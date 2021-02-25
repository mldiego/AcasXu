%% Simulate all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Test case initial states (original)
init_dyn = [0 1000 pi/2 -43736 0 pi/2-0.4296 43747.43 pi/2 -0.4296; % Test point 1
    0 0 pi/2 0 -43736 pi/2 43736 -3.14159265358979 0; % Test point 2
    0 0 pi/2 30926 -30926 pi/2+0.3617 43736 -(3*pi)/4 0.3617; % Test point 3
    0 0 pi/2 -30926 -30926 pi/2-0.5415 43736 3*pi/4 -0.5415; % Test point 4
    0 0 pi/2 -30926 30926 pi/2-0.2379 43736 pi/4 -0.2379; % Test point 5
    0 0 pi/2 43736 0 pi/2+0.6226 43736 -pi/2 0.6226; % Test point 6
    0 0 pi/2 80814 33474 pi/2+0.7835 87472 -3*pi/8 0.7835; % Test point 7
    0 0 pi/2 30926 30926 pi/2+0.7577 43736 -pi/4 0.7577; % Test point 8
    0 0 pi/2 0 43736 pi/2 43736 0 0; % Test point 9
    0 0 pi/2 0 120000 -pi/2 120000 0 pi; % Test point 10
    ];
% Test case initial states (rotated)
% init_dyn = [0 0 0 0 43736 -0.43 43736 pi/2 -0.43; % Test point 1
%     30000 40000 0.785398163397448 -926.020000000000 9073.98000000000 0.785398163397448 43735.9969142216 -3.14159265358979 0; % Test Point 2
%     0 0 0 -30926 -30926 0.3617 43736 -(3*pi)/4 0.3617; % Test point 3
%     0 0 0 -30926 30926 -0.5415 43736 3*pi/4 -0.5415; % Test point 4
%     0 0 0 30926 30926 -0.24 43736 pi/4 -0.24; % Test point 5
%     0 0 0 0 -43736 0.62 43736 -pi/2 0.62; % Test point 6
%     0 0 0 33474 -80814 0.78 87472 -3*pi/8 0.78; % Test point 7
%     0 0 0 30926 -30926 0.76 43736 -pi/4 0.76; % Test point 8
%     0 0 0 43736 0 0 43736 0 0; % Test point 9
%     0 0 0 120000 0 pi 120000 0 pi; % Test point 10
%     ];

% Number of simulations
m = size(init_dyn,1);
% time for all simulations
tf = [41,34,165,33,188,36,42,33,38,40]*2; % Final time of simulation
st = 2; % Step size
N = 50; % Number of random simulations from initial set under uncertainty
random_sim = cell(10,N);
% out_sim = struct('data',cell(1,10));
%% Simulate all
rng(10); % random seed
x0 = -100 + 200 .* rand(N,1);
y0 = -100 + 200 .* rand(N,1);
set(groot,'defaultFigureVisible','off');
for ex=1:N
    % Test 1
    init_dyn1 = init_dyn(1,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{1,ex} = sim_TestPoints(init_dyn1,@dyns_tp1,0:st:tf(1),'TestPoint1',955,1050);
    % Test 2
    init_dyn2 = init_dyn(2,:)+[x0(ex) 0 0 0 0 0 0 0 0];
    random_sim{2,ex} = sim_TestPoints(init_dyn2,@dyns_tp2,0:st:tf(2),'TestPoint2',463,900);
    % Test 3
    init_dyn3 = init_dyn(3,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{3,ex} = sim_TestPoints(init_dyn3,@dyns_tp3,0:st:tf(3),'TestPoint3',100,200);
    % Test 4
    init_dyn4 = init_dyn(4,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{4,ex} = sim_TestPoints(init_dyn4,@dyns_tp4,0:st:tf(4),'TestPoint4',204.76,600);
    % Test 5
    init_dyn5 = init_dyn(5,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{5,ex} = sim_TestPoints(init_dyn5,@dyns_tp5,0:st:tf(5),'TestPoint5',362.26,300);
    % Test 6
    init_dyn6 = init_dyn(6,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{6,ex} = sim_TestPoints(init_dyn6,@dyns_tp6,0:st:tf(6),'TestPoint6',609,750);
    % Test 7
    init_dyn7 = init_dyn(7,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{7,ex} = sim_TestPoints(init_dyn7,@dyns_tp7,0:st:tf(7),'TestPoint7',1145,1145);
    % Test 8
    init_dyn8 = init_dyn(8,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{8,ex} = sim_TestPoints(init_dyn8,@dyns_tp8,0:st:tf(8),'TestPoint8',636.2,450);
    % Test 9
    init_dyn9 = init_dyn(9,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{9,ex} = sim_TestPoints(init_dyn9,@dyns_tp9,0:st:tf(9),'TestPoint9',497.56,60);
    % Test 10
    init_dyn10 = init_dyn(10,:)+[x0(ex) y0(ex) 0 0 0 0 0 0 0];
    random_sim{10,ex} = sim_TestPoints(init_dyn10,@dyns_tp10,0:st:tf(10),'TestPoint10',600,600);
end
save('../data_sim/SimRandom_opp.mat','random_sim','N');
set(groot,'defaultFigureVisible','on')

% %% Plot Simulations
% load('../data_sim/SimRandom_opp.mat');
% 
% % Ownship plots
% xp = {[-40000 -20000 0 20000];
%     [-20000 0 20000 40000];
%     [-20000 0 20000 40000];
%     [-30000 -20000 -10000 0 10000];
%     [-50000 0 50000];
%     [-10000 0 10000 20000 30000 40000];
%     [-20000 0 20000 40000 60000 80000];
%     [-10000 0 10000 20000 30000];
%     [-20000 -10000 0 10000 20000];
%     [-50000 -25000 0 25000 50000]};
% yp = {[0 10000 20000 30000 40000 50000 60000 70000 80000];
%     [-30000 -20000 -10000 0 10000 20000 30000];
%     [-30000 -20000 -10000 0 10000 20000 30000];
%     [-30000 -20000 -10000 0 10000];
%     [0 20000 40000 60000 80000 100000 120000 140000];
%     [0 10000 20000 30000 40000 50000];
%     [0 20000 40000 60000 80000 100000];
%     [0 10000 20000 30000 40000 50000];
%     [0 10000 20000 30000 40000 50000];
%     [0 20000 40000 60000 80000 100000 120000]};
% xp_label = {{'-40000', '-20000', '0', '20000'};
%     {'-20000' '0' '20000' '40000'};
%     {'-20000' '0' '20000' '40000'};
%     {'-30000' '-20000' '-10000' '0' '10000'};
%     {'-50000' '0' '50000'};
%     {'-10000' '0' '10000' '20000' '30000' '40000'};
%     {'-20000' '0' '20000' '40000' '60000' '80000'};
%     {'-10000' '0' '10000' '20000' '30000'};
%     {'-20000' '-10000' '0' '10000' '20000'};
%     {'-50000' '-25000' '0' '25000' '50000'}};
% yp_label = {{'0', '10000', '20000', '30000', '40000', '50000', '60000', '70000', '80000'};
%     {'-30000' '-20000' '-10000' '0' '10000' '20000' '30000'};
%     {'-30000' '-20000' '-10000' '0' '10000' '20000' '30000'};
%     {'-30000' '-20000' '-10000' '0' '10000'};
%     {'0' '20000' '40000' '60000' '80000' '100000' '120000' '140000'};
%     {'0' '10000' '20000' '30000' '40000' '50000'};
%     {'0' '20000' '40000' '60000' '80000' '100000'};
%     {'0' '10000' '20000' '30000' '40000' '50000'};
%     {'0' '10000' '20000' '30000' '40000' '50000'};
%     {'0' '20000' '40000' '60000' '80000' '100000' '120000'}};
% xl = [[-55000 30000];[-21000 50000];[-21000 50000];[-33000 11000];[-75000 60000];
%     [-12000 44000];[-22000 82000];[-15000 40000];[-25000 23000];[-53000 54000]];
% yl = [[-2000 81000];[-35000 35000];[-35000 35000];[-33000 15000];[-2000 142000];
%     [-9000 51000];[-4000 105000];[-3000 53000];[-2000 50500];[-2000 122000]];
% % Zoomed in plots
% xp_zoom = {[-20000 -10000 0 10000 20000];
%     [-5000 0 5000];
%     [-5000 0 5000];
%     [-5000 -2500 0 2500 5000 75000];
%     [-5000 0 5000];
%     [-10000 0 10000];
%     [-30000 -20000 -10000 0 10000];
%     [-10000 -5000 0 5000];
%     [-10000 -5000 0 5000 10000];
%     [-5000 0 5000 10000]};
% yp_zoom = {[40000 50000 60000 70000];
%     [20000 22000 24000 26000 28000 30000 32000 34000];
%     [20000 22000 24000 26000 28000 30000 32000 34000];
%     [2000 4000 6000 8000 10000 12000 14000];
%     [120000 122000 124000 126000 128000 130000 132000 134000 136000];
%     [10000 15000 20000 25000 30000 35000 40000];
%     [50000 60000 70000 80000 90000];
%     [25000 27500 30000 32500 35000 37500 40000 42500];
%     [15000 20000 25000 30000 35000];
%     [30000 32500 35000 37500 40000 42500 45000 47500]};
% xpz_label = {{'-20000' '-10000' '0' '10000' '20000'};
%     {'-5000' '0' '5000'};
%     {'-5000' '0' '5000'};
%     {'-5000' '-2500' '0' '2500' '5000' '75000'};
%     {'-5000' '0' '5000'};
%     {'-10000' '0' '10000'};
%     {'-30000' '-20000' '-10000' '0' '10000'};
%     {'-10000' '-5000' '0' '5000'};
%     {'-10000' '-5000' '0' '5000' '10000'};
%     {'-5000' '0' '5000' '10000'}};
% ypz_label = {{'40000' '50000' '60000' '70000'};
%     {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
%     {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
%     {'2000' '4000' '6000' '8000' '10000' '12000' '14000'};
%     {'120000' '122000' '124000' '126000' '128000' '130000' '132000' '134000' '136000'};
%     {'10000' '15000' '20000' '25000' '30000' '35000' '40000'};
%     {'50000' '60000' '70000' '80000' '90000'};
%     {'25000' '27500' '30000' '32500' '35000' '37500' '40000' '42500'};
%     {'15000' '20000' '25000' '30000' '35000'};
%     {'30000' '32500' '35000' '37500' '40000' '42500' '45000' '47500'}};
% xl_zoom = [[-21000 28000];[-7000 7000];[-7000 7000];[-5500 7800];[-8000 8000];
%     [-19000 13000];[-33000 15000];[-12000 8000];[-13000 11000];[-9000 12000]];
% yl_zoom = [[30000 70000];[19000 34000];[19000 34000];[0 14100];[118000 136500];
%     [9000 43000];[45000 95000];[23500 43500];[13500 36500];[27500 48500]];
% % set(groot,'defaultFigureVisible','on')
% % Start one plot per test case
% for i=1:10
%     f = figure;
%     hold on;
%     grid;
%     set(gcf,'Color',[1 1 1]);
%     set(gca, 'GridAlpha', 1); % Set transparency of grid
%     set(gca, 'color', [17 17 17]/19); % Set background color 
%     set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
%     plot(random_sim{i,1}(:,4),random_sim{i,1}(:,5),'k');
%     for k=1:N
%         plot(random_sim{i,k}(:,1),random_sim{i,k}(:,2),'b');
%     end
%     xlabel('X Position (ft)');
%     ylabel('Y Position (ft)');
%     xlim(xl(i,:));
%     ylim(yl(i,:));
%     xticks(xp{i});
%     yticks(yp{i});
%     xticklabels(xp_label{i,:});
%     yticklabels(yp_label{i,:});
%     ax = gca; % Get current axis
%     ax.GridColor = 'w'; % Set grid lines color
%     ax.XAxis.FontSize = 15; % Set font size of axis
%     ax.YAxis.FontSize = 15;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset; 
%     left = outerpos(1) + ti(1);
%     bottom = outerpos(2) + ti(2);
%     ax_width = outerpos(3) - ti(1) - ti(3);
%     ax_height = outerpos(4) - ti(2) - ti(4);
%     ax.Position = [left bottom ax_width ax_height];
%     saveas(f,"../data_sim/jat/TestPoint"+string(i)+"_opp.png");
%     f4 = figure;
%     hold on;
%     grid;
%     set(gcf,'Color',[1 1 1]);
%     set(gca, 'GridAlpha' , 1); % Set transparency of grid
%     set(gca, 'color', [17 17 17]/19); % Set background color 
%     set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
%     for k=1:N
%         plot(random_sim{i,k}(:,1),random_sim{i,k}(:,2),'b');
%     end
%     xlim(xl_zoom(i,:));
%     ylim(yl_zoom(i,:));
%     xticks(xp_zoom{i});
%     yticks(yp_zoom{i});
%     xticklabels(xpz_label{i,:});
%     yticklabels(ypz_label{i,:});
%     xlabel('X Position (ft)');
%     ylabel('Y Position (ft)');
%     ax = gca; % Get current axis
%     ax.GridColor = 'w'; % Set grid lines color
%     ax.XAxis.FontSize = 15; % Set font size of axis
%     ax.YAxis.FontSize = 15;
%     outerpos = ax.OuterPosition;
%     ti = ax.TightInset; 
%     left = outerpos(1) + ti(1);
%     bottom = outerpos(2) + ti(2);
%     ax_width = outerpos(3) - ti(1) - ti(3);
%     ax_height = outerpos(4) - ti(2) - ti(4);
%     ax.Position = [left bottom ax_width ax_height];
%     saveas(f4,"../data_sim/jat/TestPoint"+string(i)+"both_opp.png");
% end