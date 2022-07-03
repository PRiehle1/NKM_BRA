%========NEW KEYNESIAN MODEL WITH BOUNDED RATIONALITY%======== 
% This function describes the New Keynesian Model with bounded rationality
% where the agents use  diffrent types of heuristics to form their
% expectations about the future evolution of the infaltion rate and the
% output gap

%=====================Define the function%=================================
function  [pi,x,i,ome_pi_tar,ome_pi_ext,ome_pi_ada,...
    ome_pi_laa,ome_x_tar,ome_x_ext,ome_x_ada,ome_x_laa]...
    = nkmbr_function_backward_final(del_pi,del_x,T,shock,eta)
%% This function derives the time dependent path of inflation, output gap and the interest rate 
%  We consider a NKM with bounded rationality, where the expected values of
%  the state variables depend upon 4 ad hoc given heuristics. 
%  The IS and PC are purely forward looking and the Taylor rule is based on
%  the values of infaltion and output gap of the past period 

%% I:Define the parameters
% paramter for the PC equation
bet = 0.99;
gam = 0.33;

% paramter for the IS eqaution
sig = 1;

% parmaters for the heuristic
alp_pi = 0.2;   % degree of extrapolation infaltion (in case of >0 the observed trend continues), (in case of <0 we condider a reversal of the trend)
alp_x = 0.2;    % degree of extrapolation output
thet_ada = 0.65;
thet_laa = 0.5;


zet = 0.5;      % memory parameter between 0 and 1 
phi = 100;      % intensity of choice paramter(degree of rationality); phi =0 all heuristics are equaly weighted 

% target values 
pi_s = 0;   % Infaltion target
x_b = 0;    % ouput target
i_s = 0;    % interest rate target

%% II: Preallocation 
% state variables
pi = zeros(1,T);  % Inflation rate
x = zeros(1,T);   % Output gap 
i = zeros(1,T);   % Interest rate

% heuristics
exp_pi_tar = zeros(1,T);  % targters
exp_pi_ext = zeros(1,T);  % extrapolators
exp_pi_ada = zeros(1,T);  % Adaptive rule
exp_pi_laa = zeros(1,T);  % Anchoring and adjustment rule
exp_pi = zeros(1,T);      % Overall Inflation expectation  

exp_x_tar = zeros(1,T);  % targters
exp_x_ext = zeros(1,T);  % extrapolators
exp_x_ada = zeros(1,T);  % Adaptive rule
exp_x_laa = zeros(1,T);  % Anchoring and adjustment rule
exp_t_x = zeros(1,T);      % Overall Output gap expectation

% atractivity values
A_pi_tar = zeros(1,T);  % targters (inflation)
A_pi_ext = zeros(1,T);  % extrapolators (inflation)
A_pi_ada = zeros(1,T);  % Adaptive rule (inflation)
A_pi_laa = zeros(1,T);  % Anchoring and adjustment rule (inflation)
A_x_tar = zeros(1,T);   % targters (output gap)
A_x_ext = zeros(1,T);   % extrapolators (output gap)
A_x_ada = zeros(1,T);   % Adaptive rule (output gap)
A_x_laa = zeros(1,T);   % Anchoring and adjustment rule (output gap)

% fractions
ome_pi_tar = zeros(1,T);  % targters (inflation)
ome_pi_ext = zeros(1,T);  % extrapolators (inflation)
ome_pi_ada = zeros(1,T);  % Adaptive rule (inflation)
ome_pi_laa = zeros(1,T);  % Anchoring and adjustment rule (inflation)
ome_x_tar = zeros(1,T);   % targters (output gap)
ome_x_ext = zeros(1,T);   % extrapolators (output gap)
ome_x_ada = zeros(1,T);   % Adaptive rule (output gap)
ome_x_laa = zeros(1,T);   % Anchoring and adjustment rule (output gap)
%% III: Inital  values
% state variables
pi(1,1:2) = 0;    % In the first two periods inflation equals zero
x(1,1:2) = 0;     % In the first two periods output equals zero
i(1,1:2) = 0;     % In the first two periods interest equals zero

% atractivity values
A_pi_tar(1,1:2) = 0;  % targeters (inflation)
A_pi_ext(1,1:2) = 0;  % extrapolators (inflation)
A_pi_ada(1,1:2) = 0;  % Adaptive rule (inflation) 
A_pi_laa(1,1:2) = 0;  % Anchoring and adjustment rule (inflation)
A_x_tar(1,1:2) = 0;   % targters (output gap)
A_x_ext(1,1:2) = 0;   % extrapolators (output gap)
A_x_ada(1,1:2) = 0;   % Adaptive rule (output gap) 
A_x_laa(1,1:2) = 0;   % Anchoring and adjustment rule (output gap)

% fractions
ome_pi_tar(1,1:2) = 1/4;  % targters (inflation)
ome_pi_ext(1,1:2) = 1/4;  % extrapolators (inflation)
ome_pi_ada(1,1:2) = 1/4;  % Adaptive rule (inflation) 
ome_pi_laa(1,1:2) = 1/4;  % Anchoring and adjustment rule (inflation)
ome_x_tar(1,1:2) = 1/4;   % targters (output gap)
ome_x_ext(1,1:2) = 1/4;   % extrapolators (output gap)
ome_x_ada(1,1:2) = 1/4;   % Adaptive rule (output gap) 
ome_x_laa(1,1:2) = 1/4;   % Anchoring and adjustment rule (output gap)
% 

