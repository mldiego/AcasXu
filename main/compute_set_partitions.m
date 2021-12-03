function sets = compute_set_partitions(init_point,x_unc,y_unc,Npx,Npy)
% Compute initial sets and partition based on initial test point scenario
    % init_point = initial states
    % x_unc = initial uncertainty in x position
    % y_unc = initial uncertainty in y position
    % Npx = number of partitions in the x variable (x1)
    % Npy = number of partitions in the y variable (x2)
    x_min = init_point(1) - x_unc;
    x_max = init_point(1) + x_unc;
    y_min = init_point(2) - y_unc;
    y_max = init_point(2) + y_unc;
    x_dist = 2*x_unc/Npx;
    y_dist = 2*y_unc/Npy;
    x_bounds = x_min:x_dist:x_max;
    y_bounds = y_min:y_dist:y_max;
    % Compute the partitions now
    sets = [];
    xi = init_point(4:6)';
    for xx = 1:length(x_bounds)-1
        for yy = 1:length(y_bounds)-1
            xc = (x_bounds(xx)+x_bounds(xx+1))/2;
            yc = (y_bounds(yy)+y_bounds(yy+1))/2;
            xo = [xc;yc;init_point(3)];
            [x7,x8,x9] = environment(xo,xi);
            x_temp = [xo;xi;x7;x8;x9];
            [lb,ub] = calc_uncB(x_temp,x_dist/2,y_dist/2);
            sets = [sets Star(lb,ub)];
        end
    end
end

