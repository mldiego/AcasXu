function [allReach] = ReachACASXuNNCSb(init_set, minIdx,tf,reachMethod)
%% Reachability analysis of the closedLoop system of AcasXu with Dubins model
% We use the original 5 NNs corresponding to the vertical time = 0
% 
% --- INPUTS ---
%   1) init_set: initial state set for the plant (9 dimensional StarSet)
%   2) minIdx: previous advisory (index) of the ACASXu NNs
%   3) tf: final time for the set simulations (seconds)
%   4) reachMethod: reachability method for the neural networks 
%                  (exact-star or approx-star)
% --- OUTPUT ---
%   1) allReach: all reachable sets of the plant states during the set
%   simulation and summary of the reach computation (splits, advisories...)
%
% --- EXAMPLE ---
%   lb  = [x1;x2;x3;x4;x5;x6;x7;x8;x9];         (lower bound vector)
%   ub = [X1;X2;X3;X4;X5;X6;X7;X8;X9];   (upper bound vector)
%   allReach = ReachACASXuNNCS(Star(lb,ub), 1, 5, 'approx-star');

    %% Load components
    
    % Plant dynamics
    reachStep = 0.05;
    controlPeriod = 2;
    outputMat = eye(9);
    outputMat = outputMat(7:9,:);
    plant = NonLinearODE(9,1,@dynamics2D_dt_eps_new,reachStep,controlPeriod,outputMat);
    % Plant reach parameters
    error = 0.05;
    errorMat = error*ones(9,1);
    plant.options.maxError = errorMat;
    
    % Controllers
    acasxu11 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_1_1_batch_2000.mat');
    acasxu21 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_2_1_batch_2000.mat');
    acasxu31 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_3_1_batch_2000.mat');
    acasxu41 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_4_1_batch_2000.mat');
    acasxu51 = LoadAcasXu('../networks/nnv_format/ACASXU_run2a_5_1_batch_2000.mat');
    acasxuNNs.n11 = acasxu11;
    acasxuNNs.n21 = acasxu21;
    acasxuNNs.n31 = acasxu31;
    acasxuNNs.n41 = acasxu41;
    acasxuNNs.n51 = acasxu51;

    %% Reachability analysis (Multiple steps)
    Up = advisoryACAS(minIdx);
    times = 0:controlPeriod:tf+controlPeriod;
    % Initialize variables
    allReach.init_set = cell(1,length(times));
    allReach.Ro = cell(1,length(times));
    allReach.Unn = cell(1,length(times));
    allReach.yNN = cell(1,length(times));
    allReach.minIdx = cell(1,length(times));
    allReach.Up = cell(1,length(times));
    allReach.init_set{1} = init_set;
    % Start reachability loop
    for k=1:length(times)-1
        % Output set
        Ro = PlantOutSet(init_set, outputMat);
        % Normalize inputs
        Unn = normalizeInputsNN(Ro);
        % Compute NN outputs
        yNN = reachAcasXu(minIdx,Unn,acasxuNNs,reachMethod);
        % Compute advisory command
        minIdx = getMinIndexes(yNN);
        Up = advisoryACAS(minIdx);
        % Reachability step plant
        init_set = plantReach(plant, init_set, Up);
        % End cycle
        allReach.init_set{k+1} = init_set;
        allReach.Ro{k} = Ro;
        allReach.Unn{k} = Unn;
        allReach.yNN{k} = yNN;
        allReach.minIdx{k} = minIdx;
        allReach.Up{k} = Up;
    end

    allReach.int_reachSet = plant.intermediate_reachSet;
    %% Helper functions (simplify main code)
    % Compute state sets for the plant (all possible combs)
    function stateSet = plantReach(plant, init_set, Up)
        stateSet = [];
        for s=1:length(init_set)
            for u=1:length(Up)
                stateSet = [stateSet plant.stepReachStar(init_set(s),Up(u))];
            end
        end    
    end
% Compute plant outputs
    function Routf = PlantOutSet(init_set,outputMat)
        Rout = [];
        for o=1:length(init_set)
            Rout =[Rout init_set(o).affineMap(outputMat,[])];
        end
        % Limit ranges in angles
        Routf = [];
        for oi=1:length(Rout)
%           % Get correct ranges for inputs 2 and 3 (theta and psi)
            theta = limitAngleSet(Rout(oi).affineMap([0 1 0],[]));
            psi = limitAngleSet(Rout(oi).affineMap([0 0 1],[]));
            % Create new output sets based on correct input ranges
            [mdis,Mdis] = Rout(oi).getRange(1);
            for ko=1:length(theta)
                [mth,Mth] = theta(ko).getRanges;
                for kp=1:length(psi)
                    [mps,Mps] = psi.getRanges;
                    Routf = [Routf Star([mdis;mth;mps],[Mdis;Mth;Mps])];
                end
            end                  
        end
    end
% Normalize inputs
    function UNN = normalizeInputsNN(Ro)
        % Constants
        scale_mean = [19791.0910000000,0,0,650,600];
        scale_range = [60261,6.28318530718000,6.28318530718000,1100,1200];
        Unn45 = Star([0.142727;0.142727],[0.142727;0.142727]);
        % normalize
        UNN = [];
        for i=1:length(Ro)
            Un = Ro(i).affineMap(eye(3),-1*scale_mean(1:3)');
            Un = Un.affineMap(diag(1./scale_range(1:3)),[]);
            Un = Un.concatenate(Unn45);
            UNN = [UNN Un];
        end
    end
% Get min index for AcasXu networks (advisory command)
    function idxs = getMinIndexes(star_set)
        if length(star_set) > 1
            Xi = Star.merge_stars(star_set,1,'single');
        else
            Xi = star_set;
        end
        [mm,MM] = Xi.getRanges;
        [~, idx1] = min(mm);
        idxs = [];
        for idxm=1:length(mm)
            if mm(idxm) <= MM(idx1)
                idxs = [idxs idxm];
            end
        end
    end
% Set advisory to ownship
    function y = advisoryACAS(r)
        y = [];
        for l=1:length(r)
            if r(l) == 1
                y = [y Star(0,0)];
            elseif r(l) == 2
                y = [y Star(deg2rad(1.5),deg2rad(1.5))];
            elseif r(l) == 3
                y =  [y Star(deg2rad(-1.5),deg2rad(-1.5))];
            elseif r(l) == 4
                y =  [y Star(deg2rad(3),deg2rad(3))];
            elseif r(l) == 5
                y = [y Star(deg2rad(-3),deg2rad(-3))];
            end
        end
    end
% Choose NN to execute
    function y = reachAcasXu(advise,Unn,acasNNs,method)
        y = [];
        for a=1:length(advise)
            if advise(a) == 1
                y = [y acasNNs.n11.reach(Unn,method)];
            elseif advise(a) == 2
                y = [y acasNNs.n21.reach(Unn,method)];
            elseif advise(a) == 3
                y = [y acasNNs.n31.reach(Unn,method)];
            elseif advise(a) == 4
                y = [y acasNNs.n41.reach(Unn,method)];
            elseif advise(a) == 5
                y = [y acasNNs.n51.reach(Unn,method)];
            end
        end
    end
end