%% Function to derie the fractions of agents using certain heruristics
function [ome_t_i_1, ome_t_i_2, ome_t_i_3, ome_t_i_4] = frac_function(A_t_heu1,A_t_heu2,A_t_heu3,A_t_heu4,ome_tminus1_i_1,ome_tminus1_i_2,ome_tminus1_i_3,ome_tminus1_i_4,eta,phi)
% This function derives the frations of agents by a discrete choice method 
% To account for possible NaNs the maximum is substracted
% Input factors are the past fractions the recent attractivity values and
% the intensity of choice paramter as well as the asynchronous updating
% parameter


    %Softmax Function
    vec = [phi*A_t_heu1 phi*A_t_heu2 phi*A_t_heu3 phi*A_t_heu4]; % Done to account for possible NANs 
    max_vec = max(vec);
    %Discrete Choice parameter
    ome_t_i_1 = (eta* ome_tminus1_i_1) + (1-eta)*(exp(phi*A_t_heu1-max_vec)/(exp(phi*A_t_heu1-max_vec) + exp(phi*A_t_heu2-max_vec) + exp(phi*A_t_heu3-max_vec) + exp(phi*A_t_heu4-max_vec)));
    ome_t_i_2 = (eta* ome_tminus1_i_2) + (1-eta)*(exp(phi*A_t_heu2-max_vec)/(exp(phi*A_t_heu1-max_vec) + exp(phi*A_t_heu2-max_vec) + exp(phi*A_t_heu3-max_vec) + exp(phi*A_t_heu4-max_vec)));
    ome_t_i_3 = (eta* ome_tminus1_i_3) + (1-eta)*(exp(phi*A_t_heu3-max_vec)/(exp(phi*A_t_heu1-max_vec) + exp(phi*A_t_heu2-max_vec) + exp(phi*A_t_heu3-max_vec) + exp(phi*A_t_heu4-max_vec)));
    ome_t_i_4 = (eta* ome_tminus1_i_4) + (1-eta)*(exp(phi*A_t_heu4-max_vec)/(exp(phi*A_t_heu1-max_vec) + exp(phi*A_t_heu2-max_vec) + exp(phi*A_t_heu3-max_vec) + exp(phi*A_t_heu4-max_vec)));
       

end