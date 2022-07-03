clc;
clear;
%% Optimal Simple Rule for the BR model
                                                                                                                                                        %
%% I: Parameterization

T = 260; % length of the time period
nbrsim = 250; % number of simulation runs 

% for the OSR parameter set max del_pi and max del_x to 6 and to 3 for the
% contourplot
del_pi = [0:0.1:6]; % sensitivity of the central bank to changes in inflation
del_x =  [0:0.1:6];  % sensitivity of the central bankt to changes in the output gap

eta = 0.75;           % asynchronous updating paramter 
phi = 10;             % degree of rationality
% shock process
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

% d -> x 
% b -> y

for b = 1:size(del_pi,2)
    del_pi_l = del_pi(b)
        for d = 1:length(del_x)
            del_x_l = del_x(d); 
            
                parfor i = 1:nbrsim  
                  
                    [pi_t(i,:),x_t(i,:),i_t(i,:)] = nkmbr_function_contemp_final(del_pi_l,del_x_l,T,[normrnd(0,std_mu,[1,T]);normrnd(0,std_kap,[1,T]);normrnd(0,std_nu,[1,T])],ex_shock(1),eta,phi);
                   
                end
                    for i = 1:nbrsim
                        var_pi(i) = var(pi_t(i,20:T));
                        var_x(i) = var(x_t(i,20:T));
                        Loss(i,1) = var_pi(i,1) + 1/2*var_x(i,1);
                    end
          Loss_average(b,d) = mean(Loss(:,1));
          M = [M; del_pi_l del_x_l Loss_average(b,d)];
        end
end

%% III: Derive the minimal Loss
min_L = min(M(:,3));
for i = 1:size(M,1)
    if min_L == M(i,3)
        optimal_par = M(i,:);
        display(M(i,:))
    end
end
%% IV: Save Paramter

if max(del_pi) == 3
    save('OSR_contempTR_eta0.75_250sim_contour.mat','optimal_par','Loss_average','M')
else
    save('OSR_contempTR_eta0.75_250sim_T260.mat','optimal_par','Loss_average','M')
end