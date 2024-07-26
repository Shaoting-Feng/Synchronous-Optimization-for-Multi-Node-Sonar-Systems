function [stateB] = swB
    p = rand(1,1);
    if p < 0.45
        stateB = 1;
    else
        stateB = 2;
    end