%% III: Loop
for t = 3:T
    
%   average values
    pi_av = mean(pi(1:t-1)); % average of the inflation rate up to time t-1
    x_av = mean(x(1:t-1));   % average of the output gap up to time t-1
    
%   attractivity value for using a certain heuristic:

%   Infaltion
    [A_pi_tar(t),A_pi_ext(t),A_pi_ada(t),A_pi_laa(t)] = atracval_function(A_pi_tar(t-1),A_pi_ext(t-1),A_pi_ada(t-1), ...
                                                                                  A_pi_laa(t-1), exp_pi_tar(t-2),exp_pi_ext(t-2), ...
                                                                                  exp_pi_ada(t-2),exp_pi_laa(t-2),pi(t-1),zet);

%  Output 
    [A_x_tar(t),A_x_ext(t),A_x_ada(t),A_x_laa(t)] = atracval_function(A_x_tar(t-1),A_x_ext(t-1),A_x_ada(t-1), ...
                                                                                  A_x_laa(t-1), exp_x_tar(t-2),exp_x_ext(t-2), ...
                                                                                  exp_x_ada(t-2),exp_x_laa(t-2),x(t-1),zet);
%   fractions of agents who use a certain heuristic  (ome)
%   Infaltion:
    [ome_pi_tar(t),ome_pi_ext(t),ome_pi_ada(t),ome_pi_laa(t)] = frac_function(A_pi_tar(t),A_pi_ext(t),A_pi_ada(t),A_pi_laa(t),...
                                                                        ome_pi_tar(t-1),ome_pi_ext(t-1),ome_pi_ada(t-1),ome_pi_laa(t-1),eta,phi);    
%   Output:
    [ome_x_tar(t),ome_x_ext(t),ome_x_ada(t),ome_x_laa(t)] = frac_function(A_x_tar(t),A_x_ext(t),A_x_ada(t),A_x_laa(t),...
                                                                        ome_x_tar(t-1),ome_x_ext(t-1),ome_x_ada(t-1),ome_x_laa(t-1),eta,phi);    


%   state matrices
    a_pi = ome_pi_ext(t)*(1+alp_pi)+ome_pi_ada(t)*thet_ada+ome_pi_laa(t)*(1+thet_laa);
    b_pi = ome_pi_ext(t)*alp_pi+ome_pi_laa(t);
    c_pi = ome_pi_ada(t)*(1-thet_ada);
    d_pi = ome_pi_laa(t)*thet_laa;
    
    a_x = ome_x_ext(t)*(1+alp_x)+ome_x_ada(t)*thet_ada+ome_x_laa(t)*(1+thet_laa);
    b_x = ome_x_ext(t)*alp_x+ome_x_laa(t);
    c_x = ome_x_ada(t)*(1-thet_ada);
    d_x = ome_x_laa(t)*thet_laa;
    
    
    A = [-a_pi sig*(1-a_x);(1-bet*a_pi) -gam];
    
    B = [-b_pi-del_pi -sig*b_x-del_x;-bet*b_pi 0];
    
    C = [c_pi sig*c_x;bet*c_pi 0];
        
    D = [d_pi sig*d_x;bet*d_pi 0];
    

    v_t_1 = [pi(t-1);x(t-1)];
    v_t = A\B*v_t_1 + A\C*[exp_pi_ada(t-1);exp_x_ada(t-1)] + A\D*[pi_av;x_av] + A\[sig*shock(1,t)-shock(2,t);shock(3,t)];   
    
    pi(1,t) = v_t(1);
    x(1,t) = v_t(2); 
    i(1,t) = i_s + del_pi*pi(1,t) + del_x*x(1,t) + shock(2,t);

%   heuristics for inflation expextation at time t about infaltion in t+1
    exp_pi_tar(t) = pi_s;
    exp_pi_ext(t) = pi(t) + alp_pi*(pi(t) - pi(t-1));
    exp_pi_ada(t) = thet_ada*pi(t) + (1-thet_ada)*exp_pi_ada(t-1);
    exp_pi_laa(t) = thet_laa*(pi(t) + pi_av) + (pi(t) - pi(t-1));
%   heuristics for output gap expextation at time t about infaltion in t+1
    exp_x_tar(t) = x_b;
    exp_x_ext(t) = x(t) + alp_x*(x(t) - x(t-1));
    exp_x_ada(t) = thet_ada*x(t) + (1-thet_ada)*exp_x_ada(t-1);
    exp_x_laa(t) = thet_laa*(x(t) + x_av) + (x(t) - x(t-1)); 

%   Overall Expectation formation
    exp_pi(t) = ome_pi_tar(t)*exp_pi_tar(t) + ome_pi_ext(t)*exp_pi_ext(t) + ome_pi_ada(t)*exp_pi_ada(t) + ome_pi_laa(t)*exp_pi_laa(t);
    exp_t_x(t) = ome_x_tar(t)*exp_x_tar(t) + ome_x_ext(t)*exp_x_ext(t) + ome_x_ada(t)*exp_x_ada(t) + ome_x_laa(t)*exp_x_laa(t);    
end
% Save Parameters in a file
% save('NKMBR_cntemp_Par.mat','pi_t','x_t');
end