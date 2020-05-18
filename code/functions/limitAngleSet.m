function [angSetout] = limitAngleSet(inputAngSet)
% angSetout = limitAngleSet(inputAngSet)
% -- INPUT --
% inputAngSet = one star set, angle set in radians
% -- OUTPUT -- 
% angSetout = star set output for angle range between -pi and pi
    if string(class(inputAngSet))~= "Star" || length(inputAngSet) > 1
        error('Wrong input format. Input set must be a single Star set')
    end
    [a1,a2] = inputAngSet.getRanges;
    a3 = set_angleRange(a1);
    a4 = set_angleRange(a2);
    if a3 > a4
        'Means that we need to split the set into 2';
        angSetout = Star(a3,pi/2);
        angSetout = [angSetout Star(-pi/2,a4)];
    else
        angSetout = Star(a3,a4);
    end
end

