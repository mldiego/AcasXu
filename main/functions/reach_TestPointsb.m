function [allReach] = reach_TestPointsb(init_set, test_point, minIdx,tf,reachMethod,v_own, v_int)
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
%   allReach = reach_TestPointsb(Star(lb,ub), 1, 5, 'approx-star',v_own,v_int);

    %% Load components
    
    % Plant dynamics
    reachStep = 0.05;
    controlPeriod = 2;
    outputMat = eye(9);
    outputMat = outputMat(7:9,:);
    plant = NonLinearODE(9,1,test_point,reachStep,controlPeriod,outputMat);

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
    step_sets = [init_set];
    allReach.combos = cell(1,length(times));
    cmbs = [minIdx,1,minIdx,1]; % Prev advisory, output set, current advisory, state set
    % Start reachability loop
    for k=1:length(times)-1
        % Output set
        [Ro,cmbs] = PlantOutSet(init_set, outputMat,cmbs);
        % Normalize inputs
        Unn = normalizeInputsNN(Ro,v_own,v_int);
        % Compute NN outputs
        yNN = reachAcasXu(Unn,acasxuNNs,reachMethod,cmbs);
        % Compute advisory command
        [minIdx,cmbs] = getMinIndexes(yNN,cmbs);
        Up = advisoryACAS(minIdx);
        % Reachability step plant
        [init_set,cmbs] = plantReach(plant, init_set, cmbs);
        step_sets = [step_sets init_set];
        % End cycle
        allReach.init_set{k+1} = init_set;
        allReach.Ro{k} = Ro;
        allReach.Unn{k} = Unn;
        allReach.yNN{k} = yNN;
        allReach.minIdx{k} = minIdx;
        allReach.Up{k} = Up;
        allReach.combos{k} = cmbs;
    end
    allReach.step_sets = step_sets;
    allReach.int_reachSet = plant.intermediate_reachSet;
    
    %% Helper functions (simplify main code)
    % Compute state sets for the plant (all possible combs)
    function [stateSet,new_combos] = plantReach(plant, init_set, combos)
        stateSet = [];
        new_combos = [];
        seen_combos = [];
        mmm = 1;
        for j=1:size(combos,1)
            sFlag = false;
            if seen_combos
                aaa = find(combos(j,3)==seen_combos(:,1));
                bbb = find(combos(j,4)==seen_combos(:,2));
                if sum(ismember(aaa,bbb))
                    sFlag = true;
                end
            end
            if ~sFlag
                pointSet = plant.stepReachStar(init_set(combos(j,4)),advisoryACAS(combos(j,3)));
                for jk=1:length(pointSet)
                    ccc = [combos(j,3), mmm, combos(j,3), mmm];
                    new_combos = [new_combos; ccc];
                    mmm = mmm + 1;
                    seen_combos = [seen_combos; combos(j,(3:4))];
                end
                stateSet = [stateSet pointSet];
            end
        end
    end
% Compute plant outputs
    function [Routf,new_cmbs] = PlantOutSet(init_set,outputMat,combos)
        Rout = [];
        new_cmbs = [];
        for o=1:length(init_set)
            Rout =[Rout init_set(o).affineMap(outputMat,[])];
        end
        % Limit ranges in angles
        Routf = [];
        mmm = 1;
        setIdx = 0;
        for oi=1:size(combos,1)
%           % Get correct ranges for inputs 2 and 3 (theta and psi)
            theta = limitAngleSet(Rout(oi).affineMap([0 1 0],[]));
            psi = limitAngleSet(Rout(oi).affineMap([0 0 1],[]));
            setIdx = setIdx+1;
            % Create new output sets based on correct input ranges
            [mdis,Mdis] = Rout(oi).getRange(1);
            for ko=1:length(theta)
                [mth,Mth] = theta(ko).getRanges;
                for kp=1:length(psi)
                    [mps,Mps] = psi.getRanges;
                    Routf = [Routf Star([mdis;mth;mps],[Mdis;Mth;Mps])];
                    ccc = [combos(oi), mmm, combos(oi), setIdx];
                    mmm = mmm+1;
                    new_cmbs = [new_cmbs;ccc];
                end
            end                  
        end
    end
% Normalize inputs
    function UNN = normalizeInputsNN(Ro,v_own,v_int)
        % Constants
        scale_mean = [19791.0910000000,0,0,650,600];
        scale_range = [60261,6.28318530718000,6.28318530718000,1100,1200];
        Unn45 = Star([v_own;v_int],[v_own;v_int]);
        Unn45 = Unn45.affineMap(eye(2),-1*scale_mean(4:5)');
        Unn45 = Unn45.affineMap(diag(1./scale_range(4:5)),[]);
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
    function [idxs,new_cmbs] = getMinIndexes(star_set,combos)
        new_cmbs = [];
%         if length(star_set) > 1
%             Xi = Star.merge_stars(star_set,1,'single');
%         else
%             Xi = star_set;
%         end
        for kc = 1:size(combos,1)
            xSs = star_set{kc};
            if length(xSs) > 1
                Xi = Star.merge_stars(xSs,1,'single');
            else
                Xi = xSs;
            end
%             Xi = star_set(combos(kc,2));
            [mm,MM] = Xi.getRanges;
            [~, idx1] = min(mm);
            idxs = [];
            for idxm=1:length(mm)
                if mm(idxm) <= MM(idx1)
                    idxs = [idxs idxm];
                    ccc = [combos(kc,1), combos(kc,2), idxm, combos(kc,4)];
                    new_cmbs = [new_cmbs; ccc];
                end
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
    function y = reachAcasXu(Unn,acasNNs,method,combos)
        y = {};
        for a=1:size(combos,1)
            if combos(a,1) == 1
                ya = acasNNs.n11.reach(Unn(combos(a,2)),method);
                y{a} = ya;
            elseif combos(a,1) == 2
                ya = acasNNs.n21.reach(Unn(combos(a,2)),method);
                y{a} = ya;
            elseif combos(a,1) == 3
                ya = acasNNs.n31.reach(Unn(combos(a,2)),method);
                y{a} = ya;
            elseif combos(a,1) == 4
                ya = acasNNs.n41.reach(Unn(combos(a,2)),method);
                y{a} = ya;
            elseif combos(a,1) == 5
                ya = acasNNs.n51.reach(Unn(combos(a,2)),method);
                y{a} = ya;
            end
        end
    end
end