close all
clear all
clc
global kp1 kp2 ki1 ki2 Ts
global km kd cv cw M J eam ead
global kp3 kp4  

%% System properties
km = 1; kd = 1 ; M = 1; J = 0.1; cv = 0.1; cw = 0.1;

%% Control gain
kp1 = 1; kp2 = 1; kp3 = 1.6; kp4 = 5;
ki1 = 1; ki2 = 0.2;

%% Time
Ts = 0.1; % controller sampling time
Ti = 0;
Tf = 100;
T_sim = Ti :Ts: Tf;

%% System properties
X = [0;0;0;0;0]; % [x y theta v omega]
row_size = 2;
barr = zeros(row_size,4);
isLast = false;
horizontal = 0;

%% Iteration
N = length(T_sim);
for k = 1:N-1
    
    ti_k(k) = T_sim(k);
    tf_k(k) = T_sim(k+1);
    tsim_k(:,1) = ti_k(k):Ts:tf_k(k);

    %% Tracking control
    meas = X;
    if k == 1;
        barr_type = 3;
    end
    [xd,yd,barr_type,isLast] = pathplanning(barr, ti_k(k), barr_type);
    [vd,wd,thtd,horizontal] = tracking_control(xd,yd,meas,isLast,horizontal);
        
    %% Motion control
    ev = vd-meas(4);
    ew = wd-meas(5);
    [eam,ead] = motion_control(ev,ew); 
    
    %% Dynamics
    Xinit = X;
    Xtemp = ode4(@dynamics,tsim_k,Xinit);
    X = Xtemp(end,:)';

    if X(3) > pi
        X(3) = X(3) - 2*pi;
    elseif X(3) < -pi
        X(3) = X(3) + 2*pi;
    end

    %% Results
    t_t(k,1) = ti_k(k);
    X_t(k,:) = X;
    Xd_t(k,:) = [xd,yd,thtd];
    e_t(k,:) = [ev,ew];
    
end

%% Plotting
figure(1)

subplot(3,1,1)
plot(t_t, X_t(:,1), t_t, Xd_t(:,1)); 
hold on
xlabel('time(s)');
ylabel('x');
grid on

subplot(3,1,2)
plot(t_t, X_t(:,2), t_t, Xd_t(:,2)); 
hold on
xlabel('time(s)');
ylabel('y');
grid on

subplot(3,1,3)
plot(t_t, 180*X_t(:,3)/pi, t_t, 180*Xd_t(:,3)/pi); 
hold on
xlabel('time(s)');
ylabel('theta');
grid on
