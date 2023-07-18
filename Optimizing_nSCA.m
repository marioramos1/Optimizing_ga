% This script employs an optimizer from the Optimization Toolbox to find an
% the set of parameters that minimizes the LCOH of the solar system
clear,clc

%% SET UP OPTIMIZER

% Set the initial guess for the parameters to be optimized
%    ga does not use initial conditions. 
x0 = [4 6];

% Set the lower bounds for the parameters to be optimized
lb = [2 0]; 

% Set the upper bounds for the parameters to be optimized
ub = [10 36]; 

% Set any linear inequality constraints
%   Here we set that Tout > T_in_DesignPoint
A  = [];
b  = [];

% Set any linear equality constraints
%   There are no equality constraints
Aeq = [];
beq = [];

% Set any nonlinear constratins
%   There are not nonlinear constraints
nonlcon = [];

% Set any integer only values of x
%   The only value of x will be an integer value
intcon  = [1 2]; 

% Set options for the optimization solver
optim_options = optimoptions("ga","Display","iter");

%% RUN THE OPTIMIZER
%fffff = @(x) parfeval_function([x(1), x(2)],x(3));
%ga(fffff, 3)


[x, lcoh_optim] = ga(@(x) parfeval_function([x(1),x(2)]),2,A,b,Aeq,beq,lb,ub,nonlcon, ...
    intcon,optim_options);
