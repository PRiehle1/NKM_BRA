ReadMe file: 

The folder Code contains the following files:

The function nkmbr_function_contemp_final.m is the baseline model from the seminar paper:
	As an input, the functions needs the interest rate parameters, the time horizon, 
	a definition of the shock process,
	for the IRFs an exogenous shock (else set to zero), the asynchronous updating parameter eta
	and the degree of rationality. 
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

The MATLAB file heuristics_state_variables_plot.m:
	uses the function nkmbr_function_contemp_final.m to plot the development of the state variables
	and the fractions for the inflation rate and the output gap 
	for one simulation run (compare Figure 1. and Figure 2. of the seminar paper).

The MATLAB file imp_ex_shock.m:
	derrives the average impulse response function for a given number of simulations
	of the nkmbr_function_contemp_final.m function (compare Figure 3 of the seminar paper).
	Here the parameter ex_shock is set equal to 0.3

The MATLAB file OSR_contemp.m:
	derives the Optimal Simple Rule parameterization of the baseline model. 
	This is done by calculating the loss for all parameter combinations of delta_pi and delta_x.
	The parameters used in the seminar work are saved in OSR_contempTR_eta0.75_250sim_T260_final.mat

	
The MATLAB file contourplot_del_pi_del_x:
	plots a contourplot for the loss values obtained from OSR_contemp.m 
	and the corresponding paramter parameterization (compare Figure 4 of the seminar paper).

	
The MATLAB file impact_of_eta.m:
	derives the loss values for different parameterizations of the asynchronous updating parameter eta 
	and the degree of rationality phi. 

The MATLAB file contourplot_eta_phi.m:
	plots a contorplot for the loss values obtained from impact_of_eta.m
	and the corresponding parametrization of eta and phi (compare Figure 5 from the seminar paper).

The folder Figures contains the Figures showed in the seminar paper.
