function subregions = create_regions(length1, length2, angle1, angle2, d_diff, a_diff)
    % Create multiple subregions
    % length in ft
    % angles in degrees
%     d_diff = 200; % intervals of 200ft
%     a_diff = 0.5; % interval of 0.5 degrees
    % Create dsitance vector to divide the initial distance
    if length1 > length2
        vL = length2:d_diff:length1;
    else
        vL = length1:d_diff:length2;
    end
    % Create theta vector to divide initial theta region
    if angle1 > angle2
        vA = angle2:a_diff:angle1;
    else
        vA = angle1:a_diff:angle2;
    end
%     disp(vA)
%     disp(vL);
    % Create all the possible regions with theta and distance vectors
    init_set = [];
    for i=1:length(vL)-1
        for k=1:length(vA)-1
            xu = cosd(vA(k))   * vL(i+1);   % Upper x bound for intruder
            xl = cosd(vA(k+1)) * vL(i);     % Lower x bound for intruder
            yl = sind(vA(k))   * vL(i);     % Lower y bound for intruder
            yu = sind(vA(k+1)) * vL(i+1);   % Upper y bound for intruder
            lb = [0;0;0;xl;yl;-pi;vL(i);deg2rad(vA(k));pi];
            ub = [0;0;0;xu;yu;-pi;vL(i+1);deg2rad(vA(k+1));pi];
            Sa = Star(lb,ub);
            init_set = [init_set Sa];
        end
    end
    subregions = init_set;
end