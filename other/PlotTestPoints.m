%% Load data
load('../data_reach/testpoints.mat');
load('../data_sim/testPoints.mat');
%% Plot reach sets for both the intruder and ownship
for i=1:10
    if i==2
        disp('Working on it');
    else
        f = figure;
        scatter(output(i).data.init_set{1, 1}.state_lb(1),output(i).data.init_set{1, 1}.state_lb(2),7,'xr');
        hold on;
        scatter(output(i).data.init_set{1, 1}.state_lb(4),output(i).data.init_set{1, 1}.state_lb(5),7,'xr');
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,4,5,'k');
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        title("ACASXu Test Point "+string(i));
        legend('Ownship','Intruder');
        saveas(f,"../data_reach/TestPoint"+string(i)+".png");
    end
end
%% Plot reach sets for the ownship
for i=1:10
    if i==2 || I==1
        disp('Working on it');
    else
        f = figure;
        scatter(output(i).data.init_set{1, 1}.state_lb(1),output(i).data.init_set{1, 1}.state_lb(2),7,'xr');
        hold on;
        scatter(output(i).data.init_set{1, 1}.state_lb(4),output(i).data.init_set{1, 1}.state_lb(5),7,'xr');
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        title("ACASXu Test Point "+string(i));
        legend('Ownship');
        saveas(f,"../data_reach/TestPoint"+string(i)+"_ownship.png");
    end
end
%% Plot simulations and reach set trajectories
for i=1:10
    if i==2
        disp('Working on it');
    else
        f = figure;
        hold on;
        scatter(out_sim(i).data(1,1),out_sim(i).data(1,2), 50, 'd', 'r', 'LineWidth',1);
        scatter(out_sim(i).data(1,4),out_sim(i).data(1,5), 50, 'd', 'k','LineWidth',1);
        plot(out_sim(i).data(:,1),out_sim(i).data(:,2),'--r');
        plot(out_sim(i).data(:,4),out_sim(i).data(:,5),'--k');
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
        Star.plotBoxes_2D_noFill(output(i).data.step_sets,4,5,'k');
        title("ACASXu Test Point "+string(i));
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        legend('ownship','intruder');
        saveas(f,"../data_reach/TestPoint" +string(i) + "_all.png"); % Save Plot
    end
end