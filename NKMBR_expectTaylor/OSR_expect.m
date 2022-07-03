clc;
clear;
%% Optimal Simple Rule for the BR model with forward-looking TR
                                                                                                                                                        %
%% I: Parameterization

T = 260; % length of the time period
nbrsim = 250; % number of simulation runs 
del_pi = [0:0.1:6]; % sensitivity of the central bank to changes in inflation
del_x =  [0:0.1:6];  % sensitivity of the central bankt to changes in the output gap
eta = 0.75;         % asynchronous updating parameter
phi = 10;           % intensity of choice paramter(degree of rationality
std_mu = 0.15; std_kap = 0.15; std_nu = 0.15; % standard deviation of the shocks


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

for b = 1:size(del_pi,2)
    del_pi_l = del_pi(b)
        for d = 1:length(del_x)
            del_x_l = del_x(d); 
            
                parfor i = 1:nbrsim  

                    [pi_t(i,:),x_t(i,:),i_t(i,:)] = nkmbr_function_expect_final(del_pi_l,del_x_l,T,[normrnd(0,std_mu,[1,T]);normrnd(0,std_kap,[1,T]);normrnd(0,std_nu,[1,T])],eta,phi);
                    
                end
                    for i = 1:nbrsim
                         var_pi(i,1) = var(pi_t(i,1:T));
                         var_x(i,1) = var(x_t(i,1:T));
                         Loss(i,1) = var_pi(i,1) + 1/2*var_x(i,1);
                    end
          Loss_average(b,d) = average(Loss(:,1));
          M = [M; del_pi_l del_x_l Loss_average(b,d)];
        end
end


min_L = min(M(:,3));
for i = 1:size(M,1)
    if min_L == M(i,3)
        optimal_par = M(i,:);
        display(M(i,:))
    end
end
save('OSR_expectTR_eta0.75_250sims.mat','optimal_par','Loss_average','M')