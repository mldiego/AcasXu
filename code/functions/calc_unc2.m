function [lb,ub] = calc_unc2(init_state,unc)
%CALC_UNC 
% Compute the bounds for an initial state given some uncertainty in the
% ownship's positions
lb = init_state;
ub = init_state;
ub(1) = ub(1) + unc;
%ub(2) = ub(2) + unc;
a = zeros(1,4); b = a; c = a;
[a(1), b(1), c(1)] = environment(lb(1:3), lb(4:6));
[a(2), b(2), c(2)] = environment(lb(1:3), ub(4:6));
[a(3), b(3), c(3)] = environment(ub(1:3), lb(4:6));
[a(4), b(4), c(4)] = environment(ub(1:3), ub(4:6));
aMax = max(a); aMin = min(a); % x7 bounds
bMax = max(b); bMin = min(b); % x8 bounds
cMax = max(c); cMin = min(c); % x9 bounds
lb(7:9) = [aMin; bMin; cMin]; % Lower bound with uncertainty
ub(7:9) = [aMax; bMax; cMax]; % Upper bound with uncertainty
end

