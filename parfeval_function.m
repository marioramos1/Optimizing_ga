function [LCOH] = parfeval_function(x, varargin) 
% This code sets a limit to the time it takes while calling nSCA_fun. 
maxTime= 60; % [seconds]
    g = parfeval( @nSCA_fun, 1, x);
    didFinish = wait(g, 'finished', maxTime);
% If the function did not finish, the LCOH is set to a large number
    if ~didFinish
        cancel(g)
        LCOH = 10^10; 
    else % the function pulls the output of nSCA_fun
        LCOH = fetchOutputs(g);
    end
