function y = argmin_advise(u)
    [~,i] = min(u);
    r = rem(i,5);
    if r == 1
        y = 0;
    elseif r == 2
        y = deg2rad(1.5);
    elseif r == 3
        y = deg2rad(-1.5);
    elseif r == 4
        y = deg2rad(3.0);
    elseif r == 0
        y = deg2rad(-3.0);
    end
end

