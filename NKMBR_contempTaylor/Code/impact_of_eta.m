%% impact of asynchronous updating and degree of rationality on the stability.
clc;
clear;
load('OSR_contempTR_eta0.75_250sim_T260.mat')
%% I: Parameterization

T = 500; % length of the time period
nbrsim = 1000; % number of simulation runs 
del_pi = optimal_par(1); % sensitivity of the central bank to changes in inflation
del_x =  optimal_par(2);  % sensitivity of the central bankt to changes in the output gap
eta =[0:0.1:1]; % asynchronous updating parameter
phi = [1:1:20]; % intensity of choice paramter(degree of rationality)
std_mu = 0.15; std_kap = 0.15; std_nu = 0.15; % standard deviation of the shocks

ex_shock = [0 0]; % exogenous shock in t = 40; we do not need a shock
%% II: Average behavior of the state variables
% preallocation for the loop
pi_t = NaN(nbrsim,T);
x_t = NaN(nbrsim,T);
i_t = NaN(nbrsim,T);

var_pi = NaN(nbrsim,1);
var_x = NaN(nbrsim,1);
Loss = NaN(nbrsim,1);
Loss_average = NaN(length(del_pi),length(del_x));

% Loop 
M =[];
for b = 1:length(phi)
    phi_l = phi(b)
    for d = 1:length(eta)
        eta_l = eta(d);
    
        parfor i = 1:nbrsim  

            [pi_t(i,:),x_t(i,:),i_t(i,:)] = nkmbr_function_contemp_final(del_pi,del_x,T,[normrnd(0,std_mu,[1,T]);normrnd(0,std_kap,[1,T]);normrnd(0,std_nu,[1,T])],ex_shock(1),eta_l,phi_l);
                    
        end
            for i = 1:nbrsim
                var_pi(i,1) = var(pi_t(i,1:T));
                var_x(i,1) = var(x_t(i,1:T));
                Loss(i,1) = var_pi(i,1) + 1/2*var_x(i,1);
            end
          Loss_average(b,d) = average(Loss(:,1));
          M = [M; phi_l eta_l Loss_average(b,d)];
    end
end
if del_pi == 1.5 && del_x == 0.5
    save('impact_of_eta_contempTR_basic.mat','Loss_average','M','eta');
else
    save('impact_of_eta_contempTR_optimal.mat','Loss_average','M','eta');
end