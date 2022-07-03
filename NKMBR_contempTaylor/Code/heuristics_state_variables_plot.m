%% Plot of the heuristics and the state varibales for one simulation run:
%   This file shows the distribution of the used heuritics for one
%   simulation run of the NKM with bounded rationality and shows the
%   realization of inflation, the output gap and the nominal interest rate.

clear;
clc;
rng(100);
%% I: One simulation run

T = 300;        % total number of periods 
del_pi= 1.5;    % how strong the central bank reacts to deviation in infaltion 
del_x = 0.5;    % how strong the central bank reacts to deviation in ouput 
eta = 0.75;     % asynchronous updating parameter
phi = 10;       % intensity of choice

% Define the shock process
std_mu = 0.15; std_kap = 0.15; std_nu = 0.15; % std. deviation of the shocks
shock = [normrnd(0,std_mu,[1,T]);normrnd(0,std_kap,[1,T]);normrnd(0,std_nu,[1,T])];
ex_shock = 0; 

% load the function
[pi_t,x_t,i_t,ome_t_pi_tar,ome_t_pi_ext,ome_t_pi_ada,...
    ome_t_pi_laa,ome_t_x_tar,ome_t_x_ext,ome_t_x_ada,ome_t_x_laa,x_av] = nkmbr_function_contemp_final(del_pi,del_x,T,shock,ex_shock,eta,phi);

%% III: Plots
start=1;
period = start:T; 

figure('NumberTitle','off','Name','Inflation time path and heuristics')
subplot(2,1,2)
fill([period, fliplr(period)],[ones(1,T-start+1), zeros(1,T-start+1)],[0.5 0.5 0.5])
hold on 
fill([period, fliplr(period)],[(1-ome_t_pi_laa(period)),zeros(1,T-start+1)],[0.7 0.7 0.7])
hold on
fill([period, fliplr(period)],[(1-ome_t_pi_laa(period)-ome_t_pi_ada(period)),zeros(1,T-start+1)],'w')
hold on
fill([period, fliplr(period)],[(1-ome_t_pi_laa(period)-ome_t_pi_ada(period) - ome_t_pi_ext(period)),zeros(1,T-start+1)],'k')
title('Inflation Heuristics');xlabel('quater');ylabel('\omega_t^\pi');legend('laa','ada','ext','tar')

subplot(2,1,1)
plot(period,pi_t(period),'k','LineWidth',2)
title('Inflation');xlabel('quater');ylabel('\pi_t')

figure('NumberTitle','off','Name','Output gap time path and heuristics')
subplot(2,1,1)
plot(period,x_t(period),'k','LineWidth',2)
hold on 
plot(period,x_av(period),'r','LineWidth',3)
title('Output Gap');xlabel('quater');ylabel('x_t')

subplot(2,1,2)
fill([period, fliplr(period)],[ones(1,T-start+1), zeros(1,T-start+1)],[0.5 0.5 0.5])
hold on 
fill([period, fliplr(period)],[(1-ome_t_x_laa(period)),zeros(1,T-start+1)], [0.7 0.7 0.7])
hold on
fill([period, fliplr(period)],[(1-ome_t_x_laa(period)-ome_t_x_ada(period)),zeros(1,T-start+1)],'w')
hold on
fill([period, fliplr(period)],[(1-ome_t_x_laa(period)-ome_t_x_ada(period) - ome_t_x_ext(period)),zeros(1,T-start+1)],'k')
title('Output Gap Heuristics');xlabel('quater');ylabel('\omega_t^x');legend('laa','ada','ext','tar')
hold off