function [stateA] = swA
    p = rand(1,1);
    if p < 0.20
        stateA = 1;
    elseif p < 0.35
        stateA = 2;
    else 
        stateA = 3;
    end
