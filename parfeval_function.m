function [LCOH] = parfeval_function(x, varargin) 
maxTime= 60; 
    g = parfeval( @nSCA_fun, 2, x);
    didFinish = wait(g, 'finished', maxTime);
    if ~didFinish
        cancel(g)
        LCOH = 10^10; 
    else
        LCOH = fetchOutputs(g);
    end

