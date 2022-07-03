ReadMe file: 

The folder Code contains the following files:

The function nkmbr_function_backward_final.m is the baseline model with a backward-looking TR:
	As an input, the functions needs the interest rate parameters, the time horizon, 
	a definition of the shock process, the asynchronous updating parameter eta
	and the degree of rationality phi. 
	The Outputs are the state variables and the fractions of agents using certain heuristics.

	Furthermore the function calls the function atracval_function.m:
		As an input the atracval function needs the past "atractivity values",
		the realization of the inflation rate and the ouput gap for period t-1,
		the corresponding expectations about the period t-1 and the memory parameter zeta.
		The Outputs are the attractivity values for the period t.

	Moreover the function calls the function frac_function.m:
		Input factors are the past fractions the recent attractivity values and
		the intensity of choice paramter as well as the asynchronous updating
		parameter
		The Outputs are the fractions of agents using certain heuristics.


The MATLAB file OSR_backward.m:
	derives the Optimal Simple Rule parameterization of the baseline model with backward-looking TR. 
	This is done by calculating the loss for all parameter combinations of delta_pi and delta_x.
	The parameters used in the seminar work are saved in OSR_backwardTR_eta0.75_250sims_final.mat

	
