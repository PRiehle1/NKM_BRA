% Change the names of the Input arguments

%% Function for the atractivity value
function [A_t_j_1,A_t_j_2,A_t_j_3,A_t_j_4] = atracval_function(A_t_j_1_minusone,A_t_j_2_minusone,A_t_j_3_minusone,A_t_j_4_minusone, exp_t_j_1, exp_t_j_2, exp_t_j_3, exp_t_j_4, j_t,zet)
% This function derives the atractivity values which correspond to the
% used heuristics, in case we consider 4 heuristics. 
%
% The functions output are the atractivity values for each heuristic. 
% As an Input we need the past value A_t_j_1:4 of each heuristic, the
% expected value of j = [pi,x] for time t-1  and the realization of j in time
% t-1 
    A_t_j_1 = -1*((j_t - exp_t_j_1)^2) + zet * A_t_j_1_minusone;
    A_t_j_2 = -1*((j_t - exp_t_j_2)^2) + zet * A_t_j_2_minusone;
    A_t_j_3 = -1*((j_t - exp_t_j_3)^2) + zet * A_t_j_3_minusone;
    A_t_j_4 = -1*((j_t - exp_t_j_4)^2) + zet * A_t_j_4_minusone;
    
    
end