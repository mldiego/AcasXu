%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Divide initial state into 2 sets along the x-axis
init_dyn = [0,9260.00000000002,1.57079632679490,0,-25736,1.57079632679490,34995.9999999999,pi,0;
    -0.001,9260.00000000002,1.57079632679490,1.10218211923262e-12,-25736,1.57079632679490,34995.9999999999,3.14159265358979,0;
];
tf = 18; % Final time of simulation
st = 1; % Initial advisory command
output = struct('data',cell(1,2),'t',cell(1,2));
%% Simulate Test Point 2
delete(gcp('nocreate'))
parpool(2);
parfor K = 1:2
    if K==1
        % Test 2
        t1 = tic;
        [lb,ub] = calc_unc2(init_dyn(1,:)',100);
        init_set = Star(lb,ub);
        output(K).data = reach_TestPointsb(init_set,@dyns_tp2,st,tf,'exact-star',463,900);
        output(K).t = toc(t1);
    end
    if K == 2
        t2 = tic;
        [lb2,ub2] = calc_unc2(init_dyn(2,:)',-100);
        init_set2 = Star(lb2,ub2);
        output(K).data = reach_TestPoints(init_set2,@dyns_tp2,st,tf,'exact-star',463,900);
        output(K).t = toc(t2);
    end
end

save('../data_reach/testPointsOrigin_2.mat','output','-v7.3');
%% Visualize results
load('../data_sim/SimRandom_opp.mat');
load('../data_reach/testPointsOrigin_2.mat');
% Simulation plots
xp = [-40000 -20000 0 20000 40000];
yp = [-40000 -30000 -20000 -10000 0 10000 20000 30000];
xp_label = {'-40000' '-20000' '0' '20000' '40000'};
yp_label = {'-40000' '-30000' '-20000' '-10000' '0', '10000', '20000', '30000'};
xl = [-42000 42000];
yl = [-48000 34000];
% Zoomed plots
xp_zoom = [-10000 -5000 0 5000 10000];
yp_zoom = [5000 10000 15000 20000 25000 30000];
xpz_label = {'-10000' '-5000' '0' '5000' '10000'};
ypz_label = {'5000' '10000' '15000' '20000' '25000' '30000'};
xl_zoom = [-12000 12000];
yl_zoom = [8500 32500];
% Square plots
xp_sq = [-4000 -2000 0 2000 4000];
yp_sq = [10000 12500 15000 17500 20000];
xsq_label = {'-4000' '-2000' '0' '2000' '4000'};
ysq_label = {'10000' '12500' '15000' '17500' '20000'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%        Start Plotting       %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1 = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha', 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
plot(random_sim{2,1}(:,4),random_sim{2,1}(:,5),'k');
for k=1:N
    plot(random_sim{2,k}(:,1),random_sim{2,k}(:,2),'b');
end
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
xlim(xl);
ylim(yl);
xticks(xp);
yticks(yp);
xticklabels(xp_label);
yticklabels(yp_label);
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
xticks(xp);
yticks(yp);
xticklabels(xp_label);
yticklabels(yp_label);
saveas(f1,"../plotsJAT/TestPoint2_sim.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f2 = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
for k=1:N
    plot(random_sim{2,k}(:,1),random_sim{2,k}(:,2),'b');
end
xlim(xl_zoom);
ylim(yl_zoom);
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
xticks(xp_zoom);
yticks(yp_zoom);
xticklabels(xpz_label);
yticklabels(ypz_label);
saveas(f2,"../plotsJAT/TestPoint2simZ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f3 = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,[1 0.4 0.6],0.3);
Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,[1 0.4 0.6],0.3);
Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
xlim(xl_zoom);
ylim(yl_zoom);
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
xticks(xp_zoom);
yticks(yp_zoom);
xticklabels(xpz_label);
yticklabels(ypz_label);
saveas(f3,"../plotsJAT/TestPoint2reachZ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f4 = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,[1 0.4 0.6],0.2);
Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,[1 0.4 0.6],0.2);
Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
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
xticks(xp_sq);
yticks(yp_sq);
xticklabels(xsq_label);
yticklabels(ysq_label);
saveas(f4,"../plotsJAT/TestPoint2reachSQ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f5 = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
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
for k=1:N
    plot(random_sim{2,k}(:,1),random_sim{2,k}(:,2),'Color',[0 0 1 0.1]);
end
Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,[1 0.4 0.6],0.3);
Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,[1 0.4 0.6],0.3);
Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
xticks(xp_sq);
yticks(yp_sq);
xticklabels(xsq_label);
yticklabels(ysq_label);
saveas(f5,"../plotsJAT/TestPoint2reachSimSQ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f6 = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
ax2 = gca; % Get current axis
ax2.GridColor = 'w'; % Set grid lines color
ax2.XAxis.FontSize = 15; % Set font size of axis
ax2.YAxis.FontSize = 15;
axis(ax2,'equal');
xlim(ax2, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.02)
ylim(ax2, ylim(ax) + [-1,1]*range(ylim(ax)).* 0.02)
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax2.Position = [left bottom ax_width ax_height];
for k=1:N
    plot(random_sim{2,k}(:,1),random_sim{2,k}(:,2),'Color',[0 0 1]);
end
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
xticks(xp_sq);
yticks(yp_sq);
xticklabels(xsq_label);
yticklabels(ysq_label);
saveas(f6,"../plotsJAT/TestPoint2simSQ.png");




% %% Olp plots
% % Simulation (plot 1)
% f1 = figure('Color',[17 17 17]/18);
% hold on;
% grid;
% set(gca, 'GridAlpha' , 1); % Set transparency of grid
% set(gca, 'color', [17 17 17]/19); % Set background color 
% set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is 
% Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,'r');
% Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,4,5,'b');
% Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,'r');
% xlabel('X Position (ft)');
% ylabel('Y Position (ft)');
% ax = gca; % Get current axis
% ax.GridColor = 'w'; % Set grid lines color
% ax.XAxis.FontSize = 15; % Set font size of axis
% ax.YAxis.FontSize = 15;
% saveas(f1,"../data_reach/TestPoint2.png");
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Simulation zoomed in
% f2 = figure('Color',[17 17 17]/18);
% hold on;
% grid;
% set(gca, 'GridAlpha' , 1); % Set transparency of grid
% set(gca, 'color', [17 17 17]/19); % Set background color 
% set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
% Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,'g');
% Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,'g');
% Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
% Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
% xlabel('X Position (ft)');
% ylabel('Y Position (ft)');
% ax = gca; % Get current axis
% ax.GridColor = 'w'; % Set grid lines color
% ax.XAxis.FontSize = 15; % Set font size of axis
% ax.YAxis.FontSize = 15;
% saveas(f2,'../data_reach/TestPoint2all_end.png');
