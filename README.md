# Optimizing_ga
I am trying to use the genetic algorithm in MATLAB with two input parameters. 

I keep receiving the same error message. It reads: 
Error using parallel.Future/fetchOutputs
One or more futures resulted in an error.

Error in parfeval_function (line 9)
        LCOH = fetchOutputs(g);

Error in Optimizing_nSCA>@(x)parfeval_function(x(1),x(2)) (line 39)
lcoh_optim = ga(@(x) parfeval_function(x(1),x(2)),2,A,b,Aeq,beq,lb,ub,nonlcon, ...

Error in createAnonymousFcn>@(x)fcn(x,FcnArgs{:}) (line 11)
fcn_handle = @(x) fcn(x,FcnArgs{:});

Error in fcnvectorizer (line 19)
            y(i,:) = feval(fun,(pop(i,:)));

Error in gaminlppenaltyfcn

Error in gapenalty

Error in makeState (line 76)
            Score = FitnessFcn(state.Population(initScoreProvided+1:end,:));

Error in galincon (line 24)
state = makeState(GenomeLength,FitnessFcn,Iterate,output.problemtype,options);

Error in gapenalty

Error in ga (line 406)
    [x,fval,exitFlag,output,population,scores] = gapenalty(FitnessFcn,nvars,...

Error in Optimizing_nSCA (line 39)
lcoh_optim = ga(@(x) parfeval_function(x(1),x(2)),2,A,b,Aeq,beq,lb,ub,nonlcon, ...

Caused by:
    Too many output arguments.
    Failure in user-supplied fitness function evaluation. GA cannot continue.
    Failure in initial user-supplied fitness function evaluation. GA cannot continue.
