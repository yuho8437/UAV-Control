function [eam,ead] = motion_control(ev,ew)
global Ts kp1 kp2 ki1 ki2
persistent evi ewi

%% Initializing
if isempty(evi)
    evi=0;
    ewi=0; 
end

%% Numerical integration of error
evi = evi + Ts * ev;
ewi = ewi + Ts * ew;

%% Generating eam/ead
eam= kp1 * ev + ki1 * evi;
ead= kp2 * ew + ki2 * ewi;

end