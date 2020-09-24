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
plot_all = false;
% Right half
f = figure('Color',[17 17 17]/18);
hold on;
grid;
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is 
if ~plot_all
    Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
    Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,4,5,'b');
    Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
else
    Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,'r');
    Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,4,5,'b');
    Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,'r');
end
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
ax = gca; % Get current axis
ax.GridColor = 'w'; % Set grid lines color
ax.XAxis.FontSize = 15; % Set font size of axis
ax.YAxis.FontSize = 15;
if plot_all
    saveas(f,"../data_reach/TestPoint2all.png");
else
    saveas(f,"../data_reach/TestPoint2.png");
end
% Plot end of trajectory
f3 = figure('Color',[17 17 17]/18);
hold on;
grid;
set(gca, 'GridAlpha' , 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,'g');
Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,'g');
Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
ax = gca; % Get current axis
ax.GridColor = 'w'; % Set grid lines color
ax.XAxis.FontSize = 15; % Set font size of axis
ax.YAxis.FontSize = 15;
saveas(f3,'../data_reach/TestPoint2all_end.png');
