%% Plot simulation and results in several ways
% Load reach data
load('../data_reach/testPoints_opp.mat');
% Load sim data
% load('../data_sim/TestPoints_opp.mat');
load('../data_sim/SimRandom_opp.mat');
% Load plot parameters
run LoadPlotParameters.m
%% Generate 6 plots from here
% 1 - Simulations
% 2 - Reachable set (nnenum axis)
% 3 - Simulations (zoomed in - nnenum axis)
% 4 - Reachable set (squared axis)
% 5 - Simulations (zoomed in - Squared axis)
% 6 - Simulations + reach sets (squared axis)

set(groot,'defaultFigureVisible','off')

for i=1:10
    if i==2
        disp('Run ReachTestPoint2 files for these results');
    else
        f1 = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha', 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        plot(random_sim{i,1}(:,4),random_sim{i,1}(:,5),'k');
        for k=1:N
            plot(random_sim{i,k}(:,1),random_sim{i,k}(:,2),'b');
        end
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
        saveas(f1,"../plotsJAT/TestPoint"+string(i)+"_sim.png");
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f2 = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        for k=1:N
            plot(random_sim{i,k}(:,1),random_sim{i,k}(:,2),'b');
        end
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
        saveas(f2,"../plotsJAT/TestPoint"+string(i)+"simZ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f3 = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.2);
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
        saveas(f3,"../plotsJAT/TestPoint"+string(i)+"reachZ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f4 = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.2);
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
        saveas(f4,"../plotsJAT/TestPoint"+string(i)+"reachSQ.png");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f5 = figure;
        hold on;
        grid;
        set(gcf,'Color',[1 1 1]);
        set(gca, 'GridAlpha' , 1); % Set transparency of grid
        set(gca, 'color', [17 17 17]/19); % Set background color 
        set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
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
        for k=1:N
            plot(random_sim{i,k}(:,1),random_sim{i,k}(:,2),'Color',[0 0 1 0.1]);
        end
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.1);
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        saveas(f5,"../plotsJAT/TestPoint"+string(i)+"reachSimSQ.png");
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
        xticks(xp_sq{i});
        yticks(yp_sq{i});
        xticklabels(xsq_label{i,:});
        yticklabels(ysq_label{i,:});
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
            plot(random_sim{i,k}(:,1),random_sim{i,k}(:,2),'Color',[0 0 1]);
        end
        saveas(f6,"../plotsJAT/TestPoint"+string(i)+"simSQ.png");
    end
end