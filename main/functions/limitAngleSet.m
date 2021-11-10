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
    if abs(a1) > (pi+1e10*eps)
        a3 = set_angleRange(a1);
    else
        a3 = a1;
    end
    if abs(a2) > (pi+1e10*eps)
        a4 = set_angleRange(a2);
    else
        a4 = a2;
    end
    if a3 > a4
        'Means that we need to split the set into 2';
%         angSetout = Star(a3,pi/2);
%         angSetout = [angSetout Star(-pi/2,a4)];
        angSetout = Star(a3,pi);
        angSetout = [angSetout Star(-pi,a4)];
    else
        angSetout = Star(a3,a4);
    end
end

