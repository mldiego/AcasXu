%% Performance comparison Monte Carlo, vs NNV, vs nnenum
nnenum_time = [8.55966708494816;
    13.55657167301979;
    725.0579839419806;
    115.63208210794255;
    815.4161356510594;
    5.562871176050976;
    1.8183164629153907;
    5.3505009340588;
    22.871929796994664;
    2.9795201980741695];
folders = ["testpoint1_rot", "testpoint2", "testpoint3", "testpoint4", "testpoint5"...
    "testpoint6", "testpoint7", "testpoint8", "testpoint9", "testpoint10"];
nnv_time = zeros(10,1);
ff = 1;
mpath = "/home/manzand/Documents/MATLAB/AcasXu/data_reach/";
for fol=folders
    t_time = 0;
    for k=1:100
        load(mpath+fol+"/jat_"+string(k)+".mat",'time');
        t_time = t_time + time;
    end
    nnv_time(ff) = t_time;
    ff = ff+1;
end

% nnenum stats
max_nnenum = max(nnenum_time);
min_nnenum = min(nnenum_time);
avg_nnenum = mean(nnenum_time);
std_nnenum = std(nnenum_time);
% NNV stats
max_nnv = max(nnv_time);
min_nnv = min(nnv_time);
avg_nnv = mean(nnv_time);
std_nnv = std(nnv_time);

% Load simulation stats
load('../data_sim/SimRandom_all.mat');
% Print results
% disp("Total simulation time for "+string(N) + " simulations.");
total_time = sum(time_sim,2);
% disp(total_time);
% disp("Average simulation time for each test");
total_time_avg = total_time/N;
% disp(total_time_avg);
% Estimate simulation time for 400 million simulations
% disp("Estimated simulation time for 400 million simulations");
total_time_400m = total_time_avg * 1000000000/N; % 100 per 1 sqft
% disp(total_time_400m);

f = figure;
grid;
hold on;
plot([0;1;500000000],[0;sum(total_time_avg)/10;sum(total_time_400m)/10],'r','DisplayName','Sim');
plot([0;500000000],[avg_nnv;avg_nnv],'k','DisplayName','NNV');
plot([0;500000000],[avg_nnenum;avg_nnenum],'b','DisplayName','nnenum');
plot([0;500000000],[min_nnv;min_nnv],'--k');
plot([0;500000000],[min_nnenum;min_nnenum],'--b');
plot([0;500000000],[max_nnv;max_nnv],'--k');
plot([0;500000000],[max_nnenum;max_nnenum],'--b');
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha', 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color
legend('Location', 'Best');
xlabel('Number of Simulations');
ylabel('Time (s)');
ax = gca; % Get current axis
ax.GridColor = 'w'; % Set grid lines color
ax.XAxis.FontSize = 15; % Set font size of axis
ax.YAxis.FontSize = 15;
% set(gca, 'YScale', 'log');
% saveas(f,"../data_reach/figs/sim_vs_reach.png");

% Crossing point = 4.55 x 10^8 simulation (NNV), 114 simulations per sqft
% of the initial set

% Crossing point = 5.55 x 10^5 simulations (nnenum), 0.13875 simulations
% per sqft of the initial set


