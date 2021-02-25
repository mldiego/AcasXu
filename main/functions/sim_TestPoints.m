function data = sim_TestPoints(init_set, test_point, timeV, titles,v_own, v_int)

% --------------------- Simulation --------------------
    % Setup the scenario
    % Controllers
    acasxu11 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_1_1_batch_2000.mat');
    acasxu21 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_2_1_batch_2000.mat');
    acasxu31 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_3_1_batch_2000.mat');
    acasxu41 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_4_1_batch_2000.mat');
    acasxu51 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_5_1_batch_2000.mat');
    % Normalization parameters
    scale_mean = [19791.0910000000,0,0,650,600];
    scale_range = [60261,6.28318530718000,6.28318530718000,1100,1200];
    data = zeros(length(timeV)-1,21); % Memory allocation
    % Plant parameters
    tr = 0.05; % reachability time step for plant
    tc = 2; % control period of the plant
    outCp = [0,0,0,0,0,0,1,0,0;0,0,0,0,0,0,0,1,0;0,0,0,0,0,0,0,0,1]; % Output matrix (distance,theta,head_diff)
    plant= NonLinearODE(9,1,test_point, tr, tc, outCp);
    % Simulation Parameters
    u4 = v_own; u5 = v_int;
    comb_init = init_set;
    adv_own = 0; % Initial advisory
    
    % Begin simulation
    for i=1:length(timeV)-1
        prev_adv = adv_own;
        % plants
         [~, yp] = plant.evaluate(comb_init, adv_own);
        comb_init = yp(end,:)';
        % Compute inputs
        ycp =  outCp*comb_init;
        % Computing u1 and u2 are key steps in reachability analysis
        u1 = ycp(1); % Except for sqrt, everything else could be done with AffineMap
        u2 = set_angleRange(ycp(2)); % atan2?
        u3 = set_angleRange(ycp(3)); % All ready for reachability analysis
        % Normalize inputs
        uN = [u1 u2 u3 u4 u5];
        uNN = uN - scale_mean;
        uNN = uNN./scale_range;
        uNN = uNN';
        % NN controller
        % 4) Compute outputs of NN controller
        if prev_adv == 0
            yNN = acasxu11.evaluate(uNN);
        elseif prev_adv == deg2rad(1.5)
            yNN = acasxu21.evaluate(uNN);
        elseif prev_adv == deg2rad(-1.5)
            yNN = acasxu31.evaluate(uNN);
        elseif prev_adv == deg2rad(3.0)
            yNN = acasxu41.evaluate(uNN);
        elseif prev_adv == deg2rad(-3.0)
            yNN = acasxu51.evaluate(uNN);
        else
            error('The previous advisory to the ownship is invalid')
        end
        % Normalize outputs (Do not really need it, the order is the same)
        adv_own = argmin_advise(yNN); % Key step in reachability analysis
        data_t = [comb_init' uN prev_adv, adv_own, yNN'];
        data(i,:) = data_t; % store data
    end
    
    % Plot ownship trajectories
    f = figure;
    plot(data(:,1),data(:,2),'--r');
    hold on;
    plot(data(:,4),data(:,5),'--k');
    scatter(init_set(1),init_set(2), 50, 'd', 'r', 'LineWidth',1);
    scatter(init_set(4),init_set(5), 50, 'd', 'k','LineWidth',1);
    title(titles);
    xlabel('X Position (ft)');
    ylabel('Y Position (ft)');
    legend('ownship','intruder');
end

