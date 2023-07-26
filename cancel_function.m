function opt_percent_des = cancel_function(x)
% This code sets a limit to the time it takes while calling SAM; because of
% its placement in the thread, this code also saves every iteration of the
% optimizer to a variable called iterations. 

maxTime= 120; % [seconds]
g = parfeval(@(x)call_SAM_function([x(1),x(2),x(3),x(4)]),1,x);
didFinish = wait(g, 'finished', maxTime);
% If the function did not finish, the prod inverse is set to a large number
if ~didFinish
    cancel(g)
    opt_percent_des = 1000;
    disp('Failed Simulation');
    disp(x);
else
    opt_percent_des = fetchOutputs(g);
    if opt_percent_des == 2000
        disp('Failed Simulation')
        disp(x)
    else 
        disp('Good Simulation')
        disp(x); 
    end
end
