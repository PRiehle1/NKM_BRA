%% Impulse Response Function (IRF)
% In this part the impact of a exgenous increase on the cost shock is
% analiezed. Therfore in period 40 (20 periods brun in phase) we add one standard deviation of the
% shock process to the realization and compare it to the case without a
% shock
clear;
clc;
rng;
%% I: Many simulation runs 
T =120;         % length of one simulation
nbrsim = 100; % number of simulation runs 
del_pi = 1.5;   % sensitivity of the central bank to changes in inflation
del_x = 0.5;    % sensitivity of the central bankt to changes in the output gap
eta = 0.5;     % asynchronous updating parameter 
phi = 4;        % intensity of choice (different to standard phi for stability reasons)

% Define the shock process
std_mu = 0.15; std_kap = 0.15; std_nu = 0.15;   % standard deviation of the shocks
ex_shock = [0 0.3];                             % exogenous shock in t = 40;

% Preallocation
pi_t = zeros(nbrsim,T);
pi_s_t = zeros(nbrsim,T);
pi_t_av = zeros(1,T);

x_t = zeros(nbrsim,T);
x_s_t = zeros(nbrsim,T);
x_t_av = zeros(1,T);

i_t = zeros(nbrsim,T);
i_s_t = zeros(nbrsim,T);
i_t_av = zeros(1,T);


parfor i = 1:nbrsim
    shock = [normrnd(0,std_mu,[1,T]);normrnd(0,std_kap,[1,T]);normrnd(0,std_nu,[1,T])];
    s = rng; 
    [pi_t(i,:),x_t(i,:),i_t(i,:)] = nkmbr_function_contemp_final(del_pi,del_x,T,shock,ex_shock(1),eta,phi);
    rng(s); % by this the same shocks appear for both simmulations
    [pi_s_t(i,:),x_s_t(i,:),i_s_t(i,:)] = nkmbr_function_contemp_final(del_pi,del_x,T,shock,ex_shock(2),eta,phi); % here the exogenous shock occurs
end    



%% II: Derrive the average impulse response function
for i = 1:T
    % Part one: Inflation
    pi_diff(:,i) = pi_s_t(:,i) - pi_t(:,i); 
    pi_av(1,i) = mean(pi_diff(:,i));
    var_pi(1,i) = var(pi_diff(:,i));
    
    % Part two: Output gap
    x_diff(:,i) = x_s_t(:,i) - x_t(:,i); 
    x_av(1,i) = mean(x_diff(:,i));
    var_x(1,i) = var(x_diff(:,i));
    
    % Part three: Interest rate
    i_diff(:,i) = i_s_t(:,i) - i_t(:,i); 
    i_av(1,i) = mean(i_diff(:,i));
    var_i(1,i) = var(i_diff(:,i));  
    
end

sd_pi = sqrt(var_pi);
sd_x = sqrt(var_x);
sd_i = sqrt(var_x);



%% IV: Plots
t = 40:T;

figure('NumberTitle','off','Name','Impulse Response Functions')
subplot(3,1,1)
plot(t,pi_av(t),'k','LineWidth',2)
hold on
plot(t,pi_av(t)+2*sd_pi(t),':k','LineWidth',1)
hold on
plot(t,pi_av(t)-2*sd_pi(t),':k','LineWidth',1)
hold on
hline = refline(0,0);
hline.Color = 'k';
hline.LineStyle = '--';
xlabel('quater');ylabel('Level');title('mean IRF: Inflation(\pi_t)');
axis([60 75 -0.3 0.5])

subplot(3,1,2)
plot(t,x_av(t),'k','LineWidth',2)
hold on
plot(t,x_av(t)+2*sd_x(t),':k','LineWidth',1)
hold on
plot(t,x_av(t)-2*sd_x(t),':k','LineWidth',1)
hold on
hline = refline(0,0);
hline.Color = 'k';
hline.LineStyle = '--';
xlabel('quater');ylabel('Level');title('mean IRF: Output Gap(x_t)');
axis([60 75 -0.5 0.3])


subplot(3,1,3)
plot(t,i_av(t),'k','LineWidth',2)
hold on
plot(t,i_av(t)+1*sd_i(t),':k','LineWidth',1)
hold on
plot(t,i_av(t)-1*sd_i(t),':k','LineWidth',1)
hold on
hline = refline(0,0);
hline.Color = 'k';
hline.LineStyle = '--';
xlabel('quater');ylabel('Level');title('mean IRF: Interest Rate(i_t)');
axis([60 75 -0.2 0.5])  
set(findobj(gcf,'type','axes'),'FontName','TimesNewRoman','FontSize',10,'FontWeight','Bold', 'LineWidth', 2);