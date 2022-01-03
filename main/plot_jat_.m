function plot_jat_(data_folder,tc)
% load('../data_sim/SimRandom_opp_nnenum.mat');
data_files = dir(data_folder);
% Define axis limits and ticks for consistency
xp = {[-20000 -10000 0 10000 20000];
    [-10000 -5000 0 5000 10000];
    [-5000 0 5000];
    [-5000 -2500 0 2500 5000 7500];
    [-5000 0 5000];
    [-10000 0 10000];
    [-30000 -20000 -10000 0 10000];
    [-10000 -5000 0 5000];
    [-10000 -5000 0 5000 10000];
    [-5000 0 5000 10000]};
yp = {[40000 50000 60000 70000];
    [10000 15000 20000 25000 30000];
    [20000 22000 24000 26000 28000 30000 32000 34000];
    [2000 4000 6000 8000 10000 12000 14000];
    [120000 122000 124000 126000 128000 130000 132000 134000 136000];
    [10000 15000 20000 25000 30000 35000 40000];
    [50000 60000 70000 80000 90000];
    [25000 27500 30000 32500 35000 37500 40000 42500];
    [15000 20000 25000 30000 35000];
    [30000 32500 35000 37500 40000 42500 45000 47500]};
xp_label = {{'20000', '10000', '0', '-10000', '-20000'};
    {'-10000' '-5000' '0' '5000' '10000'};
    {'5000' '0' '5000'};
    {'-5000' '-2500' '0' '2500' '5000' '7500'};
    {'-5000' '0' '5000'};
    {'-10000' '0' '10000'};
    {'-30000' '-20000' '-10000' '0' '10000'};
    {'-10000' '-5000' '0' '5000'};
    {'10000' '-5000' '0' '5000' '10000'};
    {'-5000' '0' '5000' '10000'}};
yp_label = {{'40000' '50000' '60000' '70000'};
    {'10000' '15000' '20000' '25000' '30000'};
    {'20000' '22000' '24000' '26000' '28000' '30000' '32000' '34000'};
    {'2000' '4000' '6000' '8000' '10000' '12000' '14000'};
    {'120000' '122000' '124000' '126000' '128000' '130000' '132000' '134000' '136000'};
    {'10000' '15000' '20000' '25000' '30000' '35000' '40000'};
    {'50000' '60000' '70000' '80000' '90000'};
    {'25000' '27500' '30000' '32500' '35000' '37500' '40000' '42500'};
    {'15000' '20000' '25000' '30000' '35000'};
    {'30000' '32500' '35000' '37500' '40000' '42500' '45000' '47500'}};
xl = [[-20500 26000];[-12000 11400];[-7000 7000];[-6000 8000];[-8000 8000];
    [-19900 13500];[-33000 15000];[-11700 8500];[-13000 12000];[-8200 12500]];
yl = [[30500 79900];[9000 33000];[19200 34070];[0 14300];[118750 136300];
    [9000 43000];[47000 96000];[23200 43700];[13000 37500];[27600 48500]];
% % set(groot,'defaultFigureVisible','on')
f = figure;
hold on;
grid;
set(gcf,'Color',[1 1 1]);
set(gca, 'GridAlpha', 1); % Set transparency of grid
set(gca, 'color', [17 17 17]/19); % Set background color 
set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
for k=3:length(data_files)
    aaa = load(string(data_files(k).folder)+ "/" + string(data_files(k).name)); % variables: output
    output = aaa.output;
%     N = length(output);
%     f = figure;
%     hold on;
%     grid;
%     set(gcf,'Color',[1 1 1]);
%     set(gca, 'GridAlpha', 1); % Set transparency of grid
%     set(gca, 'color', [17 17 17]/19); % Set background color 
%     set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
    ii = 1; % Select set
    for i=1:length(output.minIdx)
        Nc = size(output.combos{i});
        for kk=1:Nc(1)
            temp = output.combos{i};
            Star.plotBoxes_2D_noFill(output.step_sets(ii),1,2,set_color(temp(kk,1)));
            ii = ii+1;
        end
    %     Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.1);
    end
    Star.plotBoxes_2D_noFill(output.step_sets(ii:end),1,2,[0.4, 0.4, 0.4]);
%     xlim(xl(tc,:));
%     ylim(yl(tc,:));
%     xticks(xp{tc});
%     yticks(yp{tc});
%     xticklabels(xp_label{tc,:});
%     yticklabels(yp_label{tc,:});
%     xlabel('X Position (ft)');
%     ylabel('Y Position (ft)');
%     ax = gca; % Get current axis
%     ax.GridColor = 'w'; % Set grid lines color
%     ax.XAxis.FontSize = 15; % Set font size of axis
%     ax.YAxis.FontSize = 15;
%     saveas(f,"../data_reach/figs/TestPoint"+string(tc)+"both.png");

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % f = figure;
    % hold on;
    % grid;
    % set(gcf,'Color',[1 1 1]);
    % set(gca, 'GridAlpha' , 1); % Set transparency of grid
    % set(gca, 'color', [17 17 17]/19); % Set background color 
    % set(gcf,'inverthardcopy','off'); % Enable saving the figure as it is
    % for i=1:N
    %     % Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,[1 0.4 0.6],0.1);
    %     Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
    % end
    % xlabel('X Position (ft)');
    % ylabel('Y Position (ft)');
    % ax = gca; % Get current axis
    % ax.GridColor = 'w'; % Set grid lines color
    % ax.XAxis.FontSize = 15; % Set font size of axis
    % ax.YAxis.FontSize = 15;
    % axis(ax,'equal');
    % xlim(ax, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.02)
    % ylim(ax, ylim(ax) + [-1,1]*range(ylim(ax)).* 0.02)
    % outerpos = ax.OuterPosition;
    % ti = ax.TightInset; 
    % left = outerpos(1) + ti(1);
    % bottom = outerpos(2) + ti(2);
    % ax_width = outerpos(3) - ti(1) - ti(3);
    % ax_height = outerpos(4) - ti(2) - ti(4);
    % ax.Position = [left bottom ax_width ax_height];
    % saveas(f,"../data_reach/figs/TestPoint"+string(tc)+"both_zoom.png");
end
ylim(xl(tc,:));
xlim(yl(tc,:));
yticks(xp{tc});
xticks(yp{tc});
yticklabels(xp_label{tc,:});
xticklabels(yp_label{tc,:});
ylabel('X Position (ft)');
xlabel('Y Position (ft)');
ax = gca; % Get current axis
ax.GridColor = 'w'; % Set grid lines color
ax.XAxis.FontSize = 15; % Set font size of axis
ax.YAxis.FontSize = 15;
camroll(90)
view(-90,90);
saveas(f,"../data_reach/figs/TestPoint"+string(tc)+"reach.png");
% for k=1:N    
%     plot(random_sim{tc,k}(:,1),random_sim{tc,k}(:,2), 'Color', [1, 0, 0, 0.2]);
% end
% saveas(f,"../data_reach/figs/TestPoint"+string(tc)+"reach_sim.png");

function cl = set_color(min_idx)
    if min_idx == 1 % COC (gray)
        cl = [0.4, 0.4, 0.4];
    elseif min_idx == 2 % Weak left (cyan)
        cl = [0, 0.7, 1];
    elseif min_idx == 3 % Weak right (light red)
        cl = [1, 0.6, 0.6];
    elseif min_idx == 4 % Strong left (blue)
        cl = [0, 0, 1];
    elseif min_idx == 5 % Strong right (red)
        cl = [1, 0, 0];
    else % COC
        cl = [0.4, 0.4, 0.4];
    end
end

end

