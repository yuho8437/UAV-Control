close all
clear all
clc

%% Torque
% 프로펠러에 의해 정해지는 torque값
% 원래는 모터 계수와 전압으로 계산해야 하는 값이지만, 간단하게 T로 적었음
global T

%% System properties
global M I r
M = 0.9; % mass: 0.9kg
I = 0.008; % rotational inertia: 0.008
r = 0.15; % length of rod: 0.15m

%% Control gain
global kp_in ki_in kd_in
global kp_out ki_out kd_out
global phid Ts
kp_in = 0.2; ki_in = 3; kd_in = 0; % inner_loop gain
kp_out = 4; ki_out = 2; kd_out = 0.5; % outer_loop gain

%% Time
Ts = 0.004; 
Ti = 0; 
Tf = 10;
T_sim = Ti :Ts: Tf;

%% System properties
X = [0;0]; % [phi phi_dot]

%% Iteration
N = length(T_sim);
for k = 1:N-1

    ti_k(k) = T_sim(k); tf_k(k) = T_sim(k+1);
    tsim_k(:,1) = ti_k(k):Ts:tf_k(k);
    meas = X;
    
    %% outer_controller
    sp = pi/6; % phid (desired phi) is 60 degree
    if (k> 750)
        sp = 0;
    end
    if (k> 1500)
        sp = -pi/6;
    end
    [phi_dotd] = outer_controller(meas(1), sp);
    
    %% inner_controller
    ephi_dot = phi_dotd - meas(2);
    [T] = inner_controller(ephi_dot);
    
    %% Dynamics
    Xinit = X;
    Xtemp = ode4(@dynamics,tsim_k,Xinit);
    X = Xtemp(end,:)';
    
    %% Results
    t_t(k,1) = ti_k(k);
    X_t(k,:) = X;
    pd_t(k,:) = phid;
    e_t(k,:) = ephi_dot;
    
end

%% Plotting
figure(1);
plot(t_t, X_t(:,1), t_t, pd_t(:,1),'linewidth',2); 
hold on
grid on
xlabel('time (s)');
ylabel('phi (rad)');
xlim([0,10]); ylim([-1,1]);

%% Inner loop: No gain
figure(2);
subplot(2,2,1)
N = [1 0];
D = [I 0 -(M*r*9.81)];
SYS = tf(N,D);
rlocus(N,D);

%% Inner loop: Open
subplot(2,2,2)
N1 = [kp_in ki_in];
D1 = [1 0];
N2 = [1 0];
D2 = [I 0 -(M*r*9.81)];
N = conv(N1,N2);
D = conv(D1,D2);
SYS = tf(N,D);
rlocus(N,D);

%% Inner loop: Close
subplot(2,2,3)
N = [0.2 3 0];
D = [I 0.2 3-(M*r*9.81) 0];
SYS = tf(N,D);
rlocus(N,D);
subplot(2,2,4);
bode(N,D); 
grid on

%% Outer loop: No gain
figure(3);
subplot(2,2,1)
N = [0.2 3 0];
D = [I 0.2 3-(M*r*9.81) 0 0];
SYS = tf(N,D);
rlocus(N,D);

%% Outer loop: Open
subplot(2,2,2)
N1 = [kd_out kp_out ki_in];
D1 = [1 0];
N = conv(N1,N);
D = conv(D1,D);
SYS = tf(N,D);
rlocus(N,D);


%% Inner loop: Close
subplot(2,2,3)
N = [0.1 2.3 12.6 9 0];
D = [I 0.3 3.976 12.6 9 0];
SYS = tf(N,D);
rlocus(N,D);

subplot(2,2,4);
bode(N,D); 
grid on
